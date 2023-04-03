import 'dart:convert';
import 'package:api_with_getx/modal/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController with StateMixin<List<Entries>> {
  List<Entries> userList = [];
  RxBool hSelect = false.obs;
  RxBool cSelected = false.obs;

  List<DemoData> finalList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    // _addValue();
    _filterData();
    userDataApi();
    super.onInit();
  }

  var array = [
    'abcd',
    'bcda',
    'cdae',
    'dergf',
    'abcd',
    'cdae',
    'dergf',
    'bcda',
    'abcd',
    'cdae',
    'abcd',
  ];

  userDataApi() async {
    try {
      change(userList, status: RxStatus.loading());
      var client = http.Client();
      var url = "https://api.publicapis.org/entries";
      var uri = Uri.parse(url);
      var response = await client.get(uri);
      Map<String, dynamic> uMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<dynamic> uList = uMap["entries"];
        for (int i = 0; i < uList.length; i++) {
          Map<String, dynamic> userMsp = uList[i];
          Entries entries = Entries.fromJson(userMsp);
          userList.add(entries);
        }
        change(userList, status:
        userList.isNotEmpty ? RxStatus.success() : RxStatus.empty());
      }
    } catch (e) {
      print(e);
      change(userList, status: RxStatus.error('Something went wrong!'));
    }
  }

  _filterUserData() {
    change(userList, status: RxStatus.loading());
    Entries entries = Entries();
    String tittle = entries.Category;
    List<String> mList = [];
    var array = [];
    for (int i = 0; i < userList.length; i++) {
      array.add(entries.Category);
    }
    array.sort((a, b) => a.compareTo(b));
    for (int i = 0; i < array.length; i++) {
      String str = array[i];
      if (tittle == str) {
        mList.add(str);
      } else {
        if (mList.isNotEmpty) {
          List<String> list = [];
          list.addAll(mList);
          DemoData demoData = DemoData();
          demoData.title = tittle;
          demoData.mList = list;
          finalList.add(demoData);
        }
        mList.clear();
        tittle = str;
        mList.add(str);
      }
    }
    List<String> list = [];
    list.addAll(mList);
    DemoData demoData = DemoData();
    demoData.title = tittle;
    demoData.mList = list;
    finalList.add(demoData);
    print(finalList);
    change(userList, status: RxStatus.success());
  }

  _filterData() {
    change(userList, status: RxStatus.loading());
    array.sort((a, b) => a.compareTo(b));
    String title = '';
    List<String> mList = [];
    for (int i = 0; i < array.length; i++) {
      String str = array[i];
      if (title == str) {
        mList.add(str);
      } else {
        if (mList.isNotEmpty) {
          List<String> list = [];
          list.addAll(mList);
          DemoData demoData = DemoData();
          demoData.title = title;
          demoData.mList = list;
          demoData.isExpand.value = true;
          finalList.add(demoData);
        }
        mList.clear();
        title = str;
        mList.add(str);
      }
    }
    List<String> list = [];
    list.addAll(mList);
    DemoData demoData = DemoData();
    demoData.title = title;
    demoData.mList = list;
    finalList.add(demoData);

    print(finalList);
    change(userList, status: RxStatus.success());
  }

  _addValue() {
    change(userList, status: RxStatus.loading());
    List<String> mList = [];
    for (int i = 0; i < userList.length; i++) {
      // mList.add(userList[i].Category);
      DemoData data = DemoData();
      // data.title = userList[i].Category;
      data.mList = mList;
    }
    DemoData data = DemoData();

    finalList.add(data);

    change(userList, status: RxStatus.success());
  }

  checked(int index, bool selected) {
    userList[index].Cors = selected ? "yes" : "no";
  }

  bool checkItem(String cors) {
    return cSelected.value = cors == "yes";
  }

  httpSelected(bool select) {
    hSelect.value = select;
    print(hSelect.value);
  }

  httpsChecked(int index, bool select) {
    userList[index].HTTPS = select;
    print(hSelect.value);
  }
}

class DemoData {
  late String title;
  RxBool isExpand = false.obs;
  late List<String> mList;
}
