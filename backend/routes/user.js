const express = require('express');
const router = express.Router();
const { getProfile, updateProfile, deleteAccount } = require('../controllers/userController');

router.get('/:id', getProfile);
router.put('/:id', updateProfile);
router.delete('/:id', deleteAccount);

module.exports = router;