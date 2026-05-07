const express = require("express")
const path = require('path');
const db = require('./db');
const logger = require('./middleware/logger');
const app = express()

app.use(logger);
app.use(express.urlencoded({extended:true}));
app.use(express.json());
app.use('/src', express.static(path.join(__dirname, 'src')));
app.use('/img', express.static(path.join(__dirname, 'img')));

// Ruta principal
app.get("/", (req,res)=>{
  res.sendFile(path.join(__dirname, "index.html"));
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


//Mantenimiento are
// Actualizar proveedor
app.post('/api/actualizar/proveedor', (req, res) => {
    const { id, nombre, rfc, telefono, correo } = req.body;
    const sql = 'UPDATE proveedores SET nombre = ?, rfc = ?, telefono = ?, correo = ? WHERE id = ?';
    db.query(sql, [nombre, rfc, telefono, correo, id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Proveedor actualizado exitosamente en la base de datos');
    });
});

// Eliminar
app.post('/api/eliminar/proveedor', (req, res) => {
    const { id } = req.body;
    const sql = 'DELETE FROM proveedores WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Proveedor eliminado exitosamente de la base de datos');
    });
});

//producto
app.post('/api/productos/registrar', (req, res) => {
    const { nombre, descripcion, precio, stock } = req.body;
    const sql = 'INSERT INTO productos (nombre, descripcion, precio, stock) VALUES (?, ?, ?, ?)';
    db.query(sql, [nombre, descripcion, precio, stock], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Producto registrado exitosamente en la base de datos');
    });
});

// Actualizar producto
app.post('/api/actualizar/producto', (req, res) => {
    const { id, nombre, descripcion, precio, stock } = req.body;
    const sql = 'UPDATE productos SET nombre = ?, descripcion = ?, precio = ?, stock = ? WHERE id = ?';
    db.query(sql, [nombre, descripcion, precio, stock, id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Producto actualizado exitosamente en la base de datos');
    });
});

// Eliminar
app.post('/api/eliminar/producto', (req, res) => {
    const { id } = req.body;
    const sql = 'DELETE FROM productos WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Producto eliminado exitosamente de la base de datos');
    });
});

app.listen(3000,()=>{
console.log("Servidor en http://localhost:3000")
console.log("Servidor")
})