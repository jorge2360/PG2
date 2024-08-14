async function fetchProductos() {
    const response = await fetch('http://localhost:3001/producto');
    const productos = await response.json();
    const productosDiv = document.getElementById('productos');
    
    productos.forEach(producto => {
        const productoDiv = document.createElement('div');
        productoDiv.innerHTML = `<h2>${producto.nombre}</h2><p>${producto.descripcion}</p>`;
        productosDiv.appendChild(productoDiv);
    });
}

fetchProductos();
