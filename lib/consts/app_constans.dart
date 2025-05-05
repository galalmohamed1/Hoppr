import 'package:Hoppr/consts/models/categories_model.dart';
import 'package:Hoppr/consts/services/assert_manager.dart';

class AppConstans {
  static const String productimage="assets/images/goli.png";

  static List<String> bannerImage=[
    AssetsManager.banner3,
    AssetsManager.banner1,
    AssetsManager.banner2,
    AssetsManager.banner4,
    ];
  /// Shop By Category
    static List<CategoriesModel> categoriesList=[
    CategoriesModel(id: AssetsManager.electronics, image: AssetsManager.electronics, name: "electronics"),
    CategoriesModel(id: AssetsManager.pc, image: AssetsManager.pc, name: "PC"),
    CategoriesModel(id: AssetsManager.book, image: AssetsManager.book, name: "Book"),
    CategoriesModel(id: AssetsManager.cosmetics, image: AssetsManager.cosmetics, name: "Cosmetics"),
    CategoriesModel(id:AssetsManager.fashion, image: AssetsManager.fashion, name: "Fashion"),
    CategoriesModel(id: AssetsManager.mobiles, image: AssetsManager.mobiles, name: "Phone"),
    CategoriesModel(id: AssetsManager.watch, image: AssetsManager.watch, name: "Watch"),
    CategoriesModel(id: AssetsManager.shoes, image: AssetsManager.shoes, name: "Shoes"),

    ];
}