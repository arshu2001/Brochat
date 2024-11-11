import 'package:demo1/view/profile.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  
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

              },
            ),
          ),
        ],
      ),
    );
  }
}