import 'dart:convert';
import 'package:api_mana/header/header.dart';
import 'package:api_mana/response/basicRes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'mapSite.dart';

class mapSiteApp {
  static addApp(Router app) {
    app.post('/api/mapSite', (Request request) async {});

    app.get('/api/mapSite', (Request request) async {
      String? token = request.headers['Authorization'];
      if (token == null) {
        // 没有token的回复
        return Response.ok(jsonEncode(basicres.noAuthorization()),
            headers: customHeader.apiHeader);
      }
      var res = await mapSite.getAllSite();
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/mapSite', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });
  }
}
