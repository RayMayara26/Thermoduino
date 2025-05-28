const express = require('express');
const cors = require('cors');
const app = express();
const usuarioRoutes = require('./src/routes/usuario');
const temperaturaRoutes = require('./src/routes/temperature');

app.use(cors());
app.use(express.json());

app.use('/api/usuarios', usuarioRoutes);
app.use('/api/temperaturas', temperaturaRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));