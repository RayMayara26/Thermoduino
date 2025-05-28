const express = require('express');
const router = express.Router();
const temperatureController = require('../controller/temperatureController');
const auth = require('../middleware/auth');

router.post('/', auth, temperaturaController.registrar);
router.get('/', auth, temperaturaController.listar);
router.get('/estatisticas', auth, temperaturaController.estatisticas);

module.exports = router;