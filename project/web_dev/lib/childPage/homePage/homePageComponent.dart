import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:web_dev/childPage/homePage/homePageTool.dart';
import 'package:web_dev/componet/popOut/popOut.dart';

class homePageComponent {
  static Future<bool> showContentDialog(BuildContext context) async {
    bool isOnTap = false;

    homePagePop data;
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider(create: (context) {
          return homePagePop();
        }, child: Builder(builder: (context) {
          data = context.read<homePagePop>();
          return popOut.popContanier(
            child: Selector<homePagePop, List>(
              builder: (context, flie, child) {
                return GridView.builder(
                    padding: const EdgeInsets.only(top: 50),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 4),
                    itemCount: flie.length,
                    itemBuilder: (context, index) {
                      var path = flie[index]['name'];
                      var uniId = flie[index]['uniId'];
                      return Stack(
                        children: [
                          TDImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fill,
                            imgUrl: apiConfig.imageInter + path,
                          ),
                          Positioned(
                              top: 5,
                              right: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(104, 50, 49, 48),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                    icon: const Icon(
                                      FluentIcons.clear,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      isOnTap = true;
                                      data.deleteFlie(uniId);
                                    }),
                              ))
                        ],
                      );
                    });
              },
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              selector: (BuildContext, homePagePop) => homePagePop.flie,
            ),
            close: () => Navigator.pop(context),
            action: [
              FilledButton(
                  child: const Text('添加图片'),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null) {
                      isOnTap = true;
                      var fileBytes = result.files.first.bytes;
                      String fileName = result.files.first.name;
                      data.flie;
                      data.upload(fileBytes, fileName);
                      // var data = Get.find<homePageTool>(tag: rander);
                      // data.upload(fileBytes, fileName);
                    } else {}
                  })
            ],
          );
        }));
      },
    );
    return isOnTap;
  }
}
