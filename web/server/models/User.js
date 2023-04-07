const mongoose = require('mongoose')
const schema = mongoose.schema;

const UserSchema = new schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true
    },
    username: {
        type: String,
        required: true,
    }
})

module.exports = Teacher = mongoose.model('user', UserSchema);