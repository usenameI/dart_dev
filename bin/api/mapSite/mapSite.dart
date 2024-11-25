import 'dart:convert';

import 'package:api_mana/mysql/globalMySql.dart';
import 'package:api_mana/response/basicRes.dart';

class mapSite {
  ///获取所有的数据点
  static Future<basicres> getAllSite() async {
    var results = await mysqlMethod.queryMysql(key: [
      'id',
      'name',
      'uniId',
      'content',
      'latitude',
      'longitude',
      'time',
      'images'
    ], tableName: 'mapsite');
    List data = results!.map((row) => row.fields).toList();
    for (var e in data) {
      e['images'] = jsonDecode(e['images']);
    }
    return basicres(code: 200, record: data, msg: '查询成功');
  }
}
