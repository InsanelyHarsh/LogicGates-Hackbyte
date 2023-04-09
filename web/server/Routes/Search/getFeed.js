const User = require('../../models/User')
const Post = require('../../models/Post')
const ContentBasedRecommender = require('content-based-recommender')

const gettingPosts = (posts, similarDocuments) => {
    result = [];
    for (let i = 0; i < similarDocuments.length; i++) {
        for (let j = 0; j < posts.length; j++) {
            console.log(similarDocuments[i].id, posts[j].id);
            if (similarDocuments[i].id === posts[j].ind) {
                result.push(posts[i]);
                break;
            }
        }
    }
    return result;
}

const getFeed = async (req, res) => {
    try {
        const recommender = new ContentBasedRecommender({
            minScore: 0.1,
            maxSimilarDocuments: 100
        });
        id = req.user.id;
        const user = await User.findById(id);
        let userTags = user.tags;
        userTags = userTags.concat(user.preferences);
        const randomInd = Math.floor((Math.random() * 1000) % userTags.length);
        const query = "epic";
        const posts = await Post.find();
        let documents = [];
        let queryPost = [];
        for (let i = 0; i < posts.length; i++) {
            posts[i].ind = (i + 1).toString();
            let curr = {
                id: (i + 1).toString(),
                content:

                    posts[i].toString()
            };
            if (posts[i].tags.includes(query)) {
                queryPost.push(curr)
            }
            documents.push(curr);
        }
        recommender.train(documents);
        const similarDocuments = recommender.getSimilarDocuments(queryPost[0].id, 0, 100);
        result = gettingPosts(posts, similarDocuments);

        return res.status(200).json({ success: true, result });


    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message });
    }

}
module.exports = getFeed;