import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:web_dev/childPage/homePage/homePageComponent.dart';
import 'package:web_dev/childPage/homePage/homePageTool.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class homePage extends StatelessWidget {
  late homePageTool data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(create: (context) {
      return homePageTool();
    }, child: Builder(builder: (context) {
      data = context.read<homePageTool>();
      return Container(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text('欢迎来到主页'),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Selector<homePageTool, List>(
                    builder: (context, flie, child) {
                      if (flie.isEmpty) {
                        return Container(
                          color: Colors.grey,
                        );
                      }

                      return Swiper(
                        viewportFraction: 0.75,
                        outer: true,
                        autoplay: true,
                        itemCount: flie.length,
                        loop: true,
                        transformer: TDPageTransformer.margin(),
                        pagination: const SwiperPagination(
                            alignment: Alignment.center,
                            builder: TDSwiperPagination.dots),
                        itemBuilder: (BuildContext context, int index) {
                          var path = apiConfig.imageInter + flie[index]['name'];
                          return TDImage(imgUrl: path);
                        },
                      );
                    },
                    selector: (context, data) => data.flie)),
            Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                height: 200,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton(
                      onPressed: () {
                        homePageComponent
                            .showContentDialog(context)
                            .then((value) {
                          data.getAllFile();
                        });
                      },
                      child: const Text('设置主页图片'),
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('联系开发者'),
                    ),
                  ],
                ))
          ],
        ),
      );
    }));
  }
}
