import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardtype;
  final  TextStyle? style;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final double? height;
  final double? width;
  final  int? maxLines;
  final bool obscureText;
  final bool readOnly;
  final InputBorder? border;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  const CustomTextformfield({
    super.key,  
    this.controller,    
    this.keyboardtype,  
    this.style, 
    this.hintText, 
    this.suffixIcon, 
    this.hintStyle, 
    this.height, 
    this.width, 
    this.maxLines,
    this.border,
    this.fillColor,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.validator
    
 });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
      width: width,
      child: TextFormField(
      keyboardType: keyboardType,
      validator: validator,
      readOnly : readOnly,
      obscureText: obscureText,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)
      ),
      style: style,
      ),
    );
  }
}