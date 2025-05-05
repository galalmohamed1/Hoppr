import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:Hoppr/main.dart';
class AddPaymentMethods extends StatefulWidget {
  const AddPaymentMethods({super.key});

  @override
  State<AddPaymentMethods> createState() => _AddPaymentMethodsState();
}

class _AddPaymentMethodsState extends State<AddPaymentMethods> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  // final TextEditingController _addressController = TextEditingController();
  final maskFromatter = MaskTextInputFormatter(
    mask: "**** **** **** ****",
    filter: {"*": RegExp(r'[0-9]')}
  );
  double balance =0.0;
  String? selectedPaymentSystem;
  Map<String,dynamic>? selectedPaymentSystemData;
  final _formKey = GlobalKey<FormState>();
  Future<List<Map<String,dynamic>>> fetchPaymentSystems()async{
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection("payment_methods").get();
    return snapshot.docs.map((doc) => {
      'name': doc['name'],
      'image':doc['image'],
    },).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Payment Method"),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: _formKey,
                child: Column(
                  children: [
                    FutureBuilder(
                        future: fetchPaymentSystems(),
                        builder: (context, snapshot) {
                           if(snapshot.hasError){
                             return Text("Error: ${snapshot.error}");
                           }else if(!snapshot.hasData || snapshot.data!.isEmpty){
                             return Text("No Payment System Available");
                           }
                           return DropdownButton<String>(
                             value: selectedPaymentSystem,
                             elevation: 2,
                             hint: Text("Selected Payment System"),
                             items:snapshot.data!.map((system) {
                               return DropdownMenuItem<String>(
                                 value: system['name'],
                                 child: Row(
                                 children: [
                                   CachedNetworkImage(
                                       imageUrl: system['image'],
                                     height: 30,
                                     width: 30,
                                     errorWidget: (context, stackTrace, error) => Icon(Icons.error),
                                   ),
                                   SizedBox(width: 10,),
                                   Text(system['name']),
                                 ],
                               ),);
                             },).toList(),
                             onChanged: (value) {
                               setState(() {
                                 selectedPaymentSystem = value;
                                 selectedPaymentSystemData =snapshot.data!.firstWhere(
                                         (system) => system['name']==value);
                               });
                             },
                           );
                        },
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      hint: "eg.Khaled Ali",
                      label: "Card Holder Name",
                      hintColor: Colors.grey,
                      onValidate: (value) {
                        if(value== null || value.trim().length <6){
                          return "Provide Your full name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      controller: _cardNumberController,
                      keyboardType: TextInputType.number,
                      hint: "eg.1234 4567 7890",
                      label: "Card Number",
                      hintColor: Colors.grey,
                      inputFormatters: [maskFromatter],
                      onValidate: (value) {
                        if(value== null || value.replaceAll(' ', ' ').length !=16){
                          return "Card Number Must be Exactly 16 digits";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomTextField(
                      controller: _balanceController,
                      keyboardType: TextInputType.number,
                      hint: "40",
                      label: "Balance",
                      prefixtext: "\$",
                      hintColor: Colors.grey,
                      onChanged: (value) => balance= double.tryParse(value)??0.0 ,
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: ElevatedButton(
                        onPressed: () => addPaymentMethod(),
                        child: SizedBox(
                          width: 350,
                          child: Text(
                            "Add Payment Method",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
            ),
            ),
          ),
      ),
    );
  }

  void addPaymentMethod()async{
    if(!_formKey.currentState!.validate()){
      return;
    }
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if(userId != null && selectedPaymentSystemData != null){
      final paymentCollection = FirebaseFirestore.instance.collection("User Payment Method");
      final existingMethods = await paymentCollection.where("userId",isEqualTo:  userId).where("paymentSystem",isEqualTo: selectedPaymentSystemData!['name']).get();
      if(existingMethods.docs.isNotEmpty){
        SnackBarService.showErrorMessage('You Have Already added this Payment Method!');
        return;
      }
      await paymentCollection.add({
        'userName':_userNameController.text.trim(),
        'cardNumber':_cardNumberController.text.trim(),
        "balance":balance,
        'userId':userId,
        'paymentSystem': selectedPaymentSystemData!['name'],
        'image': selectedPaymentSystemData!['image'],
      });
      SnackBarService.showSuccessMessage('Payment Method Successfully added!');
      navigatorKey.currentState!.pop();
    }else{
      SnackBarService.showErrorMessage('Failed to add Payment Method');
    }
  }
}
