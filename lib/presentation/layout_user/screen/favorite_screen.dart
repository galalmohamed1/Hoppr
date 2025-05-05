
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/services/assert_manager.dart';
import 'package:Hoppr/presentation/widgets/products/products_widget.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:Hoppr/providers/favorite_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//   late TextEditingController searchTextController;
//
//   @override
//   void initState() {
//     searchTextController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     searchTextController.dispose();
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider = ref.watch(favoriteProvider);
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();//دي علشان لو دوست علي الصفحه عادي او خاؤج السيرش يشيل الكيبورد 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: "Favorite"
            ),
          leading:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),),
        ),
        body: userId == null 
            ? Center(child: Text("Please Add The Favorite"),)
            :StreamBuilder(stream: FirebaseFirestore.instance.collection("userFavorite")
            .where('userId',isEqualTo: userId)
            .snapshots()
            , builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final favoriteDocs = snapshot.data!.docs;
              if(favoriteDocs.isEmpty){
                return Center(
                  child: Text("No favorite yet",style: TextStyle(fontWeight: FontWeight.bold),),
                );
              }
              return FutureBuilder<List<DocumentSnapshot>>(
                  future: Future.wait(
                      favoriteDocs.map(
                            (doc) => FirebaseFirestore.instance.collection('items')
                                .doc(doc.id)
                                .get(),
                      ),
                  ),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final favoriteItems= snapshot.data!.where((doc) => doc.exists ).toList();
                    if(favoriteItems.isEmpty){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: favoriteItems.length,
                        itemBuilder: (context, index) {
                          final favoriteItem = favoriteItems[index];
                          return GestureDetector(
                            onTap: () {

                            },
                            child: Stack(
                              children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                                image: CachedNetworkImageProvider(
                                                  favoriteItem['image'],
                                                ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(right: 20),
                                              child: Text(
                                                favoriteItem['name'],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                                ),
                                              ),
                                            ),
                                            Text("${favoriteItem['category']}"),
                                            Text(
                                              "\$${favoriteItem['price']}.00",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.pink,
                                              ),
                                            ),

                                          ],
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 50,
                                    right: 35,
                                    child: GestureDetector(
                                      onTap: () {
                                        provider.toggleFavorite(favoriteItem);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                ),
                                ),
                              ],
                            ),
                          );
                        },
                    );
                  },
              );
            },)
        // Padding(
        //   padding:  EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       SizedBox(height: 15.0,),
        //       TextField(
        //         controller: searchTextController,//دي علشان لما ادوس علي علامه ال x هيمسح الكلام من السيرش ويقفل الكيبورد 
        //         decoration: InputDecoration(
        //           filled: true,
        //           prefixIcon: const Icon(Icons.search,color: Colors.blue,),// ايكون السيرش
        //           suffixIcon: GestureDetector(//  و معاها الاكشن بتاعها اللي هو بيمسح الكلام من السيرشxايكون ال 
        //             onTap: () {
        //               // setState(() {
        //                   searchTextController.clear();
        //                   FocusScope.of(context).unfocus();
        //                 // });
        //             },
        //             child: const Icon(
        //               Icons.clear,
        //               color:Colors.blue,
        //               ),
        //            
        //             ),
        //       ),
        //       onChanged: (value) {
        //          
        //         },
        //       onSubmitted: (value) {
        //           log(searchTextController.text);
        //           },
        //       ),
        //       Expanded(
        //         child: DynamicHeightGridView(
        //           builder: ((context, index){
        //             return ProductsWidget();//  ProductsWidget
        //         }),
        //         itemCount: 50,
        //         crossAxisCount: 2,//دي علشان يقسمرالصفحه ل2
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}