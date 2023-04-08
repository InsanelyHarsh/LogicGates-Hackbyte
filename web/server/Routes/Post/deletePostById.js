
const Post = require('../../models/Post');
const User = require('../../models/User');


const deletePostById = async (req, res) => {
    try {
        const id = req.headers.id;
        console.log(id)
        const user = req.user;
        const post = await Post.findById(id);
        if (!post) {
            return res.status(404).json({ success: false, message: "Post not found" })
        }
        if (post.owner.toHexString() !== user.id) {
            return res.status(403).json({ success: false, message: "Acceess denied" });
        }
        await Post.findByIdAndDelete(id).then(async (post) => {
            let currUser = await User.findById(user.id);
            let remainingPosts = [];
            for (let i = 0; i < currUser.posts.length; i++) {
                if (currUser.posts[i].toHexString() === id) {
                    continue;
                }
                remainingPosts.push(currUser.posts[i]);
            }
            currUser.posts = remainingPosts;
            await currUser.save().catch((err) => {
                return res.json({ success: false, message: "Internal server error", error: err.message })
            })
            return res.status(200).json({ success: true, message: "Post deleted Successfully" });
        }).catch((err) => {
            return res.status(500).json({ success: true, message: "Internal server error", error: err.message })
        })

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error" });
    }

}
module.exports = deletePostById;