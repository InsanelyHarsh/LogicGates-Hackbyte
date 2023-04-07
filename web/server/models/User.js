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
    },
    password: {
        type: String, required: true
    },
    authToken: {
        type: String,
        required: true
    },
    experience: [{
        company: {
            type: String
        },
        role: {
            type: String
        },
        employer: {
            type: String
        },
        Month: {
            type: Number
        },
        year: {
            type: Number
        }
    }],
    bio: {
        type: String
    },
    preferences: [
        String
    ],
    tags: [String],
    posts: [
        {
            type: schema.types.ObjectId,
            ref: "post"
        }
    ],
    userType: {
        type: String,
        required: true
    },
    rating: {
        type: Float32Array
    }
})

module.exports = User = mongoose.model('user', UserSchema);