const fetchUser = require('../middlewares/fetchUser');
const createPost = require('./Post/createPost');
const deletePostById = require('./Post/deletePostById');
const editPostById = require('./Post/editPostbyid');
const getPostById = require('./Post/getPostById');

const router = require('express').Router()

// @desc get post by id
// @data headers:{id, authToken}
// @access logged in users
router.get('/getpost', fetchUser, getPostById);

// @desc creating a post
// @data {title,link, tag, description}
// @access private
router.post('/create', fetchUser, createPost)

// @desc deleting a post by id
// @data headers: {authToken, id}
// @access owener of post
router.delete('/delete', fetchUser, deletePostById);

// @desc editing a post
// @data {editedPost}
// @access owner of post
router.put('/editpost', fetchUser, editPostById);

module.exports = router;