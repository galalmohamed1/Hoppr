import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/presentation/cart/order_detail.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: false,
        title: Text("Total Order"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("Orders").
          where("userId",isEqualTo: userId)
          .snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            final orders = snapshot.data!.docs;
            if(orders.isEmpty){
              return Center(child:
              Text("No order found."),
              );
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index];
              return ListTile(
                title: Text("Order ID:${order.id}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                subtitle: Text("Total Price: \$${order['totalPrice']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) =>  UserOrderDetail(orderId: order.id,),
                  ),);
                },
              );
            },);
          },),
    );
  }
}
