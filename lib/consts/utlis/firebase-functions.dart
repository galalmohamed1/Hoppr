import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/main.dart';

class FirebaseFunctions{
  static Future<bool>createAccounts({
    required String Name,
    required String email,
    required String password,
    required String role,

  })async {
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(credential.user!=null){
        credential.user!.updateDisplayName(Name);
      }
      final store=FirebaseFirestore.instance.collection("user").doc(credential.user!.uid).set({
        "Name":Name.trim(),
        "Email":email.trim(),
        "Role":role.trim(),
      });
      SnackBarService.showSuccessMessage("Account created successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The password provided is too weak.');
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        SnackBarService.showErrorMessage(
            e.message ?? 'The email provided is too weak.');
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      return Future.value(false);
    }


  }
  static Future<dynamic> login({
    required String emailAddress,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      var kk = FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('Role') == "Admin") {
            navigatorKey.currentState!.pushNamedAndRemoveUntil(PagesRouteName.AdminHome, (route) => false,);
          }else{
            navigatorKey.currentState!.pushNamedAndRemoveUntil(PagesRouteName.HomePage, (route) => false,);
          }
        } else {
          print('Document does not exist on the database');
        }
      });
      SnackBarService.showSuccessMessage("Logged In successfully");
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The user provided is too weak.');
        return Future.value(false);
      } else if (e.code == 'wrong-password') {
        // print('The account already exists for that email.');
        SnackBarService.showErrorMessage(
            e.message ?? 'The password provided is too weak.');
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  //  static Future<UserCredential> loginWithGoogle() async {
  //   EasyLoading.show();
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   // Once signed in, return the UserCredential
  //   var usercredential=await FirebaseAuth.instance.signInWithCredential(credential);
  //   log(usercredential.user!.uid.toString());
  //   return usercredential;
  // }

}