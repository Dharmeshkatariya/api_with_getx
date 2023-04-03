import 'package:api_with_getx/route/nameroute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: TextButton(
            onPressed: () {
              Get.toNamed(NameRoutes.homepage);
            },
            child: const Text("New screen"),
          ),
        ),
      ),
    );
  }
}
