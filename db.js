// db.js
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',      // Tu usuario de MySQL
  password: '',      // Tu contraseña
  database: 'dulceria_lupita' // Nombre de tu base de datos
});

connection.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos:', err);
    return;
  }
  console.log('Conectado exitosamente a MySQL');
});

module.exports = connection;