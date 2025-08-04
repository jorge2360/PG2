import 'package:flutter/material.dart';
import 'product_detail.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  Future<List<String>> loadProductNames() async {
    return [
      'Banca',
      'Banco',
      'Sofá 3 plazas',
      'Mesa',
    ];
  }

  Future<List<double>> loadProductPrices() async {
    return [
      299.99,
      199.99,
      399.99,
      149.99,
    ];
  }

  Future<List<String>> loadProductDetails() async {
    return [
      'Banca cómoda para tu sala de estar.',
      'Banco elegante y funcional.',
      'Sofá de 3 plazas, ideal para familias.',
      'Mesa de comedor de diseño moderno.',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: loadProductNames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final productNames = snapshot.data!;
          final List<List<String>> productImages = [
            ['assets/banca/banca1.jpg', 'assets/banca/banca2.jpg', 'assets/banca/banca3.jpg'],
            ['assets/banco/banco1.png', 'assets/banco/banco2.jpg', 'assets/banco/banco3.jpg'],
            ['assets/sofa_3/sofa_3.1.png', 'assets/sofa_3/sofa_3.2.jpg', 'assets/sofa_3/sofa_3.3.jpg'],
            ['assets/mesa/mesa1.jpg', 'assets/mesa/mesa2.jpg', 'assets/mesa/mesa3.jpg'],
          ];

          return FutureBuilder<List<double>>(
            future: loadProductPrices(),
            builder: (context, priceSnapshot) {
              if (priceSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (priceSnapshot.hasError) {
                return Center(child: Text('Error: ${priceSnapshot.error}'));
              } else {
                final productPrices = priceSnapshot.data!;

                return FutureBuilder<List<String>>(
                  future: loadProductDetails(),
                  builder: (context, detailSnapshot) {
                    if (detailSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (detailSnapshot.hasError) {
                      return Center(child: Text('Error: ${detailSnapshot.error}'));
                    } else {
                      final productDetails = detailSnapshot.data!;

                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Buscar productos...',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: productNames.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                          imagePaths: productImages[index],
                                          productName: productNames[index],
                                          productPrice: productPrices[index],
                                          productDetail: productDetails[index],
                                          modelPath: 'assets/models/${productNames[index].toLowerCase()}.glb', // Ajusta la ruta según el nombre del modelo
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              PageView.builder(
                                                itemCount: productImages[index].length,
                                                itemBuilder: (context, imgIndex) {
                                                  return Image.asset(
                                                    productImages[index][imgIndex],
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                left: 0,
                                                right: 0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: List.generate(
                                                    productImages[index].length,
                                                    (indicatorIndex) => Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                                      height: 8,
                                                      width: 8,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: indicatorIndex == 0 ? Colors.blue : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productNames[index]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text('Q.${productPrices[index].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(productDetails[index], maxLines: 2, overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
