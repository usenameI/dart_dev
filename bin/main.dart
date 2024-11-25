import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';
import 'api/router.dart';
import 'package:api_mana/mysql/globalMySql.dart';
import 'assets/assets.dart';

void main() async {
  await initializeDatabase();
  var app = router.app();
  var handler = createStaticHandler('project/web_dev/build/web',
      defaultDocument: 'index.html');
  var handlers = const Pipeline()
      .addMiddleware(logRequests()) // 可选：记录请求
      .addHandler((Request request) async {
    // 如果请求的路径是 API，则使用 API 处理器
    if (request.url.path.startsWith('api/')) {
      // return app(request);
      return app(request);
    }
    if (request.url.path.startsWith('assets/')) {
      return await assets.image(request);
    }
    // 否则使用静态文件处理器
    return handler(request);
  });
  var server = await shelf_io.serve(handlers, InternetAddress.anyIPv4, 86);
  // Enable content compression
  server.autoCompress = true;
  print('Serving at http://${server.address.host}:${server.port}');
}
