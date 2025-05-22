import 'dart:math';

import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/presentation/layout_user/model/fcategory.dart';
import 'package:Hoppr/presentation/layout_user/screen/items_detail_screen/screen/items_detail_screen.dart';
import 'package:Hoppr/presentation/layout_user/screen/items_detail_screen/widget/curated_items.dart';
import 'package:Hoppr/providers/favorite_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeeAllData extends ConsumerStatefulWidget {

  const SeeAllData({
    super.key,
  });

  @override
  ConsumerState<SeeAllData> createState() => _SeeAllDataState();
}

class _SeeAllDataState extends ConsumerState<SeeAllData> {
  Map<String, Map<String,dynamic>> randomValueCache ={};
  TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot> allItems=[];
  List<QueryDocumentSnapshot> filteredItems=[];

  @override
  void initState() {
    searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(){
    String searchTerm = searchController.text.toLowerCase();
    setState(() {
      filteredItems = allItems.where((item) {
        final data =item.data() as Map<String,dynamic>;
        final itemName = data['name'].toString().toLowerCase();
        return itemName.contains(searchTerm);
      },).toList();
    });
  }
  final CollectionReference items =
  FirebaseFirestore.instance.collection("items");

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(favoriteProvider);
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      navigatorKey.currentState!.pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: Colors.grey[300],
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: Icon(Icons.search_rounded,color: Colors.black38,),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    filterCategory.length,
                        (index) => Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Row(
                          children: [
                            Text(filterCategory[index]),
                            SizedBox(width: 5),
                            index == 0
                                ? Icon(Icons.filter_list)
                                : Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: List.generate(
            //       fcategory.length,
            //           (index) => InkWell(
            //         onTap: (){},
            //         child: Column(
            //           children: [
            //             Container(
            //               padding: EdgeInsets.symmetric(horizontal: 16),
            //               child: CircleAvatar(
            //                 radius: 35,
            //                 backgroundColor: AppColors.gray,
            //                 backgroundImage: AssetImage(
            //                   fcategory[index].image,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: 10,),
            //             Text(fcategory[index].name,
            //               style: TextStyle(fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child:StreamBuilder<QuerySnapshot>(
                  stream: items.snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final items = snapshot.data!.docs;
                      if (allItems.isEmpty) {
                        allItems = items;
                        filteredItems = items;
                      }
                      if (filteredItems.isEmpty) {
                        return Center(
                          child: Text("No Items Found."),
                        );
                      }
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: filteredItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final doc = filteredItems[index];
                          final item = doc.data() as Map<String,dynamic>;
                          final itemId = doc.id;
                          /// check if random value are already cached
                          if(!randomValueCache.containsKey(itemId)){
                            randomValueCache[itemId] ={
                              "rating":"${Random().nextInt(2)+3}.${Random().nextInt(5)+4}",
                              "reviews":Random().nextInt(300)+100
                            };
                          }
                          final cachRating =randomValueCache[itemId]!['rating'];
                          final cachReviews =randomValueCache[itemId]!['reviews'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemsDetailScreen(productItems: doc,),

                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: doc.id,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          item['image'],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: size.height * 0.25,
                                    width: size.width * 0.5,
                                    child: Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          radius: 18,
                                          backgroundColor: provider.isExist(items[index])
                                              ?Colors.white
                                              :Colors.black26,
                                          child: GestureDetector(
                                            onTap: () {
                                              ref.read(favoriteProvider).toggleFavorite(items[index]);
                                            },
                                            child: Icon(
                                              provider.isExist(items[index])
                                                  ?Icons.favorite
                                                  :Icons.favorite_border,
                                              color: provider.isExist(items[index])
                                                  ?Colors.red
                                                  :Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 7,),
                                Row(
                                  children: [
                                    Text(
                                      item['category'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black26,
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 17,
                                    ),
                                    Text("${cachRating}"),
                                    SizedBox(width: 3,),
                                    Text(
                                      "${cachReviews}",
                                      style: TextStyle(
                                        color: Colors.black26,

                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  width: size.width * 0.5,
                                  child: Text(
                                    item['name'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$${(item['price']*(1-item['discountPercentage']/100)).toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors.pink,
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    if(item['isDiscounted'] == true)
                                      Text(
                                        "\$${item['price']}.00",
                                        style: TextStyle(
                                          color: Colors.black26,
                                          decorationColor: Colors.black26,
                                          decoration: TextDecoration
                                              .lineThrough,
                                        ),
                                      ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        },
                      );
                    }
                    if(snapshot.hasError){
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
