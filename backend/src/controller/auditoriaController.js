const db = require("../db");

exports.listarLogsAuditoria = async (req, res) => {
  try {
    
    const logs = await db.findAll({ order: [["createdAt", "DESC"]] });
    res.json(logs);

  } catch (error) {
     res.status(400).json({ error: err.message });
  }
};