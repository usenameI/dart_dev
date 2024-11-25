import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';
import 'package:web_dev/boxShadow/boxShadow.dart';
import 'package:web_dev/childPage/record/recordComponent.dart';
import 'package:web_dev/childPage/record/recordTool.dart';
import 'package:web_dev/childPage/recordItem/recordItem.dart';
import 'package:web_dev/router/router.dart';

class recordRouter extends StatefulWidget {
  @override
  State<recordRouter> createState() {
    // TODO: implement createState
    return _recordRouter();
  }
}

class _recordRouter extends State<recordRouter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tabs.add(Tab(
        text: const Text('笔记'),
        semanticLabel: '笔记',
        icon: const FlutterLogo(),
        body: record(
          onQuery: (uniId, name) {
            openNewPage(uniId, name);
            if (mounted) {
              setState(() {});
            }
          },
        ),
      ));
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabView(
      tabs: tabs,
      currentIndex: currentIndex,
      onChanged: (index) => setState(() => currentIndex = index),
      tabWidthBehavior: TabWidthBehavior.equal,
      closeButtonVisibility: CloseButtonVisibilityMode.always,
      showScrollButtons: true,
      onReorder: (oldIndex, newIndex) {
        if (mounted) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = tabs.removeAt(oldIndex);
            tabs.insert(newIndex, item);
            if (currentIndex == newIndex) {
              currentIndex = oldIndex;
            } else if (currentIndex == oldIndex) {
              currentIndex = newIndex;
            }
          });
        }
      },
    );
  }

  int currentIndex = 0;
  List<Tab> tabs = [];

  ///打开新页面
  openNewPage(String uniId, String name) {
    late Tab tab;
    tab = Tab(
      text: Text(name),
      semanticLabel: name,
      icon: const FlutterLogo(),
      body: recordItem(
        uniId: uniId,
      ),
      onClosed: () {
        setState(() {
          if (currentIndex > 0) currentIndex--;
        });

        tabs.remove(tab);
      },
    );
    tabs.add(tab);
    currentIndex++;
  }
}

class record extends StatelessWidget {
  Function(String uniId, String name) onQuery;
  record({required this.onQuery});

  recordTool data = recordTool();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            HyperlinkButton(
              child: const Text('新增笔记'),
              onPressed: () {
                recordComponent.showAdd(context);
              },
            ),
          ],
        ),
        Expanded(
            child: ChangeNotifierProvider(
          create: (context) => recordGrid(),
          child: Consumer<recordGrid>(
            builder: (context, reG, child) {
              data.reG = reG;
              return m.Material(
                child: Scrollbar(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250, // 每个项目的最大宽度
                          childAspectRatio: 1, // 宽高比
                          crossAxisSpacing: 10, // 列间距
                          mainAxisSpacing: 10, // 行间距
                        ),
                        itemCount: reG.list.length,
                        itemBuilder: (context, index) {
                          var item = reG.list[index];
                          FlyoutController controller = FlyoutController();
                          return Padding(
                            padding: const EdgeInsets.all(3),
                            child: FlyoutTarget(
                                controller: controller,
                                child: Button(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5DC),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      boxShadow: [boxShadow.shadow],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            item['name'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(item['description']),
                                        ),
                                        Text('创建时间:${item['createTime']}'),
                                        Row(
                                          children: [
                                            Tooltip(
                                              message: item['permission']
                                                  ? '取消权限'
                                                  : '启用权限',
                                              useMousePosition: false,
                                              style: const TooltipThemeData(
                                                  waitDuration: Duration(),
                                                  preferBelow: true),
                                              child: IconButton(
                                                  icon: Icon(
                                                    FluentIcons
                                                        .permissions_solid,
                                                    color: item['permission']
                                                        ? Colors
                                                            .warningPrimaryColor
                                                        : Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    data.revisePermission(
                                                        !item['permission'],
                                                        item['uniId']);
                                                  }),
                                            ),
                                            Tooltip(
                                              message: item['locked']
                                                  ? '取消锁定'
                                                  : '锁定',
                                              useMousePosition: false,
                                              style: const TooltipThemeData(
                                                  waitDuration: Duration(),
                                                  preferBelow: true),
                                              child: IconButton(
                                                  icon: Icon(
                                                    item['locked']
                                                        ? FluentIcons.lock_solid
                                                        : FluentIcons
                                                            .unlock_solid,
                                                    color: item['locked']
                                                        ? Colors
                                                            .warningPrimaryColor
                                                        : Colors.blue,
                                                  ),
                                                  onPressed: () {
                                                    data.reviseLocked(
                                                        !item['locked'],
                                                        item['uniId']);
                                                  }),
                                            ),
                                            Tooltip(
                                              message: '编辑',
                                              useMousePosition: false,
                                              style: const TooltipThemeData(
                                                  waitDuration: Duration(),
                                                  preferBelow: true),
                                              child: IconButton(
                                                  icon: Icon(
                                                    FluentIcons.edit_solid12,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () {}),
                                            ),
                                            Tooltip(
                                              message: '删除',
                                              useMousePosition: false,
                                              style: const TooltipThemeData(
                                                  waitDuration: Duration(),
                                                  preferBelow: true),
                                              child: IconButton(
                                                  icon: const Icon(
                                                    FluentIcons.delete,
                                                    color: Colors
                                                        .warningPrimaryColor,
                                                  ),
                                                  onPressed: () {}),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    if (item['permission']) {
                                      permissionAlert(controller);
                                      return;
                                    }
                                  },
                                )),

                            // m.InkWell(
                            //   onTap: () {
                            //     if (item['permission']) {

                            //       return;
                            //     }
                            //     onQuery(item['uniId'], item['name']);
                            //   },
                            //   child: Container(
                            //     padding: const EdgeInsets.all(5),
                            //     decoration: BoxDecoration(
                            //       color: const Color(0xFFF5F5DC),
                            //       borderRadius: const BorderRadius.all(
                            //           Radius.circular(5)),
                            //       boxShadow: [boxShadow.shadow],
                            //     ),
                            //     child: Column(
                            //       crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //       children: [
                            //         Center(
                            //           child: Text(
                            //             item['name'],
                            //             style: const TextStyle(fontSize: 20),
                            //           ),
                            //         ),
                            //         Expanded(
                            //           child: Text(item['description']),
                            //         ),
                            //         Text('创建时间:${item['createTime']}'),
                            //         Row(
                            //           children: [
                            //             Tooltip(
                            //               message: item['permission']
                            //                   ? '取消权限'
                            //                   : '启用权限',
                            //               useMousePosition: false,
                            //               style: const TooltipThemeData(
                            //                   waitDuration: Duration(),
                            //                   preferBelow: true),
                            //               child: IconButton(
                            //                   icon: Icon(
                            //                     FluentIcons.permissions_solid,
                            //                     color: item['permission']
                            //                         ? Colors
                            //                             .warningPrimaryColor
                            //                         : Colors.blue,
                            //                   ),
                            //                   onPressed: () {
                            //                     data.revisePermission(
                            //                         !item['permission'],
                            //                         item['uniId']);
                            //                   }),
                            //             ),
                            //             Tooltip(
                            //               message:
                            //                   item['locked'] ? '取消锁定' : '锁定',
                            //               useMousePosition: false,
                            //               style: const TooltipThemeData(
                            //                   waitDuration: Duration(),
                            //                   preferBelow: true),
                            //               child: IconButton(
                            //                   icon: Icon(
                            //                     item['locked']
                            //                         ? FluentIcons.lock_solid
                            //                         : FluentIcons
                            //                             .unlock_solid,
                            //                     color: item['locked']
                            //                         ? Colors
                            //                             .warningPrimaryColor
                            //                         : Colors.blue,
                            //                   ),
                            //                   onPressed: () {
                            //                     data.reviseLocked(
                            //                         !item['locked'],
                            //                         item['uniId']);
                            //                   }),
                            //             ),
                            //             Tooltip(
                            //               message: '编辑',
                            //               useMousePosition: false,
                            //               style: const TooltipThemeData(
                            //                   waitDuration: Duration(),
                            //                   preferBelow: true),
                            //               child: IconButton(
                            //                   icon: Icon(
                            //                     FluentIcons.edit_solid12,
                            //                     color: Colors.blue,
                            //                   ),
                            //                   onPressed: () {}),
                            //             ),
                            //             Tooltip(
                            //               message: '删除',
                            //               useMousePosition: false,
                            //               style: const TooltipThemeData(
                            //                   waitDuration: Duration(),
                            //                   preferBelow: true),
                            //               child: IconButton(
                            //                   icon: const Icon(
                            //                     FluentIcons.delete,
                            //                     color: Colors
                            //                         .warningPrimaryColor,
                            //                   ),
                            //                   onPressed: () {}),
                            //             ),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          );
                        })),
              );
            },
          ),
        ))
      ],
    );
  }

  permissionAlert(FlyoutController controller) {
    controller.showFlyout(
      autoModeConfiguration: FlyoutAutoConfiguration(
        preferredMode: FlyoutPlacementMode.topCenter,
      ),
      barrierDismissible: true,
      dismissOnPointerMoveAway: false,
      dismissWithEsc: true,
      navigatorKey: rootNavigatorKey.currentState,
      builder: (context) {
        return FlyoutContent(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '该内容已被设置权限',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12.0),
              Button(
                onPressed: Flyout.of(context).close,
                child: const Text('确定'),
              ),
            ],
          ),
        );
      },
    );
  }
}
