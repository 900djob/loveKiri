const { json } = require("express");
const express = require("express");
const router = express.Router();
const { User } = require("../model/User");

router.post("/auth", (req, res) => {
  const user = req.body;

  User.findOne({ email: req.body.email }, (err, user) => {
    if (!user) {
      const newUser = new User(req.body);

      newUser.save((err, userInfo) => {
        if (err) return res.status(400).json({ success: false, err });
        return res.status(200).json({ success: true, userInfo });
      });
    } else {
      if (err) return res.json({ success: false, err });
      return res.status(200).json({ success: true, user });
    }
  });
});

module.exports = router;