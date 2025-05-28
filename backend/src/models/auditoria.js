module.exports = (sequelize, DataTypes) => {
  const Auditoria = sequelize.define("Auditoria", {
    acao: DataTypes.STRING,
    usuarioId: DataTypes.INTEGER,
    data: DataTypes.DATE
  });

  return Auditoria;
};