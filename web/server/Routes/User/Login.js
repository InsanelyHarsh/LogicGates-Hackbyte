const User = require('../../models/User')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken')
const { validationResult } = require('express-validator')
const secKey = process.env.SECKEY;

const Login = async (req, res) => {
    try {
        const errors =  validationResult(req);
        if(!errors.isEmpty()){
            return res.status(403).json({success:false, errors})
        }
        let { email, password } = req.body;
        email = email.toLowerCase();
        const requiredUser = await User.findOne({email}).select("+password");
        if (!requiredUser) {
            return res.status(404).json({ success: false, message: "User with given email doesn't exist." })
        }
        const isValid = await bcryptjs.compare(password, requiredUser.password);
        if (isValid) {
            const authData = {

                id: requiredUser._id,
                name: requiredUser.name,
                email: requiredUser.email,
                username: requiredUser.username
            }
            const authToken = jwt.sign(authData, secKey);
            return res.status(200).json({ success: true, message: "Login successfull", authToken, user: authData });

        }
        return res.status(401).json({ success: false, message: "Unauthorized access" });

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message });
    }
}
module.exports = Login;