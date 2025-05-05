import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:Hoppr/presentation/cart/cart_screen.dart';
import 'package:Hoppr/presentation/layout_user/screen/favorite_screen.dart';
import 'package:Hoppr/presentation/layout_user/screen/home_screen.dart';
import 'package:Hoppr/presentation/layout_user/screen/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  List <Widget> Screens=[
    const HomeScreen(),
    const FavoriteScreen(),
    // const CartScreen(),
    const ProfileScreen(),
  ];
  int currentScreen = 0;
  @override
  void initState() {
    super.initState();
    controller =PageController(initialPage: currentScreen);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller ,
        physics: const NeverScrollableScrollPhysics(),
        children: Screens,
      ),
      bottomNavigationBar: NavigationBar(// من اول هنا بيكون كود عمل البار اللي بيكون في اسفل الشاشه
        selectedIndex: currentScreen,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index){
        setState(() {
          currentScreen = index;
        });
        controller.jumpToPage(currentScreen);// دي علشان لما تدوس علي اي ايكون في البار ينتقل للصفحه التانيه 
      },
       destinations: const [
        NavigationDestination(// هنا وضع كل ايكون في البار 
          selectedIcon: Icon(IconlyBold.home),
          icon: Icon(IconlyLight.home),
           label: "Home",
           ),
           NavigationDestination(
          selectedIcon: Icon(IconlyBold.heart),
          icon: Icon(IconlyLight.heart),
           label: "Favorite",
           ),
          //  NavigationDestination(
          // selectedIcon: Icon(IconlyBold.bag2),
          // icon: Badge(
          //
          //   label: Text("0"),
          //   child: Icon(IconlyLight.bag2)),
          //  label: "Cart",
          //  ),
           NavigationDestination(
          selectedIcon: Icon(IconlyBold.profile),
          icon: Icon(IconlyLight.profile),
           label: "Profile",
           ),
        ],),
    );
  }
}