const { json } = require("express");
const express = require("express");
const router = express.Router();
const { User } = require("../model/User");

router.post("/auth", (req, res) => {
  User.findOne({ email: req.body.email }, (err, user) => {
    if (!user) {
      const newUser = new User(req.body);

      newUser.save((err, user) => {
        if (err) return res.status(400).json({ err });
        return res.status(200).json({ user });
      });
    } else {
      if (err) return res.json({ err });
      return res.status(200).json({ user });
    }
  });
});

module.exports = router;