require('dotenv').config
const express = require('express');
const ConnectToMongo = require('./db/db');
const socketIO = require('socket.io')


const app = express();
const io = socketIO();
const PORT = 5000;
ConnectToMongo();
app.use(express.json());
app.use('/api/user', require('./Routes/User'))
app.use('/', (req, res) => {
    res.send("HOME")
})
app.listen(PORT, (err) => {
    if (err) {
        console.log("Error in server setup");
    }
    else {
        console.log("Server is listening on PORT", PORT)
        console.log("http://localhost:5000")
    }
})