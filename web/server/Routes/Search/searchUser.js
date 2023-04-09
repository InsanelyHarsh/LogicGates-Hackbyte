
const User = require('../../models/User')

const filter = (users, searchTags) => {
    let result = [];
    for (let i = 0; i < users.length; i++) {
        let element = users[i];
        let currTags = element.tags;
        currTags = currTags.concat(element.preferences);
        currTags = currTags.concat(element.name.split(" "));
        currTags.push(element.username);
        currTags = Array.from(new Set(currTags));
        let count = 0;
        console.log(currTags);
        for (let j = 0; j < currTags.length; j++) {
            for (let k = 0; k < searchTags.length; k++) {
                if (currTags[j]=== searchTags[k]) {
                    count = count + 1;
                }
            }
        }
        let curr = {
            weight: count,
            userId: element.id,
            name: element.name,
            username: element.username
        }
        result.push(curr);

    }

    return result;

}

const searchUser = async (req, res) => {
    try {
        const searchString = req.headers.searchstring;
        const searchTags = searchString.split(" ");
        const users = await User.find({});
        const result = filter(users, searchTags);

        res.status(200).json({ success: true, users: result })

    } catch (err) {
        return res.status(500).json({ success: false, message: "Internal Server Error", error: err.message })
    }

}
module.exports = searchUser;