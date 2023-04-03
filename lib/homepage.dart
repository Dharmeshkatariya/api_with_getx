import 'dart:math';

import 'package:api_with_getx/controller/homepage_controller.dart';
import 'package:api_with_getx/modal/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = Get.put(HomePageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isChecked = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Entries entries = Entries();
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListView.builder(
              itemCount: _homeController.userList.length,
              itemBuilder: (BuildContext context, int index) {
                return _listItem(index);
              }),
        ),
      ),
    );
  }

  Widget _listItem(int index) {
    Entries entries = _homeController.userList[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: Column(
        children: [
          Text("Category : ${entries.Category}"),
          Text("APi : ${entries.API}"),
          Text(
            "Description : ${entries.Description}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            softWrap: false,
          ),
          Row(
            children: [
              Text("HTTPS : ${entries.HTTPS}"),
              Checkbox(
                checkColor: Colors.white,
                value: _httpSelect(entries.HTTPS!),
                onChanged: (bool? value) {
                  setState(() {
                    _httpsChecked(index, value!);
                  });
                },
              ),
              Text("Cors : ${entries.Cors}"),
              Checkbox(
                checkColor: Colors.white,
                value: _check(entries.Cors!),
                onChanged: (bool? value) {
                  setState(() {
                    _checked(index, value!);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _checked(int index, bool selected) {
    _homeController.userList[index].Cors = selected ? "yes" : "no";
    setState(() {});
  }

  bool _check(String cors) {
    if (cors == "yes") {
      return true;
    } else {
      return false;
    }
  }

  _httpSelect(bool select) {
    if (select == true) {
      return true;
    } else {
      return false;
    }
  }

  _httpsChecked(int index, bool select) {
    _homeController.userList[index].HTTPS = select ? true : false;
    setState(() {});
  }
}
