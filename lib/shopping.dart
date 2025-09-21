import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'payment.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras', style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: Color(0xFF003087),
      ),
      body: Container(
        color: Color(0xFFFFFFFF), // Fondo blanco para el cuerpo
        child: cartItems.isEmpty
            ? const Center(child: Text('El carrito está vacío', style: TextStyle(color: Color(0xFF0052CC))))
            : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    color: Color(0xFFFFFFFF),
                    child: ListTile(
                      leading: Image.asset(item.imagePath),
                      title: Text(item.productName, style: const TextStyle(color: Color(0xFF0052CC))),
                      subtitle: Text('Cantidad: ${item.quantity}', style: const TextStyle(color: Color(0xFF0052CC))),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Color(0xFF0052CC)),
                            onPressed: () {
                              if (item.quantity > 1) {
                                cartProvider.updateItemQuantity(index, item.quantity - 1);
                              } else {
                                cartProvider.removeItem(index);
                              }
                            },
                          ),
                          Text('${item.quantity}', style: const TextStyle(color: Color(0xFF0052CC))),
                          IconButton(
                            icon: const Icon(Icons.add, color: Color(0xFF0052CC)),
                            onPressed: () {
                              cartProvider.updateItemQuantity(index, item.quantity + 1);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Color(0xFF0052CC)),
                            onPressed: () {
                              cartProvider.removeItem(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF4A261), // Naranja para el botón
            foregroundColor: Color(0xFFFFFFFF), // Texto blanco
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentPage()),
            );
          },
          child: const Text('Realizar Compra'),
        ),
      ),
    );
  }
}