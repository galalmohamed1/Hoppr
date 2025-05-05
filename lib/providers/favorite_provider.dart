import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider = ChangeNotifierProvider((ref) => FavoriteProvider(),);
class FavoriteProvider extends ChangeNotifier{
  List<String> _favoriteIds = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> get favorites =>_favoriteIds;

  void reset() {
    _favoriteIds=[];
    notifyListeners();
  }

  final userId = FirebaseAuth.instance.currentUser?.uid;

  FavoriteProvider(){
    loadFavorites();
  }

  void toggleFavorite(DocumentSnapshot product) async{
    String productId = product.id;
    if(_favoriteIds.contains(productId)){
      _favoriteIds.remove(productId);
      await _removeFavorite(productId);
    } else{
      _favoriteIds.add(productId);
      await _addFavorite(productId);
    }
    notifyListeners();
  }

  bool isExist(DocumentSnapshot product){
    return _favoriteIds.contains(product.id);
  }
  /// add favorite to firestore
  Future<void> _addFavorite(String productId) async {
    try{
      await _firestore.collection("userFavorite").doc(productId).set({
        "isFavorite":true,
        "userId":userId,
      });
    }catch(e){
      throw (e.toString());
    }
  }
  /// remove favorite to firestore
  Future<void> _removeFavorite(String productId) async {
    try{
      await _firestore.collection("userFavorite").doc(productId).delete();
    }catch(e){
      throw (e.toString());
    }
  }

  Future<void> loadFavorites() async{
    try{
      QuerySnapshot snapshot = await _firestore
          .collection("userFavorite")
          .where("userId", isEqualTo: userId)
          .get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id,).toList();
    } catch(e){
      throw (e.toString());
    }
  }

}