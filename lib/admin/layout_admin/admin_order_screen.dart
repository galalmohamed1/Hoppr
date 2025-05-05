import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Order",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection("Orders").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData||snapshot.data!.docs.isEmpty){
            return Center(child:Text("No Order Yet.",style: TextStyle(fontWeight: FontWeight.bold),));
          }
          final orders = snapshot.data!.docs;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              return ListTile(
                title: Text("Order ID:${order.id} \n Total Price: \$${order['totalPrice']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                subtitle: Text("Delivery Location: ${order['address']}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
                  ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) =>  OrderDetailScreen(orderId: order.id,),
                    ),);
                },
              );
            },);
        },),
    );
  }
}
class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

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
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Product ID: ${item['productId']}",style: TextStyle(fontSize: 16),),
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
