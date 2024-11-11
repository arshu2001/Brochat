import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/modal/register_modal.dart';
import 'package:demo1/view/login.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User_RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(user_Register_Model userrg, BuildContext context) async{
    try {
      // firebase authentication
        
      UserCredential userCredential = await  _auth.createUserWithEmailAndPassword(
        email: userrg.email!, password: userrg.password!);

        await _firestore.collection("Users").doc(userCredential.user!.uid).set({
          "name" : userrg.name,
          "password" : userrg.password,
          "email" : userrg.email,
          "address" : userrg.address,
          "phone" : userrg.phone,
          "gender": userrg.gender,
          "uid" : userCredential.user!.uid
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: CustomText(text: "Registration success", size: 18))
        );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText(text: "Error : ${e.toString()}", size: 18))
        );
        return;
    }
  }
}