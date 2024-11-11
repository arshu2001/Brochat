import 'package:demo1/controller/login_controller.dart';
import 'package:demo1/view/login.dart';
import 'package:demo1/view/profile.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:flutter/material.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  void logout(){
    final _user_loginController = User_LoginController();
    _user_loginController.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          DrawerHeader(child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Icon(Icons.message,
                  size: 40,
                  color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomText(text: 'B r o C h a t',size: 20,weight: FontWeight.w600,),
                  )
                ],
              ),
            ),

          )),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: CustomText(text: 'P r o f i l e',size: 18,weight: FontWeight.w700,),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: CustomText(text: 'L o g o u t',size: 18,weight: FontWeight.w700,),
              leading: Icon(Icons.logout),
              onTap: () {
                showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: CustomText(text: 'LogOut', size: 20,weight: FontWeight.w600,color: Colors.black,),
                          content: CustomText(text: 'Are you sure your you want to logout?', size: 16, weight: FontWeight.normal, color: Colors.black),
                actions: [
                  TextButton(onPressed: () {
                    logout();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),),(route) => false,);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                    
                  }, child: CustomText(text: 'yes', size: 16, weight: FontWeight.w400, color: Colors.black)),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: CustomText(text: 'no', size: 16, weight: FontWeight.w400, color: Colors.black))
                ]
                        );
                      },);
              },
            ),
          ),
        ],
      ),
    );
  }
}