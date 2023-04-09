const fetchUser = require('../middlewares/fetchUser');
const searchPosts = require('./Search/searchPosts');

const router = require('express').Router();

//search for posts

router.get('/posts', fetchUser, searchPosts)


module.exports = router;