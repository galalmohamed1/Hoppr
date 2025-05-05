import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/extention/validations.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/consts/utlis/firebase-functions.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/providers/theme_provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // var provider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.lightScaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightScaffoldColor,
        title: Text(
          "Welcome",
          style: TextStyle(
            color:AppColors.primary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: AppColors.darkScaffoldColor,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Please sign in with your mail.",
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Email",
                    style: TextStyle(
                      color: AppColors.darkScaffoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                    child:
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      hint: "Email",
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "plz enter your email address";
                        }
                        if (!Validations.validateEmail(value)) {
                          return "plz enter a valid email address";
                        }
                        return null;
                      },
                      hintColor:  AppColors.gray,
                      prefixIcon: Icon(Icons.email,color:AppColors.gray,),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      color: AppColors.darkScaffoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                    child: CustomTextField(
                      keyboardType:TextInputType.visiblePassword,
                      controller: _passwordController,
                      isPassword: true,
                      maxLines: 1,
                      hint: "Password",
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "plz enter your password address";
                        }
                        return null;
                      },
                      hintColor:  AppColors.gray,
                      prefixIcon: Icon(Icons.lock,color: AppColors.gray,),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => navigatorKey.currentState!.pushNamed(PagesRouteName.ResetPassword),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            // decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:AppColors.darkScaffoldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          FirebaseFunctions.login(
                            emailAddress: _emailController.text,
                            password:_passwordController.text,
                          ).then((value) {
                            EasyLoading.dismiss();
                            // route();
                            if(value==false){
                              SnackBarService.showErrorMessage('The password oR Email provided is too weak.');
                            }
                          },
                          );
                        }
                        // navigatorKey.currentState!.pushNamedAndRemoveUntil(PagesRouteName.HomePage, (route) => false,);
                      },
                      child: SizedBox(
                        width: 350,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.lightScaffoldColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t Have Account ?",
                        style: TextStyle(
                          color:  AppColors.darkScaffoldColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () => navigatorKey.currentState!.pushNamed(PagesRouteName.SignUp),
                        child: Text(
                          "Create Account",
                          style: TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "Admin") {
          navigatorKey.currentState!.pushReplacementNamed(PagesRouteName.AdminHome);
        }else{
          navigatorKey.currentState!.pushReplacementNamed(PagesRouteName.HomePage);
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

}
