const db = require('../../config/db'); // Ajuste esse caminho conforme seu arquivo de conexão

// Função para registrar uma nova temperatura
async function saveTemperature(value, timestamp, userId) {
  const query = 'INSERT INTO temperatures (value, timestamp, user_id) VALUES (?, ?, ?)';
  const params = [value, timestamp, userId];

  return new Promise((resolve, reject) => {
    db.query(query, params, (err, result) => {
      if (err) return reject(err);
      resolve(result);
    });
  });
}

// Função para buscar as últimas temperaturas
async function getRecentTemperatures(userId, limit = 10) {
  const query = 'SELECT * FROM temperatures WHERE user_id = ? ORDER BY timestamp DESC LIMIT ?';

  return new Promise((resolve, reject) => {
    db.query(query, [userId, limit], (err, results) => {
      if (err) return reject(err);
      resolve(results);
    });
  });
}

// Exporta os métodos do serviço
module.exports = {
  saveTemperature,
  getRecentTemperatures,
};