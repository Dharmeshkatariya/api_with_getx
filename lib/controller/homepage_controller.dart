import 'dart:convert';
import 'package:api_with_getx/modal/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  List<Entries> userList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    userDataApi();
    super.onInit();
  }

  userDataApi() async {
    try {
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
      }
    } catch (e) {
      print(e);
    }
  }
}
