const Post = require('../../models/Post')
const getPostById = async (req, res) => {
    try {
        const id = req.headers.id;
        const post = await Post.findById(id);
        if (!post) {
            return res.status(404).json({ success: false, message: "Post Not found" });

        }
        return res.status(200).json({ success: true, post });
    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message })
    }
}

module.exports = getPostById;