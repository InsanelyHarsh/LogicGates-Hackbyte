const User = require('../../models/User')
const bcryptjs = require('bcryptjs')
const jwt = require('jsonwebtoken')
const secKey = process.env.SECKEY

const changePassword = async (req, res) => {
    try {
        const authToken = req.headers.authtoken;
        // console.log(req.headers)
        const id = jwt.verify(authToken, secKey).id;
        const { oldPassword, newPassword } = req.body;
        console.log(id, oldPassword, newPassword)
        const user = await User.findById(id).select("+password");
        console.log(user)
        if (!user) {
            return res.status(404).json({ success: false, message: "user not found" });
        }
        const isValid = await bcryptjs.compare(oldPassword, user.password);
        if (!isValid) {
            return res.status(401).json({ success: false, message: "please enter correct password" });
        }
        const newSecPassword = bcryptjs.hashSync(newPassword, 10);
        user.password = newSecPassword;
        updatedUser = User.findByIdAndUpdate(id, { password: newSecPassword }, { new: true }).then((updatedUser) => {
            if (!updatedUser) {
                return res.status(404).json({ success: false, message: "User not found" })
            }
            return res.status(200).json({ success: true, message: "Password Changed Successfully", user });
        }).catch((err) => {
            return res.status(500).json({ success: true, message: "Password can't be changed", error: err.message })
        })


    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal server error", error: err.message })
    }


}

module.exports = changePassword;