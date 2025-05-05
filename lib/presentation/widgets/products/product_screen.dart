import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/app_constans.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/providers/theme_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var provider =Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:Colors.white10,
      appBar: AppBar(
        backgroundColor:AppColors.lightScaffoldColor,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          navigatorKey.currentState!.pop();
        }, icon:Icon(Icons.arrow_back),
            color: AppColors.darkScaffoldColor,
        ),
        actions: [
             InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: (){},
                child:const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20.0),
                  child:  Icon(Icons.add_shopping_cart,size: 30,),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 285,
              color: Colors.white,
              child: Image(image: AssetImage(AppConstans.productimage),
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
