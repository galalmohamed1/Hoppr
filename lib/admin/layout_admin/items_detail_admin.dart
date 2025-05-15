import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/utlis/cart_order_count.dart';
import 'package:Hoppr/providers/cart_provider.dart';
import 'package:Hoppr/providers/favorite_provider.dart';

class ItemsDetailAdmin extends ConsumerStatefulWidget {
  final DocumentSnapshot<Object?>  productItems;
  const ItemsDetailAdmin({super.key, required this.productItems});

  @override
  ConsumerState<ItemsDetailAdmin> createState() => _ItemsDetailAdminState();
}

class _ItemsDetailAdminState extends ConsumerState<ItemsDetailAdmin> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(favoriteProvider);
    Size size = MediaQuery.of(context).size;
    CartProvider cp = ref.watch(cartService);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black12,
        title: Text(widget.productItems['name']),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            height: size.height*0.46,
            width: size.width,
            child: PageView.builder(
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
                  ],
                );
              },),

          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productItems['brand'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black26,
                    fontSize: 15,
                  ),
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
                      "phone: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${(widget.productItems['phone'])}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        height: 1.5,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  widget.productItems['address'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(
                      "Size: ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      "${widget.productItems['Size']??"N/A"}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.pink,
                        letterSpacing: -0.5,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1.5,
                    color: Colors.pink,
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
