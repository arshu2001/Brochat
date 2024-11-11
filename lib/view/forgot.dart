import 'package:demo1/controller/forgot_controller.dart';
import 'package:demo1/modal/forgot_modal.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserForgetPassword extends StatefulWidget {
  const UserForgetPassword({super.key});

  @override
  State<UserForgetPassword> createState() => _UserForgetPasswordState();
}

class _UserForgetPasswordState extends State<UserForgetPassword> {
  final _emailcontroller = TextEditingController();
  final user_forgot_controller  _userforgetcontroller = user_forgot_controller();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: _formkey,
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                ),
                child: Center(
                    child: CustomText(
                  text: 'Forget Password',
                  size: 24,
                  color: Colors.white,
                  weight: FontWeight.bold,
                )),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100, left: 50),
                    child: CustomText(text: 'Enter your email', size: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 50),
                    child: SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 70,left: 10),
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          if(_formkey.currentState!.validate()){
                                            User_Forgot_Model userforgot = User_Forgot_Model(
                                              email: _emailcontroller.text
                                            );
                                            _userforgetcontroller.userpassrest(userforgot, context);
                                          }
                        }
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                      child: CustomText(text: 'Confirm', size: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}