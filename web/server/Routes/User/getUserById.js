const User = require('../../models/User')

const getUserById = (req, res) => {
    try {
        const id = req.headers.id;
        const user = User.findById(id);
        if (!user) {
            return res.status(404).json({ success: false, message: "User not found" });
        }
        return res.status(200).json({ success: true, user })
    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal server Error", error: err.message })
    }
}

module.exports = getUserById;