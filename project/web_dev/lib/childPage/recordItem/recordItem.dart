import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';
import 'package:web_dev/childPage/recordItem/recordItemComponent.dart';
import 'package:web_dev/childPage/recordItem/recordItemTool.dart';

class recordItem extends StatelessWidget {
  String uniId;
  recordItem({required this.uniId}) {
    data = recordItemTool(parentId: uniId);
  }
  int? currentIndex;

  recordItemTool? data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        ChangeNotifierProvider(
            create: (context) => list(parentId: uniId),
            child: Builder(builder: (context) {
              data?.l = Provider.of<list>(context, listen: false);
              return recordItemComponent.listComponent(
                onTap: (p0) {
                  data?.changeCurrentData(p0);
                },
              );
            })),
        Expanded(
            child: ChangeNotifierProvider(
          create: (context) => edit(parentId: uniId),
          child: Builder(builder: (context) {
            data?.e = Provider.of<edit>(context, listen: false);
            return recordItemComponent.eidtComponent(updata: () {
              data?.l?.getRecord();
            });
          }),
        ))
      ],
    );
  }
}
