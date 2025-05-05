import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/main.dart';

Future<void> placeOrder(
    String productId,
    Map<String,dynamic> productData,
    String selectedSize,
    String paymentMethodId,
    num finalPrice,
    String address,
    BuildContext context,
    )async{
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if(userId == null ){
    SnackBarService.showErrorMessage(
        "User not logged in, Please log in to place an order."
    );
    return;
  }
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
        'items':[
                {
                  'productId': productId,
                  "quantity": 1,
                  "selectedSize": selectedSize,
                  'name': productData['name'],
                  'price': productData['price'],
                }
              ],
        'totalPrice':finalPrice,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'address':address,
      };
      final orderRef = FirebaseFirestore.instance.collection("Orders").doc();
      transaction.set(orderRef, orderData);
    },);
    SnackBarService.showSuccessMessage(
        "Order Placed Successfully."
    );
    navigatorKey.currentState!.pushNamed(PagesRouteName.my_order_screen);
  }on FirebaseException catch (e){
    SnackBarService.showErrorMessage(
        "Firebase Error: ${e.message}"
    );
  } on Exception catch(e){
    SnackBarService.showErrorMessage(
        "Error: ${e.toString()}"
    );
  }
}