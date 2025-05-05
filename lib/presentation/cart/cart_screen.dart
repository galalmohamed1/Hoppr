import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/payment/payment_method_list.dart';
import 'package:Hoppr/presentation/cart/widget/cart_widget.dart';
import 'package:Hoppr/providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  String? selectedPaymentMethodId; /// to track selected payment method id
  double? selectedPaymentBalance; /// to track selected payment method balance
  final bool isEmpty= false;
  TextEditingController addressController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cp = ref.watch(cartService);
    final carts = cp.carts.reversed.toList();
    return Scaffold(
      // bottomSheet: BottomCheckout(),
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title:Text("Cart (${cp.carts.length.toString()})",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading:
            IconButton(onPressed: () {
              navigatorKey.currentState!.pop();
            }, icon: Icon(Icons.arrow_back_ios_new_outlined)
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child:carts.isNotEmpty? ListView.builder(
              itemCount: carts.length,
              physics: BouncingScrollPhysics(),
              itemBuilder:(context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
                  child: GestureDetector(
                    onTap: () {

                    },
                      child: CartWidget(cart: carts[index],),
                  ),
                );
            },
            ):Center(
              child: Text(
                "You Cart is Empty!",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          if(carts.isNotEmpty) _buildSummarySection(context, cp)
        ],
      ),
    );
  }
  Widget _buildSummarySection(BuildContext context, CartProvider cp){
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Delivery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                  child:Divider(
                    thickness: 2,
                  ),
              ),
              SizedBox(width: 10,),
              Text(
                "\$4.99",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text(
                "Total Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child:Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(width: 10,),
              Text(
                "\$${(cp.totalCart()).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          MaterialButton(
            padding: EdgeInsets.all(17),
            minWidth: MediaQuery.of(context).size.width-50,
            color: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              _showOrderConfirmationDialog(context, cp);
          },
            child: Text(
              "pay \$${(cp.totalCart()+4.99).toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _showOrderConfirmationDialog(BuildContext context, CartProvider cp){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Confirm Your Order"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListBody(
                children: cp.carts.map((cartItem) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${cartItem.productData['name']} * ${cartItem.quantity}")
                    ],
                  );
                },).toList(),
              ),
              Text("Total Payable Price: \$${(cp.totalCart()+4.99).toStringAsFixed(2)}"),
              /// to display the List of available Payment Method

              SizedBox(height: 10,),
              Text(
                "Selected Payable Method: ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10,),
              PaymentMethodList(
                  selectedPaymentMethodId: selectedPaymentMethodId,
                  selectedPaymentBalance: selectedPaymentBalance,
                  finalAmount: cp.totalCart() +4.99,
                  onPaymentMethodSelected: (p0, p1) {
                    setState(() {
                      selectedPaymentBalance= p1;
                      selectedPaymentMethodId = p0;
                    });
                  },
              ),

              /// to add the address
              Text(
                "Add you Delivery Address",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 5,),
              CustomTextField(
                controller: addressController,
                hint: "Enter your address",
                hintColor: Colors.grey,
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            if(selectedPaymentMethodId == null){
              SnackBarService.showErrorMessage('Please Select a Payment Method!');
            }else if(selectedPaymentBalance! < cp.totalCart()+4.99){
              SnackBarService.showErrorMessage('Insufficient balance in selected payment method!');
            }else if(addressController.text.length<8){
              setState(() {
                SnackBarService.showErrorMessage('Your address must be reflect your address identity');
              });
            }else{
              _saveOrder(cp, context);
            }
          }, child: Text("Confirm")),
          TextButton(onPressed: () {
            navigatorKey.currentState!.pop();
          }, child: Text("Cancel")),
        ],
      );
    },
    );
  }
  Future<void> _saveOrder(CartProvider cp, BuildContext context)async{
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if(userId == null){
      SnackBarService.showErrorMessage('You need to be logged in to place an order. ');
      return;
    }
    await cp.saveOrder(userId, context, selectedPaymentMethodId, cp.totalCart()+4.99, addressController.text);
    SnackBarService.showSuccessMessage('Order Placed Successfully!');
    navigatorKey.currentState!.pushNamed(PagesRouteName.my_order_screen);
  }
}
