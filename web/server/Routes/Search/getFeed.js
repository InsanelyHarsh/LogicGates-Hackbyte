const User = require('../../models/User')
const Post = require('../../models/Post')
const ContentBasedRecommender = require('content-based-recommender')


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
        console.log(12)
        console.log(documents);
        recommender.train(documents);
        const similarDocuments = recommender.getSimilarDocuments(queryPost[0].id, 0, 20);
        result = [];

        console.log(similarDocuments);


        return res.status(200).json({ success: true, result: similarDocuments });


    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message });
    }

}
module.exports = getFeed;