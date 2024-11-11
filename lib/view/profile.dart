import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo1/widgents/custom_TextFeild.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _agecontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  String? _profileImageUrl;
  bool _isEditingProfile = false;

  @override
  void initState(){
    super.initState();
    _UserProfileEdView();
  }

  Future<void> _UserProfileEdView()async{
    User? user = _auth.currentUser;
    if(user != null){
      DocumentSnapshot userData = await _firestore.collection("Users").doc(user.uid).get();
      setState(() {
        _namecontroller.text = userData['name'] ?? 'No name found';
        _emailcontroller.text = userData['email'];
        _addresscontroller.text = userData['address'];
        _phonecontroller.text = userData['phone'];
        // _agecontroller.text = userData['age'];
        _profileImageUrl = userData['profileImage'];
      });
    }
  }

  Future<void> _UserProfileUpdate() async{
    User? user = _auth.currentUser;
    if(user != null){
      if(_namecontroller.text.isEmpty || _emailcontroller.text.isEmpty||
      _phonecontroller.text.isEmpty || _addresscontroller.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
      }
      try {
        await _firestore.collection("Users").doc(user.uid).update({
          "name" : _namecontroller.text,
          'email': _emailcontroller.text,
          'address' : _addresscontroller.text,
          'phone' : _phonecontroller.text,
          // 'age' : _agecontroller.text
        });
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
        setState(() {
          _isEditingProfile = false;
        });
      } catch (e) {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update Profile: $e')),
        );
      }
    }
  }

  Future<void> _pickAndUploadImage()async {
    final PickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if(PickedFile != null){
      User? user = _auth.currentUser;
      if(user != null){
        try {
          // upload img to firebase
          final ref = _storage.ref().child('profileImage/${user.uid}.png');
          await ref.putFile(File(PickedFile.path));

          // get the ddounload url
          String downloadUrl = await ref.getDownloadURL();

          // upadate new profile image
          await _firestore.collection("Users").doc(user.uid).update({
            'profileImage': downloadUrl
          });
          setState(() {
            _profileImageUrl = downloadUrl;
          });
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile image updated successfully')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: $e')),
          );
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: 'Profile', size: 20,weight: FontWeight.bold,),centerTitle: true,
          backgroundColor:Color(0xFF009688),
        ),
        backgroundColor: Colors.black,
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                    .center,
                    children: [
                      GestureDetector(
                        onTap: _pickAndUploadImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImageUrl != null 
                          ? NetworkImage(_profileImageUrl!): null, 
                        child: _profileImageUrl == null 
                        ? Icon(Icons.person,size: 50,):null,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomText(text: 'Name', size: 16,color: Colors.grey,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomTextformfield(
                        controller: _namecontroller,
                        hintText: '',
                        readOnly: !_isEditingProfile,
                      ),
                    ),
                CustomText(text: 'Email', size: 16,color: Colors.grey,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextformfield(
                    controller: _emailcontroller,
                    hintText: '',
                    readOnly: !_isEditingProfile,
                  ),
                ),
                CustomText(text: 'Phone Number', size: 16,color: Colors.grey,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextformfield(
                    controller: _phonecontroller,
                    hintText: '',
                    readOnly: !_isEditingProfile,
                  ),
                ),
                CustomText(text: 'Address', size: 16,color: Colors.grey,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomTextformfield(
                    controller: _addresscontroller,
                    maxLines: 5,
                    hintText: '',
                    readOnly: !_isEditingProfile,
                  ),
                ),
                // CustomText(text: 'Age', size: 16,color: Colors.grey,),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.9,
                //   child: CustomTextformfield(
                    
                //     controller: _agecontroller,
                //     hintText: '',
                //     readOnly: !_isEditingProfile,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.87,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF009688),
                          ),
                          onPressed: () {
                            setState(() {
                              if(_isEditingProfile){
                                _UserProfileUpdate();
                              } else{
                                _isEditingProfile = true;
                              }
                              
                            });
                            // Navigator.pop(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(),));
                        }, child: CustomText(text: _isEditingProfile ?'Submit':'Update', size: 24, weight: FontWeight.bold, color: Colors.white)),
                      ),
                ),
                
                
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}