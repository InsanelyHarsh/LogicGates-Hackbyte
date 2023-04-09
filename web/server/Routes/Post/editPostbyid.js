const Post = require('../../models/Post')

const editPostById = async (req, res) => {
    try {
        const id = req.user.id;
        const user = req.user;
        const editedPost = req.body;
        const post = await Post.findById(id);
        console.log(post.owner.toHexString())
        if(user.id !== post.owner.toHexString()){
            return res.status(403).json({success:false, message:"Access Denied"});
        }
        Post.findByIdAndUpdate(id,editedPost,{new:true}).then((p)=>{
            return res.status(200).json({success:true, message:"Post edited Successfully"});
        }).catch(err=>{
            return res.status(500).json({success:false, message:"Internal server Error"});
        })

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal server Error", error: err.message });
    }

}
module.exports = editPostById;