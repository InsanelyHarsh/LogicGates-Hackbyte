const User = require('../../models/User')
const Post = require('../../models/Post')
const recommend = require('collaborative-filter')

const doesExists = (userTags, postTags) => {
    let count = 0;
    for (let i = 0; i < userTags.length; i++) {
        for (let j = 0; j < postTags.length; j++) {
            if (postTags[j] === userTags[i]) {
                count++;
            }
        }
    }
    if (count > 0) return 1;
    else return 0;
}

const createRatingMatrix = (users, posts) => {
    const matrix = [];
    for (let i = 0; i < users.length; i++) {
        let userTags = users[i].tags;
        userTags = userTags.concat(users[i].preferences);

        const curr = [];
        for (let j = 0; j < posts.length; j++) {
            let postTags = posts[i].tags;
            postTags = postTags.concat(posts[i].title.split(" "));
            let isEngaging = doesExists(userTags, postTags);
            curr.push(isEngaging);
        }
        matrix.push(curr);
    }
    return matrix;
}
const getInd = (users, id)=>{
    for(let i =0;i<users.length;i++){
        if(users.id === id) {
            
        }
    }
}

const getFeed = async (req, res) => {
    try {
        id = req.user.id;
        const users = await User.find();
        const posts = await Post.find();
        let ratings = createRatingMatrix(users, posts);

        const coMatrix = recommend.createCoMatrix(ratings,users.length,posts.length);
        const result = recommend.getRecommendations(ratings,coMatrix,id)


    } catch (err) {
        return res.status(500).json({ success: true, message: "Internal Server Error", error: err.message });
    }

}
module.exports = getFeed;