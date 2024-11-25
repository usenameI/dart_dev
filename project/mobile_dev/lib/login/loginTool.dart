import 'package:get/get.dart';
import 'package:pro_mana/apiMana/apiMana.dart';

class loginTool extends GetxController {
  bool loading = false;

  ///登录接口
  Future<bool> login(Map data) async {
    loading = true;
    var res = await apiMana.post(path: '/api/login', data: data);
    loading = false;
    if (res is String) {
      print('log__这是字符串');
    }
    if (res['code'] == 200) {
      apiConfig.token = res['token'];
      return true;
    } else {}
    return false;
  }
}
