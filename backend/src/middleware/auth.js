const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
  const token = req.headers['authorization'];
  if (!token) return res.status(401).json({ erro: 'Token não encontrado' });

  try {
    const decoded = jwt.verify(token, 'secreta');
    req.usuarioId = decoded.id;
    next();
  } catch (err) {
    res.status(401).json({ erro: 'Token inválido' });
  }
};