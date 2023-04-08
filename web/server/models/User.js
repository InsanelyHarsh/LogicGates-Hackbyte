const { Decimal128 } = require('mongodb');
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const UserSchema = new Schema({
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
        type: String,
        required: true,
        select: false
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
            type: Schema.Types.ObjectId,
            ref: "post"
        }
    ],
    userType: {
        type: String,
        required: true
    },
    rating: {
        type: Decimal128

    }
})

module.exports = User = mongoose.model('user', UserSchema);