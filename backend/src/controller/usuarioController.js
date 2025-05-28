const usuarioService = require("../services/usuarioService");

exports.cadastrar = async (req, res) => {
  try {
    const { nome, data_de_nascimento, email, senha } = req.body;

    if (!nome || !data_de_nascimento || !email || !senha) {
      return res.status(400).json({ message: "Todos os campos são obrigatórios." });
    }

    const novoUsuario = { nome, data_de_nascimento, email, senha };
    const usuario = await usuarioService.criarUsuario(novoUsuario);

    return res.status(201).json(usuario);
  } catch (err) {
    const status = err?.message === "Usuário não encontrado" ? 404 : 500;
    const message = err?.message || "Erro interno. Tente novamente mais tarde.";
    return res.status(status).json({ error: message });
  }
};

exports.login = async (req, res) => {
  // Implementar lógica de login
  res.status(501).json({ message: "Login ainda não implementado." });
};

exports.enviarToken = async (req, res) => {
  // Implementar envio de token para redefinição de senha
  res.status(501).json({ message: "Envio de token ainda não implementado." });
};

exports.redefinirSenha = async (req, res) => {
  // Implementar lógica de redefinição de senha
  res.status(501).json({ message: "Redefinição de senha ainda não implementada." });
};

exports.getDados = async (req, res) => {
  // Implementar lógica para retornar dados do usuário autenticado
  res.status(501).json({ message: "Consulta de dados ainda não implementada." });
};

exports.atualizar = async (req, res) => {
  // Implementar lógica para atualizar dados do usuário autenticado
  res.status(501).json({ message: "Atualização ainda não implementada." });
};

exports.deletar = async (req, res) => {
  // Implementar lógica para deletar o usuário autenticado
  res.status(501).json({ message: "Exclusão ainda não implementada." });
};