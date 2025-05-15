import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/services/assert_manager.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/presentation/widgets/customlistTitle.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';
import 'package:Hoppr/providers/cart_provider.dart';
import 'package:Hoppr/providers/favorite_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/presentation/widgets/app_name_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminHomeScreen extends ConsumerStatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  ConsumerState<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends ConsumerState<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // var provider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await navigatorKey.currentState!.pushNamed(PagesRouteName.Admin_Add_Items);

      },child: Icon(Icons.add),backgroundColor: AppColors.primary,),
      appBar: AppBar(
        title: AppNameTextWidget(fontSize: 25,),
        leading:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(padding: EdgeInsets.all(20.0),
                child: TitlesTextWidget(
                    label: "Please login to have ultimate access"
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      // ignore: deprecated_member_use
                        color: Theme.of(context).colorScheme.background,
                        width: 3
                    ),
                    image: const DecorationImage(
                      image: NetworkImage("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 7,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: TextStyle(
                        color: AppColors.darkScaffoldColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.email!,
                      style: TextStyle(
                        color:AppColors.darkScaffoldColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(label: "General"),
                  Stack(
                    children: [
                      CustomListTitle(
                        imagePath: AssetsManager.orderSvg,
                        text: "All Order",
                        function: (){
                          navigatorKey.currentState!.pushNamed(PagesRouteName.Admin_order_screen);
                        },
                      ),
                      Positioned(
                          top: 6,
                          left: 5,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("Orders").snapshots(),
                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                if(snapshot.hasError){
                                  return Text("Error Loading Order.");
                                }
                                final orderCount = snapshot.data?.docs.length;
                                return CircleAvatar(
                                  radius: 9,
                                  backgroundColor: Colors.red,
                                  child: Center(
                                    child: Text(
                                      orderCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ))
                    ],
                  ),
                  Stack(
                    children: [
                      CustomListTitle(
                        imagePath: AssetsManager.recent,
                        text: "Add Order Not Found in App",
                        function: (){
                          navigatorKey.currentState!.pushNamed(PagesRouteName.View_all_order_not_Found);
                        },
                      ),
                      Positioned(
                          top: 6,
                          left: 5,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection("New_Order").snapshots(),
                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(child: CircularProgressIndicator(),);
                                }
                                if(snapshot.hasError){
                                  return Text("Error Loading Order.");
                                }
                                final orderCount = snapshot.data?.docs.length;
                                return CircleAvatar(
                                  radius: 9,
                                  backgroundColor: Colors.red,
                                  child: Center(
                                    child: Text(
                                      orderCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                );
                              }
                          ))
                    ],
                  ),
                  CustomListTitle(
                    imagePath: AssetsManager.recent,
                    text: "Viewed All Add Items",
                    function: (){
                      navigatorKey.currentState!.pushNamed(PagesRouteName.Admin_Viewed_all_Items);
                    },
                  ),

                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                ],
              ),
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                ),
                onPressed: (){
                  navigatorKey.currentState!.pushNamedAndRemoveUntil(PagesRouteName.LoginPage, (route) => false,);
                  ref.invalidate(cartService);
                  ref.invalidate(favoriteProvider);
                },
                icon: const Icon(Icons.login),
                label: const Text(
                  "Log out",
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
