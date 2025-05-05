import 'package:flutter/material.dart';
import 'package:Hoppr/consts/app_colors.dart';

class Styles{
  static ThemeData themeData(
    {required isDarktheme,required BuildContext context}){
      return ThemeData(
        scaffoldBackgroundColor: isDarktheme
        ?AppColors.darkScaffoldColor
        :AppColors.lightScaffoldColor,
        cardColor: isDarktheme
        ? const Color.fromARGB(255, 13, 6, 37)
        : AppColors.lightScaffoldColor,
        brightness: isDarktheme ? Brightness.dark : Brightness.light,//بتخلي اللون بتاع الكلام يتغير مع لون المود 
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: isDarktheme? Colors.white : Colors.black,),
        backgroundColor: isDarktheme
        ?AppColors.darkScaffoldColor
        :AppColors.lightScaffoldColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: isDarktheme ? Colors.white : Colors.black,
        ),
        ),
        inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: isDarktheme ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(// دي علشان لو في ايروور في دخول اليوذر يظهرله الايروور 
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(// ودي علشان لما يدوس علي الايروور يرجع لون الكتابه الطبيعي 
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      ); 
  }
}