import 'package:flutter/material.dart';
import 'package:Hoppr/presentation/widgets/subtitle_text.dart';

class CategoriesRoundWidget extends StatelessWidget {
  const CategoriesRoundWidget({
    super.key, 
    required this.image, 
    required this.name});

  final String image, name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 50,
          width: 50,
          ),
          const SizedBox(height: 15,),
          SubtitleTextWidget(
            lable: name, 
            fontSize: 18,
            fontWeight: FontWeight.bold,
            ),
      ],
    );
  }
}