const express = require('express');
const app = express();
const PORT = 3001;

app.use(express.json());

app.get('/usuarios', (req, res) => {
    res.json([{ id: 1, nombre: 'Producto 1', descripcion: 'Descripción del producto 1' }]);
});

app.listen(PORT, () => {
    console.log(`Microservicio de Productos escuchando en http://localhost:${PORT}`);
});
