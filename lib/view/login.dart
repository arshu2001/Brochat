import 'package:demo1/controller/login_controller.dart';
import 'package:demo1/modal/login_modal.dart';
import 'package:demo1/view/forgot.dart';
import 'package:demo1/view/register.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final User_LoginController _user_loginController = User_LoginController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160.h,
                  ),
                  CustomText(
                    text: 'Login',
                    size: 36.sp,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  CustomText(
                    text: 'Signin to your Account',
                    size: 20.sp,
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  SizedBox(
                  
                    width: 320.w,
                    child: TextFormField(
                      controller: emailcontroller,
                       validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Please enter a valid email";
                        } else {
                          return null;
                        }
                      },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                          label: CustomText(text: 'Email', size: 13.dg),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: SizedBox(
                    
                      width: 320.w,
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordcontroler,
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Password";
                          }
                          // if (!RegExp((r'[A-Z]')).hasMatch(value)) {
                          //   return 'Uppercase letter is missing';
                          // }
                          // if (!RegExp((r'[a-z]')).hasMatch(value)) {
                          //   return 'Lowercase letter is missing';
                          // }
                          if (!RegExp((r'[0-9]')).hasMatch(value)) {
                            return 'Digit is missing';
                          }
                          if (value.length < 8) {
                            return "Password must have at least 8 characters";
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                             errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                            label: CustomText(text: 'Password', size: 13.sp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r))),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10.h, right: 50.w),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserForgetPassword(),
                                    ));
                              },
                              child: CustomText(
                                text: 'Forget Password?',
                                size: 12.sp,
                                color: Color(0xff2420F1),
                              ))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: SizedBox(
                      width: 320.w,
                      child: ElevatedButton(
                          onPressed: () {
                            if(_formkey.currentState!.validate()){
                          User_Login_Model userlogin=User_Login_Model(
                            email: emailcontroller.text,
                            password: passwordcontroler.text,
                          );
                          _user_loginController.loginUser(userlogin, context);
                            emailcontroller.clear();
                            passwordcontroler.clear();
                          
                        }
                          },
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r))),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.teal)),
                          child: CustomText(text: 'Login', size: 16.sp)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account?",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white))),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ));
                            },
                          text: "Signup",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Color(0xff2420F1))))
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}