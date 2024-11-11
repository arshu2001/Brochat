import 'package:demo1/controller/auth_gate.dart';
import 'package:demo1/firebase_options.dart';
import 'package:demo1/provider/themeprovider.dart';
import 'package:demo1/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  final themeProvider = ThemeProvider();
  await themeProvider.loadThemeMode();
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(), child:  const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) =>
       MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.montserratTextTheme()
          ),
          home: const AuthGate()
        ),
      
    );
  }
}

