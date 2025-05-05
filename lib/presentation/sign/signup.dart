import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/extention/validations.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/utlis/firebase-functions.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/providers/theme_provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey= GlobalKey<FormState>();
  final _nameController=TextEditingController();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  String _selectedRole = 'User';
  @override
  Widget build(BuildContext context) {
    // var provider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:  AppColors.lightScaffoldColor,
      appBar: AppBar(
        title: Text(
          "Create New Account",
          style: TextStyle(
            color:AppColors.primary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Name",
                    style: TextStyle(
                      color: AppColors.darkScaffoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                  child:CustomTextField(
                    controller: _nameController,
                    hint: "Name",
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your Name";
                      }
                      return null;
                    },
                    hintColor:  AppColors.gray,
                    prefixIcon: Icon(Icons.person,color: AppColors.gray,),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: AppColors.darkScaffoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                  child:CustomTextField(
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
                    prefixIcon: Icon(Icons.email,color: AppColors.gray,),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Password",
                    style: TextStyle(
                      color: AppColors.darkScaffoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                  child:  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Re-Password",
                    style: TextStyle(
                      color: AppColors.darkScaffoldColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
                  child: CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    maxLines: 1,
                    hint: "Re-Password",
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "plz enter your password address";
                      }
                      if (value != _passwordController.text) {
                        return "password not match";
                      }
                      return null;
                    },
                    hintColor:  AppColors.gray,
                    prefixIcon: Icon(Icons.lock,color: AppColors.gray,),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedRole,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRole = newValue!; // Update role selection
                      });
                    },
                    items: ['Admin', 'User'].map((role) {
                      return DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        FirebaseFunctions.createAccounts(
                          Name: _nameController.text,
                          email: _emailController.text,
                          password:_passwordController.text,
                          role: _selectedRole,
                        ).then((value){
                          EasyLoading.dismiss();
                          if(value==true){
                            navigatorKey.currentState!.pushNamedAndRemoveUntil(PagesRouteName.LoginPage, (route) => false,
                            );
                          }
                        });
                      }
                    },

                    child: SizedBox(
                      width: 350,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.darkScaffoldColor,
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
                      "Already Have Account ?",
                      style: TextStyle(
                        color: AppColors.darkScaffoldColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () => navigatorKey.currentState!.pop(),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          // decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
