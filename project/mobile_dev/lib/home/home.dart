import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_dev/home/homeTool.dart';
import 'package:mobile_dev/myPage/myPage.dart';
import 'package:mobile_dev/sports/sports.dart';
import 'package:pro_mana/bottomBar/bottomBar.dart';
import 'package:pro_mana/customWidget/customWidget.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() {
    // TODO: implement createState
    return _home();
  }
}

class _home extends State<home> {
  int pageIndex = 0;

  var data = Get.put(homeTool());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<homeTool>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: pageIndex,
        children: [model(), myPage()],
      ),
      bottomNavigationBar: bottomBar.homeBottomBar(
          list: [
            bottomBarConfig(title: '模块', icon: TDIcons.home, renew: false),
            bottomBarConfig(
                title: '我的', icon: TDIcons.user_circle, renew: false)
          ],
          onTap: (p0) {
            pageIndex = p0;
            setState(() {});
          }),
    );
  }
}

class iconAndTitle {
  String title;
  Widget icon;
  Color color;
  Widget page;
  iconAndTitle(
      {required this.title,
      required this.icon,
      required this.color,
      required this.page});
}

class model extends StatefulWidget {
  @override
  State<model> createState() {
    // TODO: implement createState
    return _model();
  }
}

class _model extends State<model> {
  List<iconAndTitle> models = [
    iconAndTitle(
        title: '运动',
        icon: const FaIcon(
          FontAwesomeIcons.personRunning,
          color: Colors.white,
        ),
        color: const Color(0xffFFA500),
        page: sports()),
    iconAndTitle(
        title: '笔记',
        icon: const FaIcon(
          FontAwesomeIcons.book,
          color: Colors.white,
        ),
        color: const Color(0xff1E90FF),
        page: sports()),
    iconAndTitle(
        title: '音乐',
        icon: const FaIcon(
          FontAwesomeIcons.headphones,
          color: Colors.white,
        ),
        color: const Color(0xff800080),
        page: sports())
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return customWidget.pageBody(
        title: '主页',
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: 4),
          itemCount: models.length,
          itemBuilder: (context, index) {
            return TDButton(
              style: TDButtonStyle(backgroundColor: models[index].color),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  models[index].icon,
                  TDText(
                    models[index].title,
                    textColor: Colors.white,
                  )
                ],
              ),
              onTap: () {
                Get.to(() => models[index].page,
                    transition: Transition.rightToLeft);
              },
            );
          },
        ));
  }
}
