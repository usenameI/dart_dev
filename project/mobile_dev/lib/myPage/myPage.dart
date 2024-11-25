import 'package:flutter/material.dart';
import 'package:pro_mana/apiMana/apiMana.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class myPage extends StatefulWidget {
  @override
  State<myPage> createState() {
    // TODO: implement createState
    return _myPage();
  }
}

class _myPage extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Center(
        child: TDImage(
          width: 200,
          height: 200,
          type: TDImageType.circle,
          imgUrl: '${apiConfig.imageInter}Capture001.png',
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 15),
        child: TDText('用户名:'),
      )
    ]);
  }
}
