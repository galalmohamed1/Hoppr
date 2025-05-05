import 'package:flutter/material.dart';
import 'package:Hoppr/consts/app_colors.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTab;
  final String buttonText;
  final Color? color; 
  const MyButton({super.key, required this.onTab, required this.buttonText, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTab,
    style: ElevatedButton.styleFrom(
      padding: const  EdgeInsets.symmetric(horizontal: 24,vertical: 12),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
    ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.lightScaffoldColor,
          ),
        ),
    );

  }
}
