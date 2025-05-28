const Auditoria = require("../models/auditoria");
exports.logAcao = async ({
  id,
  usuario,
  acao,
  data,
}) => {
  await Auditoria.create({
    id,
    usuario,
    acao,
    data,
  });
};