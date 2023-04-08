const User = require('../../models/User')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { validationResult } = require('express-validator')

const SecKey = process.env.SECKEY;

const createUser = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(403).json({ success: false, errors })
        }
        let data = req.body;
        data.email = data.email.toLowerCase();
        const pass = data.password;
        const seqPass = bcryptjs.hashSync(pass, 10);
        data.password = seqPass;
        const isPresent = await User.find({ $or: [{ email: data.email }, { username: data.username }] });
        if (isPresent.length > 0) {
            return res.status(403).json({ success: false, message: "User already exists with the same email or username" });
        }
        const user = new User(data);
        await user.save().then((user) => {
            authData = {
                id: user._id,
                name: user.name,
                email: user.email,
                username: user.username
            };
            const authToken = jwt.sign(authData, SecKey);
            // console.log(authData)
            res.status(200).json({ success: true, user, authToken });
        }).catch(err => {
            return res.status(500).json({ success: false, message: "User creation failed", error: err });
        })

    }
    catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err })
    }

}
module.exports = createUser;