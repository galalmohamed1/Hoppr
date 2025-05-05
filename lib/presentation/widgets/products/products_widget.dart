import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/app_constans.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/presentation/widgets/products/product_screen.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';
import 'package:Hoppr/presentation/widgets/title_text.dart';
import 'package:Hoppr/providers/theme_provider.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var provider =Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        // borderRadius: BorderRadius.circular(30.0),
        onTap: (){
          navigatorKey.currentState!.pushNamed(PagesRouteName.Products,);
        },
        child: Container(
          width: 167,
          // height: 243,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.white,
            border: Border.all(color:Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 133,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image:  AssetImage(
                      AppConstans.productimage,
                    ),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
                Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: TitlesTextWidget(
                        label: "GOLI APPLE CIDER VINEGAR GUMMIES *30",
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.favorite,size: 27,color: Colors.red,),
                      ),
                    ),
                    SizedBox(width: 5,)
                  ],

                ),
                Text("Brand: Goli",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                // Spacer(),
                SubtitleTextWidget(
                  lable: "500\$",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                ElevatedButton(
                  onPressed: () {

                },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black),
                      shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                          ),
                      ),
                  ),
                  child:  SizedBox(
                    width: 156,
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          color:Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                      ),
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}