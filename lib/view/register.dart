import 'package:demo1/controller/register_controller.dart';
import 'package:demo1/modal/register_modal.dart';
import 'package:demo1/view/login.dart';
import 'package:demo1/widgents/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _phonecontroller = TextEditingController();

  final User_RegisterController _userController = User_RegisterController();

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: CustomText(
                      text: 'Sign Up',
                      size: 36,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CustomText(
                    text: 'Create your account',
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                 
                    width: 320,
                    child: TextFormField(
                      controller: _namecontroller,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                          label: CustomText(text: 'Name', size: 13),
                          border: OutlineInputBorder(
                          
                              borderRadius: BorderRadius.circular(10))),
                              
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    
                    width: 320,
                    child: TextFormField(
                      controller: _emailcontroller,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                          label: CustomText(text: 'Email', size: 13),
                          border: OutlineInputBorder(
                          
                              borderRadius: BorderRadius.circular(10))),
                              
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    
                    width: 320,
                    child: TextFormField(
                      controller: _passwordcontroller,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)) ,
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 0.2,color: Colors.red)),
                          label: CustomText(text: 'Password', size: 13),
                          border: OutlineInputBorder(
                          
                              borderRadius: BorderRadius.circular(10))),
                              
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    
                    width: 320,
                    child: TextFormField(
                      controller: _addresscontroller,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)) ,
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 0.2,color: Colors.red)),
                          label: CustomText(text: 'Address', size: 13),
                          border: OutlineInputBorder(
                          
                              borderRadius: BorderRadius.circular(10))),
                              
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    
                    width: 320,
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller: _phonecontroller,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)) ,
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(width: 0.2,color: Colors.red)),
                          label: CustomText(text: 'Phone no', size: 13),
                          border: OutlineInputBorder(
                          
                              borderRadius: BorderRadius.circular(10))),
                              
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 50,
                      width: 320,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white60, width: 0.5)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                        value: selectedValue,
                        hint: CustomText(text: 'Select gender', size: 13),
                        isExpanded: true,
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CustomText(text: value, size: 13),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        dropdownStyleData: DropdownStyleData(
                            offset: Offset(0, -10),
                            decoration: BoxDecoration(
                              color:Color(0xff313131),
                                borderRadius: BorderRadius.circular(10))),
                      )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top:40),
                  child: SizedBox(
                        width: 320,
                        child: ElevatedButton(onPressed: () {
                          if(_formkey.currentState!.validate()){
                            user_Register_Model userreg=user_Register_Model(
                              name: _namecontroller.text,
                              email: _emailcontroller.text,
                              gender: selectedValue,
                              password: _passwordcontroller.text,
                              address: _addresscontroller.text,
                              phone: _phonecontroller.text
                            );
                            _userController.registerUser(userreg, context);
                            _namecontroller.clear();
                            _passwordcontroller.clear();
                            _emailcontroller.clear();
                            _addresscontroller.clear();
                            _phonecontroller.clear();
                            selectedValue = null;
                          }
                        },
                        style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                         child:
                         CustomText(text: 'Submit', size: 16)
                         ),
                      ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text.rich(TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                          style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white))
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                          ..onTap=(){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
                          },
                          
                          text: "Login",
                          style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xff2420F1)))
                        )
                      ]
                    )),
                  ),
                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}