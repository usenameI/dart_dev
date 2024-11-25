import 'dart:convert';
import 'package:api_mana/mysql/globalMySql.dart';
import 'package:api_mana/response/basicRes.dart';

class login {
  static Future<loginRes> checkCode(String body) async {
    var map = jsonDecode(body);
    var results = await conn?.query(
        'SELECT userId FROM users WHERE username=? AND password=?',
        [map['username'], map['password']]);
    var data = results?.map((row) => row.fields).toList();
    if (data!.isNotEmpty) {
      return loginRes(token: '${data[0]['userId']}', code: 200);
    }
    return loginRes(token: null, code: 401);
  }

  static Future<basicres> register(String body) async {
    Map map = jsonDecode(body);

    if (map['username'] == null && map['username'] == '') {
      return basicres(code: 401, msg: '请输入用户名');
    }
    if (map['password'] == null && map['password'] == '') {
      return basicres(code: 401, msg: '请输入密码');
    }

    ///查询账号是否存在？
    var res = await mysqlMethod.queryMysql(
        key: ['username'],
        tableName: 'users',
        condition: ['username=?'],
        conditionValues: [map['username']]);
    if (res!.isNotEmpty) {
      return basicres(code: 401, msg: '账号存在');
    }

    ///创建账号
    var results = await mysqlMethod.insertMysql(
        key: ['username', 'password'],
        params: [map['username'], map['password']],
        tableName: 'users',
        uniId: 'userId');
    if (results!.affectedRows! < 1) {
      basicres(code: 200, msg: '注册失败');
    }
    return basicres(code: 200, msg: '注册成功');
  }
}
