import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/payment/add_payment.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? userId;
  @override
  void initState() {
    // TODO: implement initState
    userId = FirebaseAuth.instance.currentUser?.uid;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methods"),
        centerTitle: true,
      ),
      body: userId==null
          ?Center(
        child: Text("Please view Payment Methods"),
      )
          :SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("User Payment Method")
                .where("userId",isEqualTo: userId)
                .snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final methods = snapshot.data!.docs;
              if(methods.isEmpty){
                return Center(child: Text("No Payment Methods Found. Please Add Payment Methods."),);
              }
              return ListView.builder(
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  final method = methods[index];
                return ListTile(
                  leading: CachedNetworkImage(
                      imageUrl: method['image'],
                    height: 50,
                    width: 50,
                  ),
                  title: Text(method['paymentSystem']),
                  subtitle: Text(
                    'Activate',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  trailing: MaterialButton(onPressed: () => _showAddFundsDialog(context, method),child: Text("Add Fund"),),
                );
              },);
            },),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,size: 30,),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPaymentMethods(),
              ),
          );
      },),
    );
  }
}

void _showAddFundsDialog(BuildContext context, DocumentSnapshot method){
  TextEditingController amountController = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
    backgroundColor: Colors.white,
    title: Text("Add Funds"),
    content: CustomTextField(
      controller: amountController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      label: "Amount",
      prefixtext: "\$",
    ),
    actions: [
      TextButton(
        onPressed: () => navigatorKey.currentState!.pop(),
        child: Text("Cancel"),
      ),
      TextButton(onPressed: () async{
        final amount = double.tryParse(amountController.text);
        if(amount== null || amount<=0){
          SnackBarService.showErrorMessage('Please Enter a Valid Positive amount');
          return;
        }
        try{
          await method.reference.update({
            "balance": FieldValue.increment(amount),
          });
          navigatorKey.currentState!.pop();
        }catch (e){
          SnackBarService.showErrorMessage('Error adding funds: $e');
        }
      }, child: Text("Add"),),
    ],
  ),);
}

