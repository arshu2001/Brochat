import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/modal/login_modal.dart';
import 'package:demo1/view/home.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class User_LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser (){
    return _auth.currentUser;
  }
  Future<void> loginUser(
    User_Login_Model loginmodel, BuildContext context)async{
      try {
        //First, check if the email exists in the ChefAuth collection
        QuerySnapshot userSnapshot = await _firestore
        .collection('Users').where('email', isEqualTo: loginmodel.email)
        .get();

        if(userSnapshot.docs.isEmpty){
          throw FirebaseAuthException(code: 'user-not-found',
          message: 'No user found with this email.');
        }
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: loginmodel.email!, password: loginmodel.password!);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(text: "Login success", size: 18)));
          // _firestore.collection('Users').doc(userCredential.user!.uid).set(
          //   {
          //     'uid': userCredential.user!.uid,
          //     'email': loginmodel.email,
          //   }
          // );
      return;
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: CustomText(text: "Error : ${e.toString()}", size: 18))
        );
      }
    }
    Future<void> signOut() async{
      return await _auth.signOut();
    }
}