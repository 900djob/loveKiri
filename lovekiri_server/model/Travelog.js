const mongoose = require("mongoose");

const travelogScheme = mongoose.Schema({
  location_name: {
    type: String,
    trim: false,
    maxLength: 120,
    required: true
  },
  address: {
    type: String,
    trim: false,
    required: true,
  },
  lat: {
    type: Number,
    required: true
  },
  lng: {
    type: Number,
    required: true
  },
  category: {
    type: String,
    required: true,
  },
  date_time: {
    type: Number,
    required: true,
  },
  rate: {
    type: Number,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  img: {
    type: String
  }
});


const Travelog = mongoose.model('Travelog', travelogScheme);
module.exports = { Travelog };
