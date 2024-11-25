import 'dart:convert';

import 'package:api_mana/header/header.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'flie.dart';

class fileApp {
  static addApp(Router app) {
    ///图片上传文件系统
    app.post('/api/uploadFile', (Request request) async {
      var res = await flie.uploadFlie(request);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/uploadFile', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///上传图片
    app.post('/api/upload', (Request request) async {
      var res = await flie.saveFile(request);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
    app.options('/api/upload', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///下载图片
    app.get('/api/image/<image>', (Request request, String image) async {
      var map = await flie.getFile(image);
      List<int> imageBytes = base64Decode(map['data']);
      return Response.ok(Stream.fromIterable([imageBytes]),
          headers:
              customHeader.images(map['type'], imageBytes.length.toString()));
    });
    app.options('/api/image/<image>', (Request request, String image) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    ///获取全部图片的名字
    app.get('/api/getAll', (Request request) async {
      var res = await flie.getFlieName();
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });

    app.options('/api/getAll', (Request request) async {
      return Response.ok('{}', headers: customHeader.apiHeader);
    });

    app.delete('/api/image/<uniId>', (Request request, String uniId) async {
      var res = await flie.deleteFile(uniId);
      return Response.ok(jsonEncode(res.toMap()),
          headers: customHeader.apiHeader);
    });
  }
}
