const User = require('../../models/User')
const { validationResult } = require('express-validator')

const editUser = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(403).json({ success: false, errors })
        }
        const id = req.headers.id;
        const editedUser = req.body;
        const user = await User.findByIdAndUpdate(id, editedUser, { new: true }).then((user) => {
            if(!user){
                return res.status(404).json({success:false, message:"User not found"})
            }
            return res.status(200).json({ success: true, message: "User Edited Successfuly", user });
        }).catch((err) => {
            return res.status(500).json({ success: true, message: "User can't be edited", error: err.message })
        })

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message })
    }
}
module.exports = editUser;