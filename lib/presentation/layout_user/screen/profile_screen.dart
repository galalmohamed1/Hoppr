import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/presentation/widgets/customlistTitle.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';
import 'package:Hoppr/providers/cart_provider.dart';
import 'package:Hoppr/providers/favorite_provider.dart';
import 'package:Hoppr/providers/theme_provider.dart';
import 'package:Hoppr/consts/services/assert_manager.dart';
import 'package:Hoppr/presentation/widgets/app_name_text.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
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
                            color: AppColors.darkScaffoldColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),],
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
                     CustomListTitle(
                      imagePath: AssetsManager.orderSvg,
                      text: "All Order",
                      function: (){
                        navigatorKey.currentState!.pushNamed(PagesRouteName.my_order_screen);
                      },
                      ),
                     GestureDetector(
                       onTap: () {
                         navigatorKey.currentState!.pushNamed(PagesRouteName.Payment_Screen);
                       },
                       child: Row(
                         children: [
                           SizedBox(width: 18,),
                           Icon(Icons.payments),
                           SizedBox(width: 20,),
                           SubtitleTextWidget(lable: "Payment Method",fontWeight: FontWeight.bold),
                           Spacer(),
                           Icon(IconlyLight.arrowRight2),
                           SizedBox(width: 25,),
                         ],
                       ),
                     ),
                     CustomListTitle(
                      imagePath: AssetsManager.recent,
                      text: "About Us",
                      function: (){},
                      ),
                    // CustomListTitle(
                    //   imagePath: AssetsManager.address,
                    //   text: "Address",
                    //   function: (){},
                    //   ),
                    // const Divider(
                    //   thickness: 2,
                    //   ),
                    //   const SizedBox(
                    //     height: 20,
                    //   ),
                    // TitlesTextWidget(label: "Settings"),
                  //   SwitchListTile(
                  //     secondary: Image.asset(
                  //       AssetsManager.theme,
                  //       height: 30,
                  //       ),
                  // title: Text(provider.getIsDarkTheme ? "Dark mode": "Light mode"),
                  //
                  //  value: provider.getIsDarkTheme,
                  //  onChanged: (value){
                  //    provider.setDarkTheme(themeValue: value);
                  //  },
                  // ),
                  const Divider(
                      thickness: 2,
                      ),
                  TitlesTextWidget(label: "Others"),
                  CustomListTitle(
                      imagePath: AssetsManager.privacy,
                      text: "privacy & Policy",
                      function: (){},
                      ), 
        
                    ],
                  ),
                ),
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


