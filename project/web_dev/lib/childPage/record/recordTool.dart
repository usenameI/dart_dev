import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';

class recordTool {
  recordGrid? reG;

  ///新增一个笔记
  static Future addG(Map data) async {
    var res = await apiMana.post(path: '/api/recordGrid/add', data: data);
    return res;
  }

  ///修改权限
  revisePermission(permission, uniId) async {
    var res = await apiMana.post(
        path: '/api/recordGrid/permission',
        data: {'permission': permission, 'uniId': uniId});
    if (res['code'] == 200) {
      reG?.getlist();
    }
  }

  ///修改锁定
  reviseLocked(locked, uniId) async {
    var res = await apiMana.post(
        path: '/api/recordGrid/locked',
        data: {'locked': locked, 'uniId': uniId});
    if (res['code'] == 200) {
      reG?.getlist();
    }
  }
}

class recordGrid extends ChangeNotifier {
  recordGrid() {
    getlist();
  }
  List list = [];

  ///获取笔记封面的数据
  getlist() {
    list = [];
    apiMana.get(path: '/api/recordGrid').then((res) {
      if (res['code'] == 200) {
        list.addAll(res['record']);
        notifyListeners();
      }
    });
  }
}
