const express = require("express")
const path = require('path');
const db = require('./db');
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

// RUTA PARA MOSTRAR PROVEEDORES
app.get('/api/proveedores', (req, res) => {
    const sql = 'SELECT * FROM proveedores';
    db.query(sql, (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// RUTA PARA REGISTRAR PROVEEDOR
app.post('/api/proveedores/registrar', (req, res) => {
    const { nombre, rfc, telefono, correo } = req.body;
    const sql = 'INSERT INTO proveedores (nombre, rfc, telefono, correo) VALUES (?, ?, ?, ?)';
    db.query(sql, [nombre, rfc, telefono, correo], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Proveedor registrado exitosamente en la base de datos');
    });
});

app.listen(3000,()=>{
console.log("Servidor en http://localhost:3000")
})