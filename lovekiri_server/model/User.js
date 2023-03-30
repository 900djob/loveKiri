const mongoose = require("mongoose");
const bcrypt = require("bcrypt");
const saltRounds = 10;
const jwt = require("jsonwebtoken");

const userSchema = mongoose.Schema({
  login_type: {
    type: String,
    trim: true,
    required: true
  },
  name: {
    type: String,
    trim: true,
    maxLength: 30,
    required: true
  },
  email: {
    type: String,
    trim: true,
    required: true,
    unique: true,
  },
  sso_id: {
    type: String,
    required: true
  },
  image: {
    type: String
  }
});

const User = mongoose.model('User', userSchema);
module.exports = { User };
