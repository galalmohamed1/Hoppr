import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/consts/utlis/cart_order_count.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/payment/payment_method_list.dart';
import 'package:Hoppr/presentation/layout_user/model/app_model.dart';
import 'package:Hoppr/presentation/layout_user/screen/items_detail_screen/controller/place_order_controller.dart';
import 'package:Hoppr/presentation/layout_user/screen/items_detail_screen/widget/size.dart';
import 'package:Hoppr/providers/cart_provider.dart';
import 'package:Hoppr/providers/favorite_provider.dart';

class ItemsDetailScreen extends ConsumerStatefulWidget {
  final DocumentSnapshot<Object?>  productItems;
  const ItemsDetailScreen({super.key, required this.productItems});

  @override
  ConsumerState<ItemsDetailScreen> createState() => _ItemsDetailScreenState();
}

class _ItemsDetailScreenState extends ConsumerState<ItemsDetailScreen> {
  int currentIndex=0;
  int selectedSizeIndex=0;
  String? selectedPaymentMethodId; /// to track selected payment method id
  double? selectedPaymentBalance; /// to track selected payment method balance

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(favoriteProvider);
    Size size = MediaQuery.of(context).size;
    CartProvider cp = ref.watch(cartService);
    final finalPrice = num.parse(
        (widget.productItems['price']
            *(1-widget.productItems['discountPercentage']/100)).toStringAsFixed(2),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black12,
        title: Text(widget.productItems['name']),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CartOrderCount(),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: size.height*0.46,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              return Column(
                children: [
                  Hero(
                    tag:widget.productItems.id,
                    child: CachedNetworkImage(
                      imageUrl: widget.productItems['image'],
                      width: size.width*0.85,
                      height: size.height*0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => AnimatedContainer(
                        duration: Duration(microseconds: 300),
                      margin: EdgeInsets.only(right: 4),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index==currentIndex? Colors.blue : Colors.grey.shade400,
                      ),
                    ),
                    ),
                  ),
                ],
              );
            },),

          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.productItems['category'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 17,
                    ),
                    Text("${Random().nextInt(2)+3}.${Random().nextInt(5)+4}",),
                    SizedBox(width: 3,),
                    Text(
                      "${Random().nextInt(300)+100}",
                      style: TextStyle(
                        color: Colors.black26,

                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        provider.toggleFavorite(widget.productItems);
                      },
                        child: Icon(
                          provider.isExist(widget.productItems)
                              ?Icons.favorite
                              :Icons.favorite_border,
                          color: provider.isExist(widget.productItems)
                              ?Colors.red
                              :Colors.black,
                        ),
                    ),
                  ],
                ),
                Text(
                  widget.productItems['name'],
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$${(widget.productItems['price']*(1-widget.productItems['discountPercentage']/100)).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.5,
                        color: Colors.pink,
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(widget.productItems['isDiscounted'] == true)
                      Text(
                        "\$${widget.productItems['price']}.00",
                        style: TextStyle(
                          color: Colors.black26,
                          decorationColor: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "Description",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  widget.productItems['Description'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 20,),
                SizeScreen(
                    sizes: widget.productItems['Size'],
                    onSizeSelected: (index) {
                      setState(() {
                        selectedSizeIndex = index;
                      });
                    },
                    selectedSizedIndex: selectedSizeIndex,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
      FloatingActionButton.extended(
          onPressed: () {
      },
        backgroundColor: Colors.white,
          label: SizedBox(
            width: size.width * 0.9,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        final productId = widget.productItems.id;
                        final productData = widget.productItems.data() as Map<String,dynamic>;
                        final selectedSize = widget.productItems['Size'][selectedSizeIndex];

                        cp.addCart(
                          productId,
                          productData,
                          selectedSize,
                        );

                        SnackBarService.showSuccessMessage(
                            "${productData['name']} added to cart!"
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag_outlined,color: Colors.black,),
                          SizedBox(width: 5,),
                          Text(
                            "ADD To CART",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: -1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: GestureDetector(
                    onTap: () async{
                      final productId = widget.productItems.id;
                      final productData = widget.productItems.data() as Map<String,dynamic>;
                      final selectedSize = widget.productItems['Size'][selectedSizeIndex];
                      _showOrderConfirmationDialog(
                        context,
                        cp,
                        productId,
                        productData,
                        selectedSize,
                        finalPrice +4.99,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      color: Colors.black,
                      child: Center(
                        child: Text(
                          "BY NOW",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );

  }
  void _showOrderConfirmationDialog(
      BuildContext context,
      CartProvider cp,
      String productId,
      Map<String, dynamic> productData,
      String selectedSize,
      finalPrice,
      ){
    String? addressError;
    TextEditingController addressController= TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState){
          return AlertDialog(
            title: Text("Confirm Your Order"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Product Name: ${productData['name']}"),
                  Text("Quantity: 1"),
                  Text("Selected Size: $selectedSize"),
                  Text("TotalPrice: \$$finalPrice"),
                  SizedBox(height: 10,),

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
                    finalAmount: finalPrice,
                    onPaymentMethodSelected: (p0, p1) {
                      setState(() {
                        selectedPaymentBalance = p1;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {
                        if (selectedPaymentMethodId == null) {
                          SnackBarService.showErrorMessage(
                              'Please Select a Payment Method!');
                        } else if (selectedPaymentBalance! < finalPrice) {
                          SnackBarService.showErrorMessage(
                              'Insufficient balance in selected payment method!');
                        } else if (addressController.text.length < 8) {
                          setState(() {
                            SnackBarService.showErrorMessage(
                                'Your address must be reflect your address identity');
                          });
                        } else {
                          placeOrder(
                            productId,
                            productData,
                            selectedSize,
                            selectedPaymentMethodId!,
                            finalPrice,
                            addressController.text,
                            context,
                          );
                        }
                      }, child: Text("Confirm")),
                      TextButton(onPressed: () {
                        navigatorKey.currentState!.pop();
                      }, child: Text("Cancel")),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
    },
    );
  }
}
