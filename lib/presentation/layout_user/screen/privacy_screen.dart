// import 'package:Hoppr/consts/app_colors.dart';
// import 'package:Hoppr/consts/extention/validations.dart';
// import 'package:Hoppr/consts/services/snack_bar_service.dart';
// import 'package:Hoppr/consts/utlis/firebase-functions.dart';
// import 'package:Hoppr/consts/widget/custom_text_field.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:local_auth/local_auth.dart';
//
// class PrivacyScreen extends StatefulWidget {
//   const PrivacyScreen({super.key});
//
//   @override
//   State<PrivacyScreen> createState() => _PrivacyScreenState();
// }
//
// class _PrivacyScreenState extends State<PrivacyScreen> {
//   final LocalAuthentication auth = LocalAuthentication();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final newEmailController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   final _PhoneController=TextEditingController();
//   bool _authenticated = false;
//
//   final _auth = FirebaseAuth.instance;
//   Future<bool> _authenticate() async {
//
//       return await auth.authenticate(
//         localizedReason: 'الرجاء التحقق بالبصمة للدخول',
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//         ),
//       );
//   }
//   Future<void> _updateCredentials() async {
//     try {
//       final user = _auth.currentUser;
//       final credential = EmailAuthProvider.credential(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       await user!.reauthenticateWithCredential(credential);
//      FirebaseFunctions.updateUserEmail(newEmailController.text.trim());
//      FirebaseFunctions.updateUserPassword(newPasswordController.text.trim());
//      SnackBarService.showSuccessMessage(("Updated successfully"));
//     } catch (e) {
//       SnackBarService.showErrorMessage(("Error: $e"));
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightScaffoldColor,
//       appBar: AppBar(
//           title: const Text("Privacy"),
//         centerTitle: true,
//         backgroundColor: AppColors.lightScaffoldColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child:SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //  Text(
//                   //   "Phone",
//                   //   style: TextStyle(
//                   //     color: AppColors.darkScaffoldColor,
//                   //     fontSize: 22,
//                   //     fontWeight: FontWeight.bold,
//                   //   ),
//                   // ),
//                   // Padding(
//                   //   padding:
//                   //   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
//                   //   child:
//                   //   CustomTextField(
//                   //     keyboardType: TextInputType.emailAddress,
//                   //     controller: _PhoneController,
//                   //     hint: "Phone",
//                   //     hintColor:  AppColors.gray,
//                   //     prefixIcon: Icon(
//                   //       Icons.phone,
//                   //       color:AppColors.gray,
//                   //     ),
//                   //   ),
//                   // ),
//                   Text(
//                     "Email",
//                     style: TextStyle(
//                       color: AppColors.darkScaffoldColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
//                     child:
//                     CustomTextField(
//                       keyboardType: TextInputType.emailAddress,
//                       controller: emailController,
//                       hint: "Email",
//                       onValidate: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return "plz enter your email address";
//                         }
//                         if (!Validations.validateEmail(value)) {
//                           return "plz enter a valid email address";
//                         }
//                         return null;
//                       },
//                       hintColor:  AppColors.gray,
//                       prefixIcon: Icon(Icons.email,color:AppColors.gray,),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Password",
//                     style: TextStyle(
//                       color: AppColors.darkScaffoldColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
//                     child: CustomTextField(
//                       keyboardType:TextInputType.visiblePassword,
//                       controller: passwordController,
//                       isPassword: true,
//                       maxLines: 1,
//                       hint: "Password",
//                       onValidate: (value) =>Validations.validatePassword(value ?? ''),
//                       hintColor:  AppColors.gray,
//                       prefixIcon: Icon(Icons.lock,color: AppColors.gray,),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Text(
//                     "New Email",
//                     style: TextStyle(
//                       color: AppColors.darkScaffoldColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
//                     child:
//                     CustomTextField(
//                       keyboardType: TextInputType.emailAddress,
//                       controller: newEmailController,
//                       hint: "New Email",
//                       onValidate: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return "plz enter your email address";
//                         }
//                         if (!Validations.validateEmail(value)) {
//                           return "plz enter a valid email address";
//                         }
//                         return null;
//                       },
//                       hintColor:  AppColors.gray,
//                       prefixIcon: Icon(Icons.email,color:AppColors.gray,),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     " New Password",
//                     style: TextStyle(
//                       color: AppColors.darkScaffoldColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
//                     child: CustomTextField(
//                       keyboardType:TextInputType.visiblePassword,
//                       controller: newPasswordController,
//                       isPassword: true,
//                       maxLines: 1,
//                       hint: "New Password",
//                       onValidate: (value) =>Validations.validatePassword(value ?? ''),
//                       hintColor:  AppColors.gray,
//                       prefixIcon: Icon(Icons.lock,color: AppColors.gray,),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed:() {
//                        if(_authenticate()==true){
//                          _updateCredentials();
//                        }
//
//
//                       },
//                       child: const Text("Update"),
//                     ),
//                   ),
//                 ],
//               ),
//         ),
//       ),
//     );
//   }
// }
