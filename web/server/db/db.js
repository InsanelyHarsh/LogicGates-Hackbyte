require('dotenv').config()
const mongoose = require('mongoose')

const MONGO_URI = process.env.MONGO_URI;
const ConnectToMongo = async () => {
    try {
        mongoose.set('strictQuery', false);
        await mongoose.connect(MONGO_URI)
            .catch(err => console.error(err.message));
        console.log('MongoDB connected');
    } catch (err) {
        console.error(err.message);
        process.exit(1);
    }
};
module.exports = ConnectToMongo;