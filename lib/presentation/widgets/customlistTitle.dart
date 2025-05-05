import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath,text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: (){
        function();
      },
      leading:Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(lable: text,fontWeight: FontWeight.bold,),
      trailing: Icon(IconlyLight.arrowRight2),
    );
  }
}