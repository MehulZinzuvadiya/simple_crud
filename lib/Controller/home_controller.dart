import 'package:get/get.dart';
import 'package:simple_crud/Utils/db_helper.dart';

class HomeController extends GetxController {
  RxList<Map> dataList = <Map>[].obs;

  Future<void> ReadData() async {
    dataList.value = await DBHelper.dbHelper.ReadData();
  }

  void deleteData({required id}) {
    DBHelper.dbHelper.deleteData(id: id);
  }

  Future<void> updateData({required id, required name, required mobile}) async {
    DBHelper.dbHelper.updateData(id: id, name: name, mobile: mobile);
    ReadData();
  }
}
