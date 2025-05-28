const express = require('express');
const router = express.Router();
const usuarioController = require('../controller/usuarioController');
const auth = require('../middleware/auth');

router.post('/', usuarioController.cadastrar);
router.post('/login', usuarioController.login);
router.post('/redefinir', usuarioController.enviarToken);
router.put('/redefinir/:token', usuarioController.redefinirSenha);
router.get('/me', auth, usuarioController.getDados);
router.put('/me', auth, usuarioController.atualizar);
router.delete('/me', auth, usuarioController.deletar);

module.exports = router;