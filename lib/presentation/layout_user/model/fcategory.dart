import 'package:Hoppr/consts/services/assert_manager.dart';

class FCategory {
  final String name, image;

  FCategory({
    required this.name,
    required this.image,
  });
}

List<String> filterCategory = [
  "Filter",
  "Ratings",
  "Size",
  "Price",
  "Brand",
];

List<FCategory> fcategory=[
  FCategory(name: "Phone", image: AssetsManager.mobiles),
  FCategory(name: "Fashion", image: AssetsManager.fashion),
  FCategory(name: "Cosmetics", image: AssetsManager.cosmetics),
  FCategory(name: "Medications", image: "assets/images/categories/Medications.png"),
  FCategory(name: "PC", image: AssetsManager.pc),
  FCategory(name: "Electronics", image: AssetsManager.electronics),
  FCategory(name: "Book", image: AssetsManager.book),
  FCategory(name: "Shoes", image: AssetsManager.shoes),
];