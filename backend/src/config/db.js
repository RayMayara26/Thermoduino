const db = mysql.createConnection({
  host: 'localhost',     // substitua se estiver em outro host
  user: 'root',          // seu usuário MySQL
  password: '12345678', // sua senha MySQL
  database: 'thermoduino'  // nome do seu banco de dados
});

connection.connect((err) => {
  if (err) {
    console.error('Erro ao conectar ao banco de dados:', err);
    return;
  }
  console.log('Conectado ao banco de dados MySQL');
});

module.exports = connection;