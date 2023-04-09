const express = require('express');
const createUser = require('./User/createUser');
const Login = require('./User/Login');
const { body } = require('express-validator');
const fetchUser = require('../middlewares/fetchUser')
const editUser = require('./User/editUser');
const changePassword = require('./User/changePassword');
const getUserByEmail = require('./User/getUserByEmail');
const updatePreferences = require('./User/updatePreferences');

const router = express.Router();

// @desc create user
// @data {name, email, password, userType}
// @access public
router.post('/create', body('email').isEmail(), body('password').isStrongPassword(), createUser)


// @desc Login user
// @data {email, password}
// @access public
router.post('/login', body('email').isEmail(), Login);

// @desc Edit User
// @data {can be any filed other than password}
// @access private
router.put('/edit', fetchUser,editUser);

// @desc Change Password
// @data {oldPassword, newPassword}
// @access private
router.post('/changepassword', body('oldPassword').isStrongPassword(), body('newPassword').isStrongPassword(), fetchUser,changePassword)

// @desc get user by email
// @data {email}
// @access only to users 
router.get('/getuserbyemail', fetchUser,getUserByEmail)

// @desc update preferences
// @data {preferences:[]}
// @access private
router.put('/updatepreferences', fetchUser, updatePreferences)
module.exports = router