import 'package:flutter/material.dart';
import 'shopping.dart';
import 'profile.dart';
import 'product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ProductListPage(), // Página de productos
    ShoppingPage(),     // Página de carrito
    ProfilePage(),      // Página de perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 // Solo mostrar el AppBar en la página de inicio
          ? AppBar(
              title: Image.asset(
                'assets/logo_home.png', // Reemplaza el texto con la imagen
                height: 40, // Ajusta la altura según necesites
                fit: BoxFit.contain,
              ),
              backgroundColor: Color(0xFF003087),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Color(0xFFFFFFFF)),
                  onPressed: () {},
                ),
              ],
            )
          : null, // Sin AppBar para otras páginas
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFFF4A261), // Naranja para el elemento seleccionado
        unselectedItemColor: Color(0xFF0052CC), // Azul medio para elementos no seleccionados
        backgroundColor: Color(0xFF003087), // Azul oscuro como fondo
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cambiar el índice actual
          });
        },
      ),
    );
  }
}