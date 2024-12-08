const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// 注册路由
router.post('/register', userController.register);

module.exports = router; 