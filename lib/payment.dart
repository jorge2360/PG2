import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Métodos de Pago'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Selecciona un método de pago:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para pago con tarjeta
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pago con tarjeta seleccionado')),
                );
              },
              child: const Text('Pago con Tarjeta'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para pago con PayPal
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pago con PayPal seleccionado')),
                );
              },
              child: const Text('Pago con PayPal'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Lógica para pago en efectivo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pago en efectivo seleccionado')),
                );
              },
              child: const Text('Pago en Efectivo'),
            ),
          ],
        ),
      ),
    );
  }
}
