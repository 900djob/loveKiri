const mongoose = require("mongoose");

const travelogScheme = mongoose.Schema({
  logId: {
    type : Number,
    unique: true,
    index: true
  },
  locationName: {
    type: String,
    trim: false,
    maxLength: 120,
    required: true
  },
  adress: {
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
  description: {
    type: String,
    required: true,
  },
  rate: {
    type: Number,
    required: true,
  },
  imgUrl: {
    type: String
  }
});


const Travelog = mongoose.model('Travelog', travelogScheme);
module.exports = { Travelog };
