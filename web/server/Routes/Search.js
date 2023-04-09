const fetchUser = require('../middlewares/fetchUser');
const searchPosts = require('./Search/searchPosts');
const searchUser = require('./Search/searchUser');

const router = require('express').Router();

//search for posts

router.get('/posts', fetchUser, searchPosts)


//search for users
router.get('/users', fetchUser, searchUser);
module.exports = router;