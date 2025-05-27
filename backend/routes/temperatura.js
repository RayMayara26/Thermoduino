const express = require('express');
const router = express.Router();
const db = require('../db');

router.post('/', (req, res) => {
const { user_id, temperatura } = req.body;
const sql = 'INSERT INTO temperaturas (user_id, temperatura) VALUES (?, ?)';
db.query(sql, [user_id, temperatura], (err) => {
if (err) return res.status(500).json({ error: err });
res.status(201).json({ message: 'Temperatura registrada' });
});
});

router.get('/:user_id', (req, res) => {
const sql = 'SELECT * FROM temperaturas WHERE user_id = ? ORDER BY data DESC';
db.query(sql, [req.params.user_id], (err, results) => {
if (err) return res.status(500).json({ error: err });
res.json(results);
});
});

module.exports = router;