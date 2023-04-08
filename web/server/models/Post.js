const mongoose = require('mongoose')
const Schema = mongoose.schema;

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
    createdAt: new Date(0),
    likes: {
        type: number
    }

})

module.exports = Post = mongoose.model('post', PostSchema);