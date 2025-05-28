const express = require("express");
const usuarioController = require("../controllers/usuarioController");
const auditoriaController = require("../controllers/auditoriaController");

const router = express.Router();

//rotas crud usuario
router.post("/usuario", usuarioController.criarUsuario);
router.get("/usuario/:email", usuarioController.buscarUsuarioPorEmail);

//rotas auditoria
router.get("/logs", auditoriaController.listarLogsAuditoria);

module.exports = router;