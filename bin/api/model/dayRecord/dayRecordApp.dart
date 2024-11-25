import 'dart:convert';
import 'package:api_mana/header/header.dart';
import 'package:api_mana/response/basicRes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'dayRecord.dart';

class dayrecordapp {
  static addApp(Router app) {
    ///获取笔记封面
    app.get('/api/recordGrid', (Request request) async {
      ///密钥
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }

      ///url参数
      var string = await request.url.queryParameters;
      basicres res = await dayRecord.getList(token, string);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });

    app.options('/api/recordGrid', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///新增笔记封面接口
    app.post('/api/recordGrid/add', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }

      var body = await request.readAsString();
      basicres res = await dayRecord.addList(token, body);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordGrid/add', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///修改笔记封面
    app.post('/api/recordGrid/update', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }
      var body = await request.readAsString();
      basicres res = await dayRecord.updateList(token, body);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordGrid/update', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///删除笔记封面
    app.delete('/api/recordGrid/<uniId>',
        (Request request, String uniId) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }
      var res = await dayRecord.deleteList(token, uniId);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordGrid/<uniId>',
        (Request request, String uniId) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///权限修改
    app.post('/api/recordGrid/permission', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }
      var body = await request.readAsString();
      var res = await dayRecord.updataPermission(token, body);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordGrid/permission', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///锁定修改
    app.post('/api/recordGrid/locked', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }
      var body = await request.readAsString();
      var res = await dayRecord.updataLocked(token, body);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordGrid/locked', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///获取笔记数据的接口
    app.get('/api/recordItem', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }

      ///url参数
      var string = await request.url.queryParameters;
      basicres res = await dayRecord.getDataList(token, string);

      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordItem', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    app.options('/api/recordItem/add', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///新增笔记数据接口
    app.post('/api/recordItem/add', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }

      ///url参数
      var body = await request.readAsString();
      basicres res = await dayRecord.addDataList(token, body);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });

    ///删除笔记数据接口
    app.delete('/api/recordItem/<uniId>',
        (Request request, String uniId) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }
      basicres res = await dayRecord.deleteDataList(token, uniId);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordItem/<uniId>',
        (Request request, String uniId) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///修改笔记数据
    app.post('/api/recordItem/updata', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }

      ///url参数
      var body = await request.readAsString();
      var res = await dayRecord.updataList(token, body);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/recordItem/updata', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });
  }
}
