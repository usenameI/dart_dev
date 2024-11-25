import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';

class recordItemTool {
  recordItemTool({required this.parentId});

  ///列表状态管理
  list? l;

  ///编辑面板管理
  edit? e;

  List record = [];
  var parentId;

  ///改变展示的数据
  changeCurrentData(item) {
    e?.currentData = Map.from(item);
    e?.name.text = item['name'];
    e?.content.text = item['word'];
    e?.notifyListeners();
  }
}

class list extends ChangeNotifier {
  List record = [];
  var parentId;

  String currentIndex = 's';
  list({required this.parentId}) {
    getRecord();
  }

  ///获取数据
  getRecord() {
    record = [];
    apiMana.get(
        path: '/api/recordItem',
        queryParameters: {'parentId': parentId}).then((res) {
      if (res['code'] == 200) {
        record.addAll(res['record']);
        notifyListeners();
      }
    });
  }
}

class edit extends ChangeNotifier {
  var parentId;
  edit({required this.parentId});
  TextEditingController name = TextEditingController(text: '');
  TextEditingController content = TextEditingController(text: '');
  Map currentData = {};

  ///删除一条数据
  Future deleteData() async {
    var res =
        await apiMana.delete(path: '/api/recordItem/${currentData['uniId']}');
    if (res['code'] == 200) {}
    return res;
  }

  ///修改一条数据
  Future updata() async {
    var res =
        await apiMana.post(path: '/api/recordItem/updata', data: currentData);
    if (res['code'] == 200) {}
    return res;
  }

  ///新增一条文字记录
  Future addWord() async {
    var res = await apiMana.post(
        path: '/api/recordItem/add',
        data: {"name": "", "type": "文字", "parentId": parentId});
    return res;
  }
}
