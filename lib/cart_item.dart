class CartItem {
  final String productName;
  final double productPrice;
  int quantity;
  final String imagePath;

  CartItem({
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.imagePath,
  });
}
