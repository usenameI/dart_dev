import 'dart:convert';
import 'package:api_mana/mysql/globalMySql.dart';
import 'package:api_mana/response/basicRes.dart';

class dayRecord {
  ///获取笔记的封面列表
  static Future<basicres> getList(String token, Map parms) async {
    var results = await mysqlMethod.queryMysql(
        key: [
          'id',
          'name',
          'description',
          'createTime',
          'uniId',
          'locked',
          'permission'
        ],
        tableName: 'recordgrid',
        condition: ['userId=?'],
        conditionValues: [token]);
    var data = results?.map((row) => row.fields).toList();
    for (var e in data!) {
      e['createTime'] =
          (e['createTime'] as DateTime).toString().substring(0, 19);
      e['description'] = e['description'].toString();

      ///判断bool
      e['permission'] = e['permission'] == 1;
      e['locked'] = e['locked'] == 1;
    }
    return basicres(msg: '查询成功', record: data, code: 200);
  }

  ///新增笔记封面
  static Future<basicres> addList(String token, String body) async {
    var map = jsonDecode(body);
    var result = await mysqlMethod.insertMysql(
        key: ['name', 'description', 'userId'],
        params: [map['name'], map['description'], token],
        tableName: 'recordgrid');
    return basicres(msg: '新增成功', code: 200);
  }

  ///修改笔记封面
  static Future<basicres> updateList(String token, String body) async {
    Map map = jsonDecode(body);
    if (map['name'] == null) {
      return basicres(msg: 'name不能为空', code: 401);
    }
    if (map['description'] == null) {
      return basicres(msg: 'description不能为空', code: 401);
    }
    if (map['uniId'] == null) {
      return basicres(msg: 'uniId不能为空', code: 401);
    }
    //查询封面列表是否存在这个parentId
    var result = await mysqlMethod.queryMysql(
        key: ['uniId'],
        tableName: 'recordgrid',
        condition: ['uniId=?'],
        conditionValues: [map['uniId']]);
    if (result!.isEmpty) {
      return basicres(msg: '该uniId无效', code: 401);
    }

    var results = await mysqlMethod.updataMysql(
        tableName: 'recordgrid',
        keyNames: ['name', 'description'],
        values: [map['name'], map['description']],
        condition: 'uniId=?',
        conditionValues: [map['uniId']]);
    return basicres(msg: '修改成功', code: 200);
  }

  ///删除笔记封面
  static Future<basicres> deleteList(String token, String uniId) async {
    var results = await mysqlMethod.deleteMysql(
        keyName: 'uniId', tableName: 'recordgrid', values: [uniId]);
    if (results!.affectedRows! < 1) {
      return basicres(code: 401, msg: '删除失败');
    }
    return basicres(code: 200, msg: '删除成功');
  }

  ///获取笔记数据列表
  static Future<basicres> getDataList(String token, Map parms) async {
    if (parms['parentId'] == null) {
      return basicres(msg: '缺少parentId', code: 401);
    }
    var results = await mysqlMethod.queryMysql(
        key: ['id', 'name', 'type', 'uniId', 'parentId', 'word', 'createTime'],
        tableName: 'recordItem',
        condition: ['parentId=?'],
        conditionValues: [parms['parentId']],
        desc: true);
    var data = results?.map((row) => row.fields).toList();
    for (var e in data!) {
      e['createTime'] =
          (e['createTime'] as DateTime).toString().substring(0, 19);
      e['word'] = e['word'].toString();
    }
    return basicres(msg: '查询成功', record: data, code: 200);
  }

  ///新增笔记数据列表
  static Future<basicres> addDataList(String token, String body) async {
    var map = jsonDecode(body);
    if (map['name'] == null) {
      return basicres(msg: 'name不能为null', code: 401);
    }
    if (map['type'] == null) {
      return basicres(msg: 'type不能为null', code: 401);
    }
    if (map['parentId'] == null) {
      return basicres(msg: 'parentId不能为null', code: 401);
    }
    //查询封面列表是否存在这个parentId
    var result = await mysqlMethod.queryMysql(
        key: ['uniId'],
        tableName: 'recordgrid',
        condition: ['uniId=?'],
        conditionValues: [map['parentId']]);
    if (result!.isEmpty) {
      return basicres(msg: '该parentId无效', code: 401);
    }
    //存在就插入
    mysqlMethod.insertMysql(
        key: ['name', 'type', 'parentId', 'word'],
        params: [map['name'], map['type'], map['parentId'], ''],
        tableName: 'recordItem');
    return basicres(msg: '新增成功', code: 200);
  }

  ///删除笔记数据列表
  static Future<basicres> deleteDataList(String token, String uniId) async {
    var results = await mysqlMethod.deleteMysql(
        keyName: 'uniId', tableName: 'recordItem', values: [uniId]);

    return basicres(msg: '删除成功', code: 200);
  }

  ///修改笔记数据
  static Future<basicres> updataList(String token, String body) async {
    var map = jsonDecode(body);
    if (map['uniId'] == null) {
      return basicres(msg: 'uniId不能为空', code: 401);
    }

    ///检查uniId是否存在?
    var result = await mysqlMethod.queryMysql(
        key: ['uniId'],
        tableName: 'recordItem',
        condition: ['uniId=?'],
        conditionValues: [map['uniId']]);
    if (result!.isEmpty) {
      return basicres(msg: '不存在这个uniId', code: 200);
    }
    var results = await mysqlMethod.updataMysql(
        tableName: 'recordItem',
        keyNames: ['name', 'word'],
        values: [map['name'], map['word']],
        condition: 'uniId=?',
        conditionValues: [map['uniId']]);
    return basicres(msg: '修改成功', code: 200);
  }

  ///笔记封面权限修改
  static Future<basicres> updataPermission(String token, String body) async {
    var map = jsonDecode(body);
    if (map['uniId'] == null) {
      return basicres(msg: 'uniId不能为空', code: 401);
    }
    var results = await mysqlMethod.updataMysql(
        tableName: 'recordgrid',
        keyNames: ['permission'],
        values: [map['permission']],
        condition: 'uniId=?',
        conditionValues: [map['uniId']]);
    if (results!.affectedRows! < 1) {
      return basicres(msg: '修改权限失败', code: 401);
    }

    return basicres(msg: '修改成功', code: 200);
  }

  ///笔记封面锁定修改
  static Future<basicres> updataLocked(String token, String body) async {
    var map = jsonDecode(body);
    if (map['uniId'] == null) {
      return basicres(msg: 'uniId不能为空', code: 401);
    }
    var results = await mysqlMethod.updataMysql(
        tableName: 'recordgrid',
        keyNames: ['locked'],
        values: [map['locked']],
        condition: 'uniId=?',
        conditionValues: [map['uniId']]);
    if (results!.affectedRows! < 1) {
      return basicres(msg: '修改权限失败', code: 401);
    }

    return basicres(msg: '修改成功', code: 200);
  }
}
