const fetchUser = require('../middlewares/fetchUser');
const getFeed = require('./Search/getFeed');
const searchPosts = require('./Search/searchPosts');
const searchUser = require('./Search/searchUser');

const router = require('express').Router();

//search for posts

router.get('/posts', fetchUser, searchPosts)


//search for users
router.get('/users', fetchUser, searchUser);

//getting feed
router.get('/feed', fetchUser, getFeed);
module.exports = router;