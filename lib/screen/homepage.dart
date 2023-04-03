import 'package:api_with_getx/controller/homepage_controller.dart';
import 'package:api_with_getx/modal/user.dart';
import 'package:api_with_getx/screen/empthview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => SafeArea(
          child: ListView.builder(
              itemCount: controller.finalList.length,
              itemBuilder: (BuildContext context, int index) {
                return _demoItem(index);
              }),
        ),
        onEmpty: const EmptyView(message: 'Data not available!'),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => EmptyView(message: error.toString() ?? ''),
      ),
    );
  }

  Widget _demoItem(int index) {
    DemoData data = controller.finalList[index];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Text(data.title),
              IconButton(
                  onPressed: () {
                    data.isExpand.value != data.isExpand.value;
                  },
                  icon: const Icon(Icons.keyboard_arrow_down))
            ],
          ),
          data.isExpand.value
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.mList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _item2(index, data.mList);
                  })
              : Container(),
        ],
      ),
    );
  }

  Widget _item2(int index, List<String> mList) {
    String str = mList[index];
    return Container(
      child: Column(
        children: [
          Text(str),
        ],
      ),
    );
  }

  Widget _listItem(int index) {
    Entries entries = controller.userList[index];
    return ListView.builder(
        itemCount: controller.userList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                title: Text("category : ${entries.Category}"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
              _listviewItem(index),
            ],
          );
        });
  }

  Widget _listviewItem(int index) {
    Entries entries = controller.userList[index];
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: Row(
                children: [
                  Text("HTTPS : ${entries.HTTPS}"),
                  Checkbox(
                    checkColor: Colors.white,
                    value: entries.HTTPS!,
                    onChanged: (bool? value) {
                      controller.httpsChecked(index, value!);
                    },
                  ),
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  Text("Cors : ${entries.Cors}"),
                  Checkbox(
                    checkColor: Colors.white,
                    value: entries.Cors! == "yes",
                    onChanged: (bool? value) {
                      // controller.checked(index, value!);
                    },
                  ),
                ],
              )),
            ],
          ),
          Text(
            "Description : ${entries.Description}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
