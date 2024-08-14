const express = require('express');
const app = express();
const PORT = 3002;

app.use(express.json());

app.get('/usuarios', (req, res) => {
    res.json([{ id: 1, nombre: 'Usuario 1' }]);
});

app.listen(PORT, () => {
    console.log(`Microservicio de Usuarios escuchando en http://localhost:${PORT}`);
});
