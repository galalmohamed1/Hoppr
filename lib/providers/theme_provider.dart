import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Hoppr/admin/model/add_items_model.dart';

class ThemeProvider with ChangeNotifier{
  static const THEME_STATUS ="THEME_STATUS";
  bool _darkTheme =false;
  bool get getIsDarkTheme => _darkTheme;

  ThemeProvider(){// دي علشان يخلي المود زي ما كونت اختارته سواء دارك او ليت
    getTheme();
  }

  Future<void> setDarkTheme({required bool themeValue})async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, themeValue);
    _darkTheme = themeValue;
    notifyListeners();
  }
  Future<bool> getTheme()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    _darkTheme = prefs.getBool(THEME_STATUS) ?? false;
    notifyListeners();
    return _darkTheme;
  }
  bool isDark(){
    if(_darkTheme)
      return true;
    else
      return false;
  }
}
// final addItemProvider = StateNotifierProvider<AddItemNotifire,AddItemsModel>((ref){
//   return AddItemNotifire();
// });
//
// class AddItemNotifire extends StateNotifier <AddItemsModel>{
//   AddItemNotifire() : super(AddItemsModel()){
//     fetchCategory();
//   }
//   final CollectionReference items=FirebaseFirestore.instance.collection("items");
//   final CollectionReference categoryiesCollection =FirebaseFirestore.instance.collection("Category");
//
//   void pickImage() async{
//     try{
//       final pickedFile= await ImagePicker().pickImage(source: ImageSource.gallery);
//       if(pickedFile != null){
//         // state= state.copyWith(imagePath: pickedFile.path);
//       }
//     } catch (e){
//       throw Exception("Error saving items: $e");
//     }
//   }
//
//   void setSelectedCategory(String? category){
//     state=state.copyWith(selectedCategory: category);
//   }
//
//   void addSize(String size){
//     state=state.copyWith(Size: [...state.Size,size]);
//   }
//
//   void removeSize(String size){
//     state=state.copyWith(Size: state.Size.where((s)=> s!=size).toList());
//   }
//
//   void toggleDiscount(bool? isDiscounted){
//     state = state.copyWith(isDiscounted: isDiscounted);
//   }
//
//   void setDiscountpercentage(String percentage){
//     state = state.copyWith(discountpercentage: percentage);
//   }
//
//   void setDescription(String description){
//     state = state.copyWith(Description: description);
//   }
//   /// to fetch the category items
//   Future<void> fetchCategory() async{
//     try{
//       QuerySnapshot snapshot =await categoryiesCollection.get();
//       List<String> categories= snapshot.docs.map((e) => e['name'] as String).toList();
//       state=state.copyWith(category: categories);
//     } catch(e){
//       throw Exception("Error saving items: $e");
//     }
//   }
//   /// upload and save the items
//   Future<void> uploadAndSaveItems(String name,String price,String description)async{
//     if(name.isEmpty || price.isEmpty || state.imagePath == null || state.selectedCategory == null || state.Size.isEmpty || state.Description == null || (state.isDiscounted && state.discountpercentage == null ) ){
//       throw Exception("Please fill all the field an upload an image.");
//     }
//     state = state.copyWith(isLoading: true);
//     try{
//       /// upload image to  firebase storage
//       final fileName = DateTime.now().microsecondsSinceEpoch.toString();
//       final reference = FirebaseStorage.instance.ref().child('image/$fileName');
//       // await reference.putFile(File(state.imagePath!));
//       final imageUrl = await reference.getDownloadURL();
//
//       /// save item to firebase
//       final String uid= FirebaseAuth.instance.currentUser!.uid;
//       await items.add({
//         "name":name,
//         "price":int.tryParse(price),
//         "image":imageUrl,
//         "uploadedBy":uid,
//         "category":state.category,
//         "Description":state.Description,
//         "Size":state.Size,
//         "isDiscounted":state.isDiscounted,
//         "discountpercentage":
//         state.isDiscounted ? int.tryParse(state.discountpercentage!) : 0,
//       });
//     }catch(e){
//       throw Exception("Error saving items: $e");
//     }finally{
//       state =state.copyWith(isLoading: false);
//     }
//   }
// }