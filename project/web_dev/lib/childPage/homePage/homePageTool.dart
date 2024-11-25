import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';

///页面状态管理
class homePageTool extends ChangeNotifier {
  List flie = [];
  homePageTool() {
    getAllFile();
  }

  // 初始获取
  getAllFile() {
    apiMana.get(path: '/api/getAll').then((value) {
      if (value['code'] == 200) {
        flie = value['record'];
        notifyListeners();
      }
    });
  }
}

// homepage页面弹窗状态控制
class homePagePop extends ChangeNotifier {
  List flie = [];
  homePagePop() {
    getAllFile();
  }

  // 初始获取
  getAllFile() {
    apiMana.get(path: '/api/getAll').then((value) {
      if (value['code'] == 200) {
        flie = value['record'];
        notifyListeners();
      }
    });
  }

  ///上传文件
  upload(fileBytes, fileName) {
    apiMana
        .uploadFile(
            fileBytes: fileBytes, fileName: fileName, path: '/api/upload')
        .then((res) {
      if (res['code'] == 200) {
        getAllFile();
      }
    });
  }

  ///删除文件
  deleteFlie(String uniId) {
    apiMana.delete(path: '/api/image/$uniId').then((res) {
      if (res['code'] == 200) {
        getAllFile();
      }
    });
  }
}
