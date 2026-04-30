const express = require("express")
const path = require('path');
const logger = require('./middleware/logger');
const app = express()

app.use(logger);
app.use(express.urlencoded({extended:true}))

// Ruta principal
app.get("/", (req,res)=>{
res.sendFile(__dirname + "/registro.html")
})

app.use('/src', express.static(path.join(__dirname, 'src')));

app.get('/', (req, res) => {
    res.send('Servidor funcionando con control de logs.');
});

// index.js
const db = require('./db'); // El archivo de conexión que creamos antes

app.get('/api/mantenimiento', (req, res) => {
    const sql = 'SELECT * FROM mantenimiento'; 
    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
});

app.listen(3000,()=>{
console.log("Servidor en http://localhost:3000")
})