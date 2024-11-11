import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color color;
  final double? letterSpacing;
  final TextAlign? textAlign;
   final bool softWrap;
   final TextOverflow? overflow;
   final   int? maxLines;

   CustomText({
    required this.text,
     this.size,
    this.weight,
    this.color=  Colors.white,
    this.letterSpacing,
     this.textAlign,
     this.softWrap=true,
    
    super.key, this.overflow, this.maxLines
   });

  @override
  Widget build(BuildContext context) {
    return Text(
      
      text,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines:maxLines,

      style:
      
      
       GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          letterSpacing: letterSpacing,
          
          
        )
      ),
      
    );
  }
}