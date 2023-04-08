
const User = require('../../models/User');

const updatePreferences = async (req, res) => {
    try {
        const id = req.user.id;
        const preferences = req.body.preferences;
        console.log(preferences)
        const user = User.findByIdAndUpdate(id, { preferences: preferences }, { new: true }).then((user) => {
            if (!user) {
                return res.status(404).json({ success: false, message: "user not found" });
            }
            return res.status(200).json({ success: false, message: "Preferences updated Successfully", user });
        }).catch((err) => {
            return res.status(500).json({ success: false, message: "Internal server Error", error: err.message });
        })

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal server Error", error: err.message })
    }

}
module.exports = updatePreferences;