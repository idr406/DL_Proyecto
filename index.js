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
    const sql = 'UPDATE proveedores SET nombre = ?,  telefono = ?, correo = ? WHERE rfc = ?';
    db.query(sql, [nombre, rfc, telefono, correo, id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Proveedor actualizado exitosamente en la base de datos');
    });
});

// Eliminar
app.post('/api/eliminar/proveedor', (req, res) => {
    const { id } = req.body;
    const sql = 'DELETE FROM proveedores WHERE rfc = ?';
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

//ConfuguracionVane
//Modulo de configuracion
//Obtener datos del sistema

app.get('/api/configuracion', (req, res) => {
    const sql = 'SELECT * FROM configuracion WHERE id = 1';
    db.query(sql, (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results[0]);
    });
});

// Actualizar parámetros tecnicos y fiscales

app.post('/api/configuracion/actualizar', (req, res) => {
    const { razon_social, rfc_fiscal, direccion, zona_horaria } = req.body;
    const sql = `UPDATE configuracion SET 
                 razon_social = ?, 
                 rfc_fiscal = ?, 
                 direccion = ?, 
                 zona_horaria = ? 
                 WHERE id = 1`;
    db.query(sql, [razon_social, rfc_fiscal, direccion, zona_horaria], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Configuración del sistema actualizada exitosamente');
    });
});

// Modulo del personal 
// Mostrar lista de personal
app.get('/api/usuarios', (req, res) => {
    const sql = 'SELECT id, nombre, rol FROM usuarios';
    db.query(sql, (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Registrar nuevo usuario / empleado
app.post('/api/usuarios/registrar', (req, res) => {
    const { nombre, rol } = req.body;
    const sql = 'INSERT INTO usuarios (nombre, rol) VALUES (?, ?)';
    db.query(sql, [nombre, rol], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Usuario registrado exitosamente en la base de datos');
    });
});




// Actualizar el perfil de usuario
app.post('/api/actualizar/usuario', (req, res) => {
    const { id, nombre, rol } = req.body;
    const sql = 'UPDATE usuarios SET nombre = ?, rol = ? WHERE id = ?';
    db.query(sql, [nombre, rol, id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Usuario actualizado exitosamente en la base de datos');
    });
});

// Eliminar usuario
app.post('/api/eliminar/usuario', (req, res) => {
    const { id } = req.body;
    const sql = 'DELETE FROM usuarios WHERE id = ?';
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send('Usuario eliminado exitosamente de la base de datos');
    });
});

//   MODULO DE SEGURIDAD (ROLES Y BACKUP)

// Obtener descripción de roles
app.get('/api/seguridad/roles', (req, res) => {
    const sql = 'SELECT * FROM roles_permisos';
    db.query(sql, (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

// Ruta para el botón de Backup
app.get('/api/seguridad/backup', (req, res) => {
    // Aquí se ejecutaría la lógica de exportación de la DB
    res.send('Respaldo generado y listo para descargar');
});

// Puerto de escucha
app.listen(3000, () => {
  console.log('Servidor de Dulcería Lupita corriendo en http://localhost:3000');
});

// REGISTRAR PROVEEDOR
app.post("/registrar-proveedor", (req, res) => {
  const { nombre, rfc, telefono, correo, direccion, contacto } = req.body;

  // Validaciones
  const regexRFC = /^[A-Z&Ñ]{3}[0-9]{6}[A-Z0-9]{3}$/; // 12 caracteres empresa
  const regexTelefono = /^[0-9]{10}$/; // 10 dígitos
  const regexCorreo = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/; // solo minúsculas

  if (!nombre || !rfc || !telefono || !correo) {
    return res.status(400).json({
      mensaje: "Todos los campos obligatorios deben llenarse"
    });
  }

  if (!regexRFC.test(rfc)) {
    return res.status(400).json({
      mensaje: "RFC inválido. Debe tener 12 caracteres."
    });
  }

  if (!regexTelefono.test(telefono)) {
    return res.status(400).json({
      mensaje: "Teléfono inválido. Debe tener 10 números."
    });
  }

  if (!regexCorreo.test(correo)) {
    return res.status(400).json({
      mensaje: "El correo debe estar en minúsculas."
    });
  }

  const sql = `
    INSERT INTO proveedores
    (Nombre, RFC, Telefono, Correo, Direccion, Contacto)
    VALUES (?, ?, ?, ?, ?, ?)
  `;

  db.query(
    sql,
    [nombre, rfc, telefono, correo, direccion, contacto],
    (err, result) => {
      if (err) {
        console.log(err);
        return res.status(500).json({
          mensaje: "Error al registrar proveedor"
        });
      }

      res.json({
        mensaje: "Proveedor registrado correctamente"
      });
    }
  );
});

app.listen(3000,()=>{
console.log("Servidor en http://localhost:3000")
console.log("Servidor")
})