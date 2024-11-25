import 'dart:io';
import 'package:api_mana/header/header.dart';
import 'package:shelf/shelf.dart';

class assets {
  static Future<Response> image(Request requset) async {
    List list = requset.url.path.split('/');

    final directory = Directory('D:/mysqlAssets/images');
    final filePath = '${directory.path}/${list[1]}';
    print(filePath);
    // 检查文件是否存在
    final file = File(filePath);
    print(file.path);
    if (await file.exists()) {
      // 读取文件并返回
      final imageBytes = await file.readAsBytes();
      return Response.ok(imageBytes,
          headers: customHeader.images(
              'image/ ${file.path.split('.').last}', file.length().toString())
          //     {
          //   'Content-Type': 'image/png', // 根据实际图片格式调整
          // }
          );
    } else {
      return Response.notFound('File not found');
    }
  }
}
