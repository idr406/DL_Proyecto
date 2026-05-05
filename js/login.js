const form = document.getElementById("login-form");
const error = document.querySelector(".error");

form.addEventListener("submit", async (e) => {
  e.preventDefault();

  const user = document.getElementById("user").value;
  const password = document.getElementById("password").value;

  try {
    const res = await fetch("http://localhost:3001/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ user, password })
    });

    const data = await res.json();

    if (data.success) {
      alert("Bienvenido " + data.usuario.Nombre);
      window.location.href = "admin.html";
    } else {
      error.classList.remove("escondido");
    }

  } catch (err) {
    console.log(err);
    alert("Error de conexión");
  }
});
