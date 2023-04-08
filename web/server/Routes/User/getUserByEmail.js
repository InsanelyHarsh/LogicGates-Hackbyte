const User = require('../../models/User')
const getUserByEmail =async (req, res) => {
    try {
        const email = req.headers.email.toLowerCase();
        const user =await User.findOne({ email });
        if (!user) {
            return res.status(404).json({ success: false, message: "User not found" });
        }
        return res.status(200).json({ success: true, user });

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal server Error" ,error:err.message})
    }


}
module.exports = getUserByEmail;