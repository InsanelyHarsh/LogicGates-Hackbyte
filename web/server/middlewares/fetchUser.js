const User = require('../models/User');
const jwt = require('jsonwebtoken')
const secKey = process.env.SECKEY;

const fetchUser = (req, res, next) => {
    try {
        const authToken = req.headers.authtoken;
        if (!authToken) {
            return res.status(400).json({ success: false, message: "authentication failed" })
        }
        const data = jwt.verify(authToken, secKey);
        if (!data) {
            return res.status(400).json({ success: false, message: "authentication failed" })
        }
        req.user = data;
        next();

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error.",error:err.message })
    }
}

module.exports = fetchUser;