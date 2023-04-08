const { Timestamp } = require('mongodb');
const mongoose = require('mongoose')
const Schema = mongoose.Schema;

const PostSchema = new Schema({
    title: {
        type: String,
        required: true
    },
    owner: {
        type: Schema.Types.ObjectId,
        ref: 'user',
        required: true
    },
    link: {
        type: String,
        required: true
    },
    tags: [String],
    likes: {
        type: Number
    },
    comments: [
        {
            CommentOwner: {
                type: Schema.Types.ObjectId,
                ref: 'user',
            },
            comment: {
                type: String,
            }

        }
    ]

}, { Timestamp: true })

module.exports = Post = mongoose.model('post', PostSchema);