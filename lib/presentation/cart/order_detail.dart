import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/main.dart';

class UserOrderDetail extends StatelessWidget {
  final String orderId;
  const UserOrderDetail({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: false,
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("Orders").doc(orderId).get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          final orders = snapshot.data!;
          var items = orders['items'] as List;
          if(items.isEmpty){
            return Center(child:
            Text("No order found."),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${item['name']}",style: TextStyle(fontSize: 16),),
                    Text(
                      "Quantity: ${item['quantity']}, Size: ${item['selectedSize']}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("Price: ${item['price'] ?? 0}, Status: Pending",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },);
        },),
    );
  }
}
