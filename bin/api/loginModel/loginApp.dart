import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:api_mana/header/header.dart';
import 'login.dart';

class Loginapp {
  static addApp(Router app) {
    app.options('/api/login', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///添加登录接口
    app.post('/api/login', (Request request) async {
      var string = await request.readAsString();
      var res = await login.checkCode(string);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });

    ///添加注册接口
    app.post('/api/register', (Request request) async {
      var string = await request.readAsString();
      var res = await login.register(string);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/register', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });
  }
}
