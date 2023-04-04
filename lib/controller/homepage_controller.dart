import 'dart:convert';
import 'package:api_with_getx/modal/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController
    with StateMixin<List<CategoryData>> {
  RxBool hSelect = false.obs;
  RxBool cSelected = false.obs;
  List<CategoryData> finalList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    userDataApi();
    super.onInit();
  }

  userDataApi() async {
    try {
      change(finalList, status: RxStatus.loading());
      var client = http.Client();
      var url = "https://api.publicapis.org/entries";
      var uri = Uri.parse(url);
      var response = await client.get(uri);
      Map<String, dynamic> uMap = jsonDecode(response.body);
      List<Entries> userList = [];
      if (response.statusCode == 200) {
        List<dynamic> uList = uMap["entries"];
        for (int i = 0; i < uList.length; i++) {
          Map<String, dynamic> userMsp = uList[i];
          Entries entries = Entries.fromJson(userMsp);
          userList.add(entries);
        }
        _filterData2(userList);
        change(finalList,
            status:
                userList.isNotEmpty ? RxStatus.success() : RxStatus.empty());
      }
    } catch (e) {
      print(e);
      change(finalList, status: RxStatus.error('Something went wrong!'));
    }
  }

  _filterData2(List<Entries> userList) {
    String title = '';
    List<Entries> mList = [];
    for (int i = 0; i < userList.length; i++) {
      Entries entries = userList[i];
      if (entries.Category == title) {
        mList.add(entries);
      } else {
        if (mList.isNotEmpty) {
          List<Entries> list = [];
          list.addAll(mList);
          CategoryData categoryData = CategoryData();
          categoryData.title = title;
          categoryData.mList = list;
          finalList.add(categoryData);
        }
        mList.clear();
        title = entries.Category;
        mList.add(entries);
      }
    }
    List<Entries> list = [];
    list.addAll(mList);
    CategoryData categoryData = CategoryData();
    categoryData.title = title;
    categoryData.mList = list;
    finalList.add(categoryData);
    change(finalList, status: RxStatus.success());
  }

  bool checkItem(String cors) {
    return cSelected.value = cors == "yes";
  }

  httpSelected(bool select) {
    hSelect.value = select;
  }

  onChange(int index) {
    for (int i = 0; i < finalList.length; i++) {
      if (i == index) {
        finalList[index].isExpand = !finalList[index].isExpand;
      }
    }
    update();
  }
}

class CategoryData {
  late String title;
  bool isExpand = false;
  late List<Entries> mList;
}
