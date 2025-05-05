import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_constans.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';
import 'package:Hoppr/providers/theme_provider.dart';

class LatestArrival extends StatelessWidget {
  const LatestArrival({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=  MediaQuery.of(context).size;
    // var provider =Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        // borderRadius: BorderRadius.circular(30.0),
        onTap: (){
          navigatorKey.currentState!.pushNamed(PagesRouteName.Products);
        },
        child: Container(
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color:Colors.black),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  width: 60,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image:  AssetImage(
                      AppConstans.productimage,
                    ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         Expanded(
                           child: TitlesTextWidget(
                              label: "GOLI APPLE CIDER VINEGAR GUMMIES *30",
                              maxLines: 1,
                             fontSize: 20,
                            ),
                         ),
                        Spacer(),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(IconlyLight.heart,),
                        ),
                        // SizedBox(width: 1,)
                      ],

                    ),
                    Text("Brand: Goli"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SubtitleTextWidget(
                          lable: "500\$",
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10.0),),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: (){},
                            child:const Padding(
                              padding:  EdgeInsets.all(8.0),
                              child:  Icon(Icons.add_shopping_cart,size: 18,),
                            ),
                          ),
                        ),
                        SizedBox(width: 6,),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // SizedBox(height: 10,),
// Container(
// // height: 133,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// image: DecorationImage(image:  AssetImage(
// AppConstans.productimage,
// ),
// fit: BoxFit.cover,
// ),
// ),
//
// ),
// SizedBox(width: 7,),
// Flexible(//دي علشان تعدل حجم الصوره
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,//دي علشان يخلي الكلام والسعر يبداو من اول الصفحه
// children: [
// Text(
// "Airpods pro2"*1,
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// ),
// FittedBox(// دي علشان تشيل الايرور من الشاشه
// child: Row(
// children: [
// IconButton(
// onPressed: (){},
// icon: Icon(IconlyLight.heart,
// size: 20,),
// ),
// IconButton(
// onPressed: (){},
// icon: Icon(
// Icons.add_shopping_cart_rounded,
// size: 20,
// ),
// ),
// ],
// ),
// ),
// const FittedBox(child: SubtitleTextWidget(lable: "139\$",)),
// ],
// ),
// ),
//
// ],
// ),