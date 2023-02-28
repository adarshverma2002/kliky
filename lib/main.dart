import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kliky/cameraPage.dart';
import 'package:kliky/home.dart';
import 'package:kliky/otpScreen.dart';
import 'package:kliky/phoneNumber.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone': (context) => phoneNumber(),
      'otp': (context) => MyOtp(),
      'home': (context) => MyHome(),
      'camera': (context) => cameraScreen(),
    },
  ));
}
