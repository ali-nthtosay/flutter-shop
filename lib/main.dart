import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/auth_screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: 'AIzaSyA5CXKLCRBTAXOPnj9nLup3IskdE2xDjfE',
          appId: '1:808811142967:android:48285ef06529464e1704b2',
          messagingSenderId: '808811142967',
          projectId: 'some-app-97222',
          storageBucket: 'some-app-97222.firebasestorage.app',
        ),
      )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: RegisterScreen(),
    );
  }
}
