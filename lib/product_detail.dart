import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'ar_view.dart'; // Ajusta la ruta según la ubicación de este archivo

class ProductDetailPage extends StatefulWidget {
  final List<String> imagePaths;
  final String productName;
  final double productPrice;
  final String productDetail;
  final String modelPath; // Añadido para el modelo AR

  const ProductDetailPage({
    super.key,
    required this.imagePaths,
    required this.productName,
    required this.productPrice,
    required this.productDetail,
    required this.modelPath, // Añadido aquí
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _launchARView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ARView(productName: widget.productName, modelPath: widget.modelPath), // Pasa el modelPath aquí
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imagePaths.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentIndex ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.productName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Q.${widget.productPrice}', style: const TextStyle(fontSize: 20, color: Colors.green)),
                const SizedBox(height: 10),
                Text(widget.productDetail),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (_quantity > 1) {
                          setState(() {
                            _quantity--;
                          });
                        }
                      },
                    ),
                    Text('$_quantity', style: const TextStyle(fontSize: 20)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final cartProvider = Provider.of<CartProvider>(context, listen: false);
                    cartProvider.addItem(widget.productName, widget.productPrice, _quantity, widget.imagePaths[0]);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Producto agregado al carrito')));
                  },
                  child: const Text('Agregar al carrito'),
                ),
                ElevatedButton(
                  onPressed: _launchARView,
                  child: const Text('Ver en AR'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
