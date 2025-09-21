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
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _pages = const [
    ProductListPage(), // Página de productos
    ShoppingPage(),     // Página de carrito
    ProfilePage(),      // Página de perfil
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              title: Image.asset(
                'assets/logo_home.png',
                height: 40,
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
          : null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF003087), Color(0xFFF4A261)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: IndexedStack(
          index: _currentIndex,
          children: _pages.map((page) {
            if (page is ProductListPage) {
              return ProductListPage(initialSearchQuery: _searchController.text);
            }
            return page;
          }).toList(),
        ),
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
        selectedItemColor: Color(0xFFF4A261),
        unselectedItemColor: Color(0xFF0052CC),
        backgroundColor: Color(0xFF003087),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}