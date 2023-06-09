require('dotenv').config
const cors = require('cors')
const express = require('express');
const ConnectToMongo = require('./db/db');


const app = express();
const PORT = 5000;
ConnectToMongo();
app.use(express.json());
app.use(cors());


app.use('/api/user', require('./Routes/User'));

app.use('/api/post', require('./Routes/Post'));

app.use('/api/search', require('./Routes/Search'));


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