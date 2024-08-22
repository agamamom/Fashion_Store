import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multi_fashion_store/views/buyers/auth/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyD_GR-k20S3AuX6MN0ODAo1JR8lD61Lu7o',
              appId: '1:742721761456:android:dad5c2b23a20aa4da6cb75',
              messagingSenderId: '742721761456',
              projectId: 'fashion-store-bffd4',
              storageBucket: 'gs://fashion-store-bffd4.appspot.com'),
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
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      home: const BuyerRegisterScreen(),
    );
  }
}
