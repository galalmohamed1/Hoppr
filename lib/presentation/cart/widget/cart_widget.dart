import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/app_constans.dart';
import 'package:Hoppr/presentation/cart/quantity_btm_sheet.dart';
import 'package:Hoppr/presentation/layout_user/model/cart_model.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';
import 'package:Hoppr/providers/cart_provider.dart';

class CartWidget extends ConsumerWidget {
  final CartModel cart;
  const CartWidget({super.key, required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp= ref.watch(cartService);
    Size size = MediaQuery.of(context).size;
    final finalPrice =num.parse((cart.productData['price']*(1-cart.productData['discountPercentage']/100)).toStringAsFixed(2));
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 120,
      width: size.width/1.1,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              CachedNetworkImage(
                imageUrl: cart.productData['image'],
                height: 120,
                width: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 20,),
              Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(cart.productData['name'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.black,
                          ),),
                          Spacer(),
                          IconButton(onPressed: (){
                            cp.deleteCartItem(cart.productId);
                          }, icon: Icon(Icons.delete_forever_rounded,color: Colors.red,), ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Size :"),
                          Text(
                            cart.selectedSize,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),)
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "\$$finalPrice",
                            style: TextStyle(
                              color: Colors.pink,
                              fontSize: 22,
                              letterSpacing: -1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 45,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if(cart.quantity > 1){
                                    cp.decreaseQuantity(cart.productId);
                                  }
                                },
                                child: Container(
                                  width: 25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadiusDirectional.vertical(
                                      top: Radius.circular(7),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(
                                  cart.quantity.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  cp.addCart(cart.productId, cart.productData, cart.selectedSize);
                                },
                                child: Container(
                                  width: 25,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadiusDirectional.vertical(
                                      top: Radius.circular(7),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
              ),
            ],
          )
        ],
      ),
    );
    // return FittedBox(// علشان يشيل الايرور من جمب الصفحه ويخلي السايز بتاعها مناسب للصفحه ومايكونش فيها ايرور و لازم نكتب معاها IntrinsicWidth
    //   child: IntrinsicWidth(
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Row(
    //         children: [
    //           ClipRRect(
    //             borderRadius: BorderRadius.circular(12),//دي علشان تخلي شكل الصوره فيها كيرفات
    //             child: FancyShimmerImage(// دي علشان احط الصوره من النت
    //               imageUrl: AppConstans.productimage,
    //               height: size.height *0.2,
    //               width: size.height * 0.2,
    //             ),
    //           ),
    //           const SizedBox(// علشان يدي فراغ بين كل حاجه
    //             width: 10.0,
    //           ),
    //           IntrinsicWidth(
    //             child: Column(
    //               children: [
    //               Row(
    //                 children: [
    //                   SizedBox(
    //                     width: size.width*0.6,
    //                     child: TitlesTextWidget(
    //                       label: "Airpods pro2 ",
    //                       maxLines: 2,
    //                     ),
    //                   ),
    //                   Column(
    //                     children: [
    //                       IconButton(
    //                         onPressed: (){},
    //                         icon: const Icon(Icons.delete),
    //                         ),
    //                         IconButton(
    //                     onPressed: (){},
    //                     icon: const Icon(
    //                       IconlyLight.heart,
    //                       ),
    //                     ),
    //                     ],
    //                   ),
    //
    //                 ],
    //               ),
    //               Row(
    //                 children: [
    //                   SubtitleTextWidget(
    //                     lable: "500\$",
    //                     fontSize: 20,
    //                     color: Colors.blue,
    //                     ),
    //                     Spacer(),
    //                     OutlinedButton.icon(
    //                       style: OutlinedButton.styleFrom(
    //                         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),//دي علشان لو عايز اغير من شكل الذرار
    //                         side: BorderSide(width: 2, color: Colors.blue),
    //                       ),
    //                       onPressed: ()async{
    //                         await showModalBottomSheet(
    //                           backgroundColor: Colors.white,
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(20.0),
    //                               topRight: Radius.circular(20.0),
    //                               ),
    //                               ),//دي علشان لو عايز اغير من شكل اللسته
    //
    //
    //                           context: context,
    //                           builder: (context){
    //                           return QuantityBtmSheetwidget();
    //                         });
    //                       },
    //                       icon: const Icon(IconlyLight.arrowDown2),
    //                       label: const Text("َQty: 1"),),
    //                     ],
    //               ),
    //               ],
    //             ),
    //           )
    //           ],
    //           ),
    //     ),
    //   ),
    // );
  }
}