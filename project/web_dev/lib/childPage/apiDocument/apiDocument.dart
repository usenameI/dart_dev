import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:pro_mana/openUrl/jump_page.dart';

class apiDocument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          m.Material(
            color: Colors.transparent,
            child: Center(
              child: TDLink(
                label: '点击跳转接口文档地址，详细账号密码查管理员个人笔记 https://app.apifox.com/',
                style: TDLinkStyle.primary,
                type: TDLinkType.basic,
                size: TDLinkSize.small,
                linkClick: (uri) async {
                  String url = 'https://app.apifox.com'; // 替换为您要打开的网址
                  jump_page.jump(url);
                  // if (!await launchUrl(
                  //   Uri.parse(url),
                  // )) {
                  //   throw Exception('Could not launch $url');
                  // }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
