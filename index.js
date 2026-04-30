const express = require("express")
const app = express()

app.use(express.urlencoded({extended:true}))

// Ruta principal
app.get("/", (req,res)=>{
res.sendFile(__dirname + "/registro.html")
})

app.post("/registro",(req,res)=>{

const {nombre,email,password} = req.body

console.log("Usuario registrado:")
console.log(nombre,email,password)

res.send("Registro exitoso")

})

app.listen(3000,()=>{
console.log("Servidor en http://localhost:3000")
})