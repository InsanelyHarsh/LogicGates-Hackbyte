const Post = require('../../models/Post');
const User = require('../../models/User')

const createPost = async (req, res) => {

    try {
        const id = req.user.id;
        const user = await User.findById(id);
        if (!user) {
            return res.status(404).json({ success: false, message: "User not found" })
        }
        let post = req.body;
        post.owner = user;
        const newPost = new Post(post);
        await newPost.save().then(async (post) => {
            user.posts.push(post);
            await user.save();
            return res.status(200).json({ success: true, message: "Post created successfully", post });
        }).catch((err) => {
            return res.status(500).json({ success: false, message: "Internal server error", error: err.message });
        })


    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server error", error: err.message });
    }
}

module.exports = createPost;