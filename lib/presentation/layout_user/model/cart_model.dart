class CartModel {
  final String productId; ///Use the product ID from Firebase
  final Map<String, dynamic> productData; ///Store product details as a map
  int quantity;
  final String selectedSize; /// New File for selected Size

  CartModel({
    required this.productId,
    required this.productData,
    required this.quantity,
    required this.selectedSize, /// Update constructor
  });
}