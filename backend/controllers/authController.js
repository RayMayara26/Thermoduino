const db = require('../db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.register = (req, res) => {
const { name, birth, email, password } = req.body;

bcrypt.hash(password, 8, (err, hash) => {
if (err) return res.status(500).json({ error: err });


const sql = 'INSERT INTO users (name, birth, email, password) VALUES (?, ?, ?, ?)';
db.query(sql, [name, birth, email, hash], (err) => {
  if (err) return res.status(500).json({ error: err });
  res.status(201).json({ message: 'Usuário cadastrado com sucesso' });
});
});
};

exports.login = (req, res) => {
const { email, password } = req.body;

db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
if (err || results.length === 0) return res.status(401).json({ message: 'Credenciais inválidas' });


const user = results[0];
bcrypt.compare(password, user.password, (err, match) => {
  if (!match) return res.status(401).json({ message: 'Senha incorreta' });

  const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '24h' });
  res.json({ token, user: { id: user.id, name: user.name, email: user.email } });
});
});
};

exports.resetPassword = (req, res) => {
const { email, newPassword } = req.body;

bcrypt.hash(newPassword, 8, (err, hash) => {
if (err) return res.status(500).json({ error: err });


db.query('UPDATE users SET password = ? WHERE email = ?', [hash, email], (err) => {
  if (err) return res.status(500).json({ error: err });
  res.json({ message: 'Senha redefinida com sucesso' });
});
});
};