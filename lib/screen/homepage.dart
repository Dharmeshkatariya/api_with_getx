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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red.shade200,
        title: const Text("Product Data"),
      ),
      body: controller.obx(
        (state) => SafeArea(
          child: ListView.builder(
              itemCount: controller.finalList.length,
              itemBuilder: (BuildContext context, int index) {
                return _listItem(index);
              }),
        ),
        onEmpty: const EmptyView(message: 'Data not available!'),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => EmptyView(message: error.toString()),
      ),
    );
  }

  Widget _listItem(int index) {
    CategoryData categoryData = controller.finalList[index];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          ListTile(
            title: Text("category : ${categoryData.title}"),
            trailing: IconButton(
                onPressed: () {
                  controller.onChange(index);
                },
                icon: categoryData.isExpand
                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                    : const Icon(Icons.keyboard_arrow_down)),
          ),
          Divider(
            height: categoryData.isExpand ? 50 : 0,
          ),
          categoryData.isExpand
              ? ListView.builder(
                  itemCount: categoryData.mList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return _listviewItem(index, categoryData);
                  })
              : Container()
        ],
      ),
    );
  }

  Widget _listviewItem(int index, CategoryData categoryData) {
    Entries entries = categoryData.mList[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      // controller.httpsChecked(index, value!);
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
