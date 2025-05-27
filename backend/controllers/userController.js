const db = require('../db');

exports.getProfile = (req, res) => {
const id = req.params.id;
db.query('SELECT id, name, birth, email FROM users WHERE id = ?', [id], (err, results) => {
if (err || results.length === 0) return res.status(404).json({ message: 'Usuário não encontrado' });
res.json(results[0]);
});
};

exports.updateProfile = (req, res) => {
const id = req.params.id;
const { name, birth, email } = req.body;

db.query('UPDATE users SET name = ?, birth = ?, email = ? WHERE id = ?', [name, birth, email, id], (err) => {
if (err) return res.status(500).json({ error: err });
res.json({ message: 'Perfil atualizado' });
});
};

exports.deleteAccount = (req, res) => {
const id = req.params.id;
db.query('DELETE FROM users WHERE id = ?', [id], (err) => {
if (err) return res.status(500).json({ error: err });
res.json({ message: 'Conta deletada' });
});
};