import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';

import 'package:web_dev/componet/toast/toast.dart';

///登录页面的状态控制
class Counter with ChangeNotifier {
  bool loading = false;
  // int get count => _count;
  ///登录接口
  login(context, Map data, Function success) {
    apiMana.post(path: '/api/login', data: data).then((res) async {
      increment();
      if (res is String) {
        print('log__这是字符串');
      }
      if (res['code'] == 200) {
        print('log__$res');
        apiConfig.token = res['token'];
        success();
        toast.show(context, content: '登录成功', type: InfoBarSeverity.success);
      } else {
        toast.show(context, content: '登录失败', type: InfoBarSeverity.error);
      }
    });
  }

  void increment() {
    loading = !loading;
    notifyListeners(); // 通知所有监听者更新状态
  }
}
