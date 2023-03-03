const express = require("express");
const router = express.Router();
const { User } = require("../model/User");
const { auth } = require("../middleware/auth");
const { OAuth2Client } = require("google-auth-library");

router.get("/auth", auth, (req, res) => {
  res.status(200).json({
    _id: req.user._id,
    type: req.user.type,
    name: req.user.name,
    email: req.user.email,
    image: req.user.image,
    isAuth: true,
  });
});

router.post("/register", (req, res) => {
  const user = new User(req.body);

  user.save((err, userInfo) => {
    if (err) return res.json({ success: false, err });
    return res.status(200).json({ success: true });
  });
});

router.post("/validate", (req, res) => {
  User.findOne({ email: req.body.email }, (err, user) => {
    if (!user) {
      return res.json({
        loginSuccess: false,
        message: "이메일이 유효하지 않습니다.",
      });
    }
  });
})

router.post("/login", (req, res) => {
  User.findOne({ email: req.body.email }, (err, user) => {
    if (!user) {
      return res.json({
        loginSuccess: false,
        message: "이메일이 유효하지 않습니다.",
      });
    }
    user.comparePassword(req.body.password, (err, isMatch) => {
      if (!isMatch)
        return res.json({
          loginSuccess: false,
          message: "비밀번호가 맞지 않습니다.",
        });
      user.generateToken((err, user) => {
        if (err) return res.status(400).send(err);
        res.cookie("x_auth", user.token).status(200).json({
          loginSuccess: true, userId: user._id
        });
      });
    });
  });
});

const client = new OAuth2Client(process.env.CLIENT_ID);

router.post("/googlelogin", (req, res) => {
  const { tokenId } = req.body;

  client
    .verifyIdToken({
      idToken: tokenId,
      audience: process.env.CLIENT_ID,
    })
    .then((response) => {
      const { email_verified, name, email } = response.payload;
      if (email_verified) {
        User.findOne({ email }, (err, user) => {
          if (err) {
            return res.json({
              googleOnSucces: false,
              message: "이메일이 유효하지 않습니다.",
            });
          } else {
            if (user) {
              user.generateToken((err, user) => {
                if (err) {
                  return res.send(err);
                }
                res
                  .cookie("x_auth", user.token)
                  .status(200)
                  .json({ googleOnSucces: true, userId: user._id });
              });
            } else {
              let password = email + process.env.CLIENT_ID;
              let newUser = new User({ name, email, password });

              newUser.save((err, userInfo) => {
                if (err) return res.json({ success: false, err });
                return res.json({ success: true });
              });
            }
          }
        });
      }
    });
});

router.get("/logout", auth, (req, res) => {
  User.findOneAndUpdate(
    { _id: req.user._id },
    { token: "", tokenExp: "" },
    (err, user) => {
      if (err) return res.json({ success: false, err });
      return res.status(200).send({ success: true });
    }
  );
});

module.exports = router;