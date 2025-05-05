import 'dart:io';

class AddItemsModel {
  final File? imagePath;
  final bool isLoading;
  final String? selectedCategory;
  final List<String> category;
  final List<String> Size;
  final String? Description;
  final bool isDiscounted;
  final String? discountpercentage;

  AddItemsModel({
        this.imagePath,
        this.isLoading=false,
        this.selectedCategory,
        this.category= const [],
        this.Size = const [],
        this.Description,
        this.isDiscounted = false,
        this.discountpercentage
      });

  AddItemsModel copyWith({
     File? imagePath,
     bool? isLoading,
     String? selectedCategory,
     List<String>? category,
     List<String>? Size,
     String? Description,
     bool? isDiscounted,
     String? discountpercentage,
  }){
    return AddItemsModel(
      imagePath: imagePath ?? this.imagePath,
      isLoading: isLoading ?? this.isLoading,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      category: category ?? this.category,
      Size: Size ??this.Size,
      Description: Description ?? this.Description,
      isDiscounted: isDiscounted ?? this.isDiscounted,
      discountpercentage: discountpercentage ??this.discountpercentage,
    );
  }

}