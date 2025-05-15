import 'package:Hoppr/admin/layout_admin/items_detail_admin.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/main.dart';

class ViewedAllOrderNotFound extends ConsumerStatefulWidget {
  const ViewedAllOrderNotFound({super.key});

  @override
  ConsumerState<ViewedAllOrderNotFound> createState() => _ViewedAllOrderNotFoundState();
}

class _ViewedAllOrderNotFoundState extends ConsumerState<ViewedAllOrderNotFound> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("All New Order Not Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("New_Order").snapshots(),
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
                        final item=documents[index].data() as Map<String,dynamic>;
                        final doc = documents[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10,top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ItemsDetailAdmin(productItems: doc,),

                                  ));
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 2,
                              child: ListTile(
                                leading: Hero(
                                  tag: doc.id,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: item['image'],
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item['name']?? "N/A",
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
                                          "${item['brand']??"N/A"}",
                                          style: TextStyle(
                                            fontWeight:FontWeight.w600,
                                            fontSize: 15,
                                            letterSpacing: -1,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "${item['Size']??"N/A"}",
                                          style: TextStyle(
                                            fontWeight:FontWeight.w600,
                                            fontSize: 15,
                                            letterSpacing: -1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${item['Description']??"N/A"}",
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
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
