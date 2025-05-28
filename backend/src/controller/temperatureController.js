const temperatureService = require('../services/temperatureServices');

exports.registrar = async (req, res) => {
  const { valor } = req.body;
  if (valor == null) return res.status(400).json({ erro: 'Valor é obrigatório' });
  try {
    const id = await temperaturaService.registrarTemperatura(req.usuarioId, valor);
    res.status(201).json({ id });
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao registrar temperatura' });
  }
};

exports.listar = async (req, res) => {
  try {
    const dados = await temperaturaService.listarTemperaturas(req.usuarioId);
    res.json(dados);
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao buscar temperaturas' });
  }
};

exports.estatisticas = async (req, res) => {
  try {
    const estat = await temperaturaService.obterEstatisticas(req.usuarioId);
    res.json(estat);
  } catch (err) {
    res.status(500).json({ erro: 'Erro ao buscar estatísticas' });
  }
};