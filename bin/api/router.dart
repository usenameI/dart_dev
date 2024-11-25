import 'package:shelf_router/shelf_router.dart';
import 'model/dayRecord/dayRecordApp.dart';
import '../api/loginModel/loginApp.dart';
import 'flie/flieApp.dart';
import '../api/mapSite/mapSiteApp.dart';

class router {
  static Router app() {
    var app = Router();

    Loginapp.addApp(app);

    ///笔记模块的接口接入
    dayrecordapp.addApp(app);

    ///文件上传
    fileApp.addApp(app);

    ///地图模块
    mapSiteApp.addApp(app);
    return app;
  }
}
