import 'package:api_with_getx/route/pageroute.dart';
import 'package:api_with_getx/screen/webscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: PageRoutes.pages,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebScreen(),
    );
  }
}
