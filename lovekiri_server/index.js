//package import
const express = require("express");
const mongoose = require("mongoose");
const cookieParser = require("cookie-parser");
const cors = require("cors");

const { User } = require("./model/User");
const { Travelog } = require("./model/Travelog");


//init
const app = express();
const port = 4000;
const DB = "mongodb+srv://900djob:rlarhkdtjr1!@lovekiri.vzxk7om.mongodb.net/?retryWrites=true&w=majority";


app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use(cookieParser());
app.use(cors());

mongoose.Promise = global.Promise;
mongoose.set('strictQuery', true);
const db = mongoose
  .connect(DB)
  .then(function () {
    console.log("MongoDB connected")
    User.collection.createIndex({ userId: 1 }, {name: "userId"})
    Travelog.collection.createIndex({ logId: 1 }, {name: "logId"})
  })
  .catch((err) => console.log(err));

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.use("/users", require("./routes/users"));
// app.use("/travelogs", require("./routes/travelogs"));

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});