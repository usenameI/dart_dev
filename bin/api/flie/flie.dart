import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:api_mana/mysql/globalMySql.dart';
import 'package:shelf_multipart/shelf_multipart.dart';
import 'package:api_mana/response/basicRes.dart';
import 'package:shelf/shelf.dart';

class flie {
  ///存图片
  static Future<basicres> saveFile(Request request) async {
    if (request.multipart() case var multipart?) {
      // Iterate over parts making up this request:
      await for (final part in multipart.parts) {
        // Headers are available through part.headers as a map:
        final headers = part.headers;
        var contentDisposition = headers['content-disposition'];
        // 从 Content-Disposition 中提取文件名
        final fileName = _extractFileName(contentDisposition);

        var type = headers['content-type'];
        // 获取文件后缀名
        final fileExtension = _getFileExtension(fileName);
        var filename = '${mysqlMethod.uniValue()}.${fileExtension}';
        Uint8List value = await part.readBytes();
        String base64String = base64Encode(value);
        var res = await mysqlMethod.insertMysql(
            key: ['name', 'data', 'type'],
            params: [filename, base64String, type],
            tableName: 'flie');
        if (res!.affectedRows! < 1) {
          return basicres(code: 401, msg: '上传失败');
        }
        return basicres(code: 200, msg: '上传成功');
      }
    } else {
      return basicres(code: 401, msg: '上传失败');
    }

    return basicres(code: 401, msg: '上传失败');
  }

  ///取图片用来显示
  static Future getFile(String image) async {
    var results = await mysqlMethod.queryMysql(
        key: ['data', 'type'],
        tableName: 'flie',
        condition: ['name=?'],
        conditionValues: [image]);
    var data = results?.map((row) => row.fields).toList();
    if (data!.isEmpty) {
      return null;
    } else {
      // String base64String = base64Encode(data[0]['data'] as Uint8List);
      return {'data': data[0]['data'].toString(), 'type': data[0]['type']};
    }
  }

  ///获取图片名
  static Future<basicres> getFlieName() async {
    var results =
        await mysqlMethod.queryMysql(key: ['name', 'uniId'], tableName: 'flie');

    var data = results?.map((row) => row.fields).toList();
    return basicres(code: 200, record: data, msg: '查询成功');
  }

  ///删除图片
  static Future<basicres> deleteFile(String uniId) async {
    var results = await mysqlMethod
        .deleteMysql(keyName: 'uniId', tableName: 'flie', values: [uniId]);
    if (results!.affectedRows! < 1) {
      return basicres(code: 401, msg: '删除失败');
    }
    return basicres(code: 200, msg: '删除成功');
  }

  // 提取文件名的辅助函数
  static String _extractFileName(String? contentDisposition) {
    if (contentDisposition != null) {
      final regex = RegExp(r'filename="([^"]+)"');
      final match = regex.firstMatch(contentDisposition);
      if (match != null) {
        return match.group(1) ?? '';
      }
    }
    return '';
  }

// 获取文件后缀名的辅助函数
  static String _getFileExtension(String fileName) {
    return fileName.split('.').last;
  }

  ///图片上传-文件系统
  static Future<basicres> uploadFlie(Request request) async {
    if (request.multipart() case var multipart?) {
      // Iterate over parts making up this request:
      await for (final part in multipart.parts) {
        // Headers are available through part.headers as a map:
        final headers = part.headers;
        var contentDisposition = headers['content-disposition'];
        // 从 Content-Disposition 中提取文件名
        final fileName = _extractFileName(contentDisposition);
        // 获取文件后缀名
        final fileExtension = _getFileExtension(fileName);
        var fliename = '${mysqlMethod.uniValue()}.$fileExtension';
        Uint8List value = await part.readBytes();
        var state = await saveImageToDisk(value, fliename);
        if (state) {
          return basicres(code: 200, data: {'url': fliename}, msg: '上传成功');
        } else {
          return basicres(code: 401, msg: '上传失败');
        }
      }
    } else {
      return basicres(code: 401, msg: '上传失败');
    }

    return basicres(code: 401, msg: '上传失败');
  }

  ///存图片到文件夹
  static Future<bool> saveImageToDisk(
      Uint8List imageData, String fileName) async {
    // 指定文件保存路径
    String filePath = 'D:/mysqlAssets/images/$fileName';

    // 创建 File 对象
    final file = File(filePath);
    try {
      await file.writeAsBytes(imageData);
      return true;
    } catch (e) {
      return false;
    }
    // 将 Uint8List 数据写入文件
  }
}
