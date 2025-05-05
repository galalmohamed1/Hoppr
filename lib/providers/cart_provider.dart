import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/presentation/layout_user/model/cart_model.dart';
final cartService = ChangeNotifierProvider<CartProvider>((ref) => CartProvider(),);
class CartProvider with ChangeNotifier{
  List<CartModel> _carts=[];
  List<CartModel>get carts=>_carts;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  CartProvider(){
    loadCartItems();
  }
  void reset(){
    _carts=[];
    notifyListeners();
  }

  final userId =FirebaseAuth.instance.currentUser?.uid; /// to get the user current user's id
  set carts(List<CartModel> carts){
    _carts=carts;
    notifyListeners();
  }


  Future<void> addCart(String productId, Map<String,dynamic> productData,
      String selectedSize)async{
    int index = _carts.indexWhere((elements) => elements.productId == productId);
    if(index!=-1){
      ///items exists, update quantity and selected attributes
      var existingItem = _carts[index];
      _carts[index]=CartModel(
        productId: productId,
        productData: productData,
        quantity: existingItem.quantity +1 ,/// Increase quantity
        selectedSize: selectedSize,/// Update selected Size
      );
      await _updateCartInFirebase(
        productId,
        _carts[index].quantity,
      );
    }else {
      _carts.add(
          CartModel(
          productId: productId,
          productData: productData,
          quantity: 1, ///initially one items must be required
          selectedSize: selectedSize,
          ),
      );
      await _firestore.collection("userCart").doc(productId).set({
        'productData' : productData,
        "quantity":1,
        "selectedSize":selectedSize,
        "uid":userId,
      });
    }
    notifyListeners();
  }
  /// increase quantity
  Future<void> addQuantity(String productId) async{
    int index = _carts.indexWhere((element) => element.productId == productId);
    _carts[index].quantity += 1;
    await _updateCartInFirebase(
      productId,
      _carts[index].quantity,
    );
    notifyListeners();
  }
  /// Decrease quantity or remove the items
  Future<void> decreaseQuantity(String productId) async{
    int index = _carts.indexWhere((element) => element.productId == productId);
    _carts[index].quantity -= 1;

    if(_carts[index].quantity <=0){
      _carts.removeAt(index);
      await _firestore.collection("userCart").doc(productId).delete();
    }else {
      await _updateCartInFirebase(
        productId,
        _carts[index].quantity,
      );
    }
      notifyListeners();

  }
  /// Check if the product exists value
  bool productExist(String productId) {
    return _carts.any((element) => element.productId == productId);
  }

  Future<void> saveOrder(String userId, BuildContext context, paymentMethodId, finalPrice, address) async{
    if(_carts.isEmpty) return;
    final paymentRef = FirebaseFirestore.instance.collection("User Payment Method").doc(paymentMethodId);
    try{
      await FirebaseFirestore.instance.runTransaction((transaction) async{
        final snapshot = await transaction.get(paymentRef);
        if(!snapshot.exists){
          throw Exception("Payment Method not Found");
        }
        final currentBalance = snapshot['balance'] as num ;
        if(currentBalance < finalPrice){
          throw Exception("Insufficient funds");
        }
        transaction.update(paymentRef, {
          'balance': currentBalance-finalPrice,
        });
        final orderData = {
          'userId':userId,
          'items':_carts.map((cartItem) {
            return{
              'productId' : cartItem.productId,
              "quantity": cartItem.quantity,
              "selectedSize":cartItem.selectedSize,
              'name': cartItem.productData['name'],
              'price': cartItem.productData['price'],
            };
          },).toList(),
          'totalPrice':finalPrice,
          'status': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
          'address':address,
        };
        final orderRef = FirebaseFirestore.instance.collection("Orders").doc();
        transaction.set(orderRef, orderData);
      },);
    }catch (e){
      throw Exception(e);
    }
  }
  ///Calculate total cart value
  double totalCart(){
    double total =0;
    for(int i=0;i<_carts.length;i++){
      final finalPrice = num.parse((_carts[i].productData['price'] * (1- _carts[i].productData['discountPercentage'] /100)).toStringAsFixed(2));
      total +=_carts[i].quantity * (finalPrice);
    }
    return total;
  }
  ///load cart items from firebase (to display it in cart screen).
  Future<void> loadCartItems() async{
    try{
      QuerySnapshot snapshot = await _firestore
          .collection("userCart")
          .where("uid",isEqualTo: userId)
          .get();
      _carts = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CartModel(
            productId: doc.id,
            productData: data['productData'],
            quantity: data['quantity'],
            selectedSize: data['selectedSize'],
        );
      },).toList();
      
    } catch (e){
      print(e.toString());
    }
    notifyListeners();
  }
  /// Remove cartItems from firestore
  Future<void> deleteCartItem(String productId) async{
    int index = _carts.indexWhere((element) => element.productId == productId,);
    if(index !=-1){
      _carts.removeAt(index);
      await _firestore.collection("userCart").doc(productId).delete();
      notifyListeners();
    }
  }

  /// update cart items in firebase
  Future<void> _updateCartInFirebase(String productId, int quantity)async{
    try{
      await _firestore.collection("userCart").doc(productId).update({
        "quantity": quantity,
      });
    } catch(e){
      print(e.toString());
    }
  }
}