import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/main.dart';

class ViewedAllItems extends ConsumerStatefulWidget {
  const ViewedAllItems({super.key});

  @override
  ConsumerState<ViewedAllItems> createState() => _ViewedAllItemsState();
}

class _ViewedAllItemsState extends ConsumerState<ViewedAllItems> {
  final CollectionReference items=FirebaseFirestore.instance.collection("items");
  final String uid= FirebaseAuth.instance.currentUser!.uid;
  String? selectedCategory;
  List<String> categories=[];
  @override
  void initState() {
    fetchCategories();
    super.initState();
  }
  Future<void> fetchCategories()async{
    QuerySnapshot snapshot=
    await FirebaseFirestore.instance.collection("Category").get();
    setState(() {
      categories=snapshot.docs.map((doc) => doc['name'] as String ,).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("All Items",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),

        actions: [
          DropdownButton<String>(
              items: categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                    child: Text(category),
                );
              }).toList(),
              icon: Icon(Icons.tune),
              underline: SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory=newValue;
                });
              },
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     IconButton(onPressed: () {
              //       navigatorKey.currentState!.pop();
              //     }, icon: Icon(Icons.arrow_back)),
              //     Spacer(),
              //     Text("All Items",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
              //     Spacer(),
              //     DropdownButton<String>(
              //       items: categories.map((String category) {
              //         return DropdownMenuItem(
              //           value: category,
              //           child: Text(category),
              //       );}).toList(),
              //       icon: Icon(Icons.tune),
              //       underline: SizedBox(),
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           selectedCategory=newValue;
              //         });
              //         },
              //     ),
              //   ],
              // ),
              Expanded(
                  child: StreamBuilder(
                      stream: items.where("uploadedBy",isEqualTo: uid).where("category",isEqualTo: selectedCategory).snapshots(),
                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                        if(snapshot.hasError){
                          return const Center(
                            child: Text("Error loading items,"),
                          );
                        }
                        final documents = snapshot.data?.docs ?? [];
                        if(documents.isEmpty){
                          return const Center(
                            child: Text("No items uploded,"),
                          );
                        }
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final items=documents[index].data() as Map<String,dynamic>;
                            return Padding(
                                padding: EdgeInsets.only(bottom: 10,top: 10),
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 2,
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: items['image'],
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    items['name']?? "N/A",
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              items['price'] !=null
                                                  ? "\$${items['price']}.00":"N/A",
                                            style: TextStyle(
                                              fontWeight:FontWeight.w600,
                                              fontSize: 15,
                                              letterSpacing: -1,
                                              color: Colors.red,
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Text(
                                            "${items['category']??"N/A"}",
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: documents.length,
                        );
                      },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
