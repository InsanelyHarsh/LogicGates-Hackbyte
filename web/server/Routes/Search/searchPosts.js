const Post = require('../../models/Post')


const filter = (posts, searchTags) => {
    let result = [];
    for (let i = 0; i < posts.length; i++) {
        let element = posts[i];
        let currTags = element.tags;
        let count = 0;
        for (let j = 0; j < currTags.length; j++) {
            for (let k = 0; k < searchTags.length; k++) {
                if (element.tags[j] === searchTags[k]) count += 1;
            }
        }
        let curr = {
            weight: count,
            postId: element.id,
            title: element.title
        }
        result.push(curr);

    }
    return result;

}

const searchPosts = async (req, res) => {
    try {
        let searchString = req.headers.searchstring;
        const searchTags = searchString.split(" ");
        const posts = await Post.find();
        const result = filter(posts, searchTags);
        res.status(200).json({ success: true, posts: result })


    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message })
    }

}
module.exports = searchPosts;