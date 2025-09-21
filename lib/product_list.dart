import 'package:flutter/material.dart';
import 'product_detail.dart';

class ProductListPage extends StatefulWidget {
  final String initialSearchQuery;

  const ProductListPage({super.key, this.initialSearchQuery = ''});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late TextEditingController _searchController;
  late List<String> originalProductNames;
  late List<List<String>> originalProductImages;
  late List<double> originalProductPrices;
  late List<String> originalProductDetails;
  late List<String> filteredProductNames;
  late List<List<String>> filteredProductImages;
  late List<double> filteredProductPrices;
  late List<String> filteredProductDetails;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialSearchQuery);
    filteredProductNames = [];
    filteredProductImages = [];
    filteredProductPrices = [];
    filteredProductDetails = [];
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    originalProductNames = await loadProductNames();
    originalProductPrices = await loadProductPrices();
    originalProductDetails = await loadProductDetails();
    originalProductImages = [
      ['assets/banca/banca1.jpg', 'assets/banca/banca2.jpg', 'assets/banca/banca3.jpg'],
      ['assets/banco/banco1.png', 'assets/banco/banco2.jpg', 'assets/banco/banco3.jpg'],
      ['assets/sofa_3/sofa_3.1.png', 'assets/sofa_3/sofa_3.2.jpg', 'assets/sofa_3/sofa_3.3.jpg'],
      ['assets/mesa/mesa1.jpg', 'assets/mesa/mesa2.jpg', 'assets/mesa/mesa3.jpg'],
    ];

    setState(() {
      filteredProductNames = List.from(originalProductNames);
      filteredProductImages = List.from(originalProductImages);
      filteredProductPrices = List.from(originalProductPrices);
      filteredProductDetails = List.from(originalProductDetails);
      _filterProducts(widget.initialSearchQuery);
    });
  }

  void _filterProducts(String query) {
    if (query.isNotEmpty) {
      final indices = originalProductNames
          .asMap()
          .entries
          .where((entry) => entry.value.toLowerCase().contains(query.toLowerCase()))
          .map((entry) => entry.key)
          .toList();

      filteredProductNames = indices.map((i) => originalProductNames[i]).toList();
      filteredProductImages = indices.map((i) => originalProductImages[i]).toList();
      filteredProductPrices = indices.map((i) => originalProductPrices[i]).toList();
      filteredProductDetails = indices.map((i) => originalProductDetails[i]).toList();
    } else {
      filteredProductNames = List.from(originalProductNames);
      filteredProductImages = List.from(originalProductImages);
      filteredProductPrices = List.from(originalProductPrices);
      filteredProductDetails = List.from(originalProductDetails);
    }
  }

  Future<List<String>> loadProductNames() async {
    return ['Banca', 'Banco', 'Sofá 3 plazas', 'Mesa'];
  }

  Future<List<double>> loadProductPrices() async {
    return [299.99, 199.99, 399.99, 149.99];
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _filterProducts(value);
              });
            },
            decoration: InputDecoration(
              labelText: 'Buscar productos...',
              labelStyle: const TextStyle(color: Color(0xFF0052CC)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF0052CC)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFF4A261)),
              ),
              suffixIcon: const Icon(Icons.search, color: Color(0xFF0052CC)),
              filled: true,
              fillColor: Color(0xFFFFFFFF),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredProductNames.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        imagePaths: filteredProductImages[index],
                        productName: filteredProductNames[index],
                        productPrice: filteredProductPrices[index],
                        productDetail: filteredProductDetails[index],
                        modelPath: 'assets/models/${filteredProductNames[index].toLowerCase()}.glb',
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
                              itemCount: filteredProductImages[index].length,
                              itemBuilder: (context, imgIndex) {
                                return Image.asset(
                                  filteredProductImages[index][imgIndex],
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
                                  filteredProductImages[index].length,
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
                        child: Text(filteredProductNames[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Q.${filteredProductPrices[index].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(filteredProductDetails[index], maxLines: 2, overflow: TextOverflow.ellipsis),
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
}