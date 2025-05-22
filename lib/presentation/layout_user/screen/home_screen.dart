import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/app_constans.dart';
import 'package:Hoppr/consts/services/assert_manager.dart';
import 'package:Hoppr/consts/utlis/cart_order_count.dart';
import 'package:Hoppr/presentation/layout_user/screen/category_items.dart';
import 'package:Hoppr/presentation/layout_user/screen/items_detail_screen/screen/items_detail_screen.dart';
import 'package:Hoppr/presentation/widgets/app_name_text.dart';
import 'package:Hoppr/presentation/layout_user/screen/items_detail_screen/widget/curated_items.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final CollectionReference categoriesItems =
      FirebaseFirestore.instance.collection("Category");

  final CollectionReference items =
  FirebaseFirestore.instance.collection("items");
  
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldColor,
      appBar: AppBar(
        title: AppNameTextWidget(fontSize: 25,),
        leading:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CartOrderCount(),
          ),
        ],
      ),
      // backgroundColor: AppColors.lightScaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              SizedBox(
                height: size.height*0.24,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  child: Swiper(
                          itemBuilder: (BuildContext context,int index){
                  return Image.asset(
                    AppConstans.bannerImage[index],
                    fit: BoxFit.fill,);
                          },
                          autoplay: true,
                          itemCount: AppConstans.bannerImage.length,
                          pagination: SwiperPagination(),
                          // control: SwiperControl(),//دول علشان يظهرو الاسهم جمب الصوره 
                        ),
                ),
              ),
              SizedBox(height: 15,),
              const TitlesTextWidget(
                label: "Shop By Category",
                fontSize: 20,
              ),
              StreamBuilder(
                stream: categoriesItems.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if(streamSnapshot.hasData){
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          streamSnapshot.data!.docs.length,
                              (index) => InkWell(
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) =>  CategoryItems(
                                    category: streamSnapshot.data!.docs[index]['name'],
                                    selectedCategory: streamSnapshot.data!.docs[index]['name'],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: AppColors.gray,
                                    backgroundImage: CachedNetworkImageProvider(
                                      streamSnapshot.data!.docs[index]['image'],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(streamSnapshot.data!.docs[index]['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                },
              ),
                SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitlesTextWidget(
                      label: "Curated For You",
                      fontSize: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigatorKey.currentState!.pushNamed(PagesRouteName.See_all_Data);
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                        color: AppColors.darkScaffoldColor,
                      ),),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              StreamBuilder(
                stream: items.snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          snapshot.data!.docs.length,
                              (index) {
                            final eCommerceItems = snapshot.data!.docs[index];
                            return Padding(padding: index == 0
                                ? EdgeInsets.symmetric(horizontal: 20)
                                : EdgeInsets.only(right: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) =>  ItemsDetailScreen(
                                          productItems: eCommerceItems,
                                        ),

                                      ));
                                },
                                child: CuratedItems(eCommerceItems: eCommerceItems, size: size),
                              ),
                            );
                          },
                        ),
                      ),

                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
              ),

            ],
          ),
        ),
      ),
    );
  }
}