import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:web_dev/router/router.dart';

class homeRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FluentApp.router(
      theme: FluentThemeData(),
      locale: const Locale('zh', 'CN'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: NavigationPaneTheme(
            data: const NavigationPaneThemeData(),
            child: child!,
          ),
        );
      },
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}

class home extends StatefulWidget {
  Widget child;
  home({required this.child});
  @override
  State<home> createState() {
    // TODO: implement createState
    return _home();
  }
}

class _home extends State<home> {
  int topIndex = 0;
  PaneDisplayMode displayMode = PaneDisplayMode.compact;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('专用开发系统'),
      ),
      paneBodyBuilder: (item, body) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: displayMode,
        items: items,
        footerItems: [
          PaneItemAction(
            icon: const Icon(FluentIcons.close_pane),
            title: const Text('退出'),
            onTap: () {
              Navigator.of(context).pop();

              // Your Logic to Add New `NavigationPaneItem`
            },
          ),
        ],
      ),
    );
  }

  List<NavigationPaneItem> get items => [
        PaneItem(
            key: const ValueKey('/'),
            icon: const Icon(FluentIcons.home),
            title: const Text('主页'),
            body: const SizedBox.shrink(),
            onTap: () {
              context.go('/');
            }),
        PaneItemSeparator(),
        PaneItem(
            key: const ValueKey('/record'),
            icon: const Icon(FluentIcons.book_answers),
            title: const Text('笔记'),
            body: const SizedBox.shrink(),
            onTap: () {
              context.go('/record');
            }),
        // PaneItem(
        //     key: const ValueKey('/record'),
        //     icon: const Icon(FluentIcons.issue_tracking),
        //     title: const Text('笔记'),
        //     body: SizedBox.shrink(),
        //     onTap: () {
        //       context.go('/record');
        //     }),
        PaneItem(
            key: const ValueKey('/apiDocument'),
            icon: const Icon(FluentIcons.account_management),
            title: const Text('接口文档'),
            body: const SizedBox.shrink(),
            onTap: () {
              context.go('/apiDocument');
            }),
        // PaneItem(
        //     key: const ValueKey('/map'),
        //     icon: const Icon(FluentIcons.map_pin),
        //     title: const Text('地图'),
        //     body: SizedBox.shrink(),
        //     onTap: () {
        //       context.go('/map');
        //     }),
        // PaneItem(
        //   key: const ValueKey('/test'),
        //   icon: const Icon(FluentIcons.test_auto_solid),
        //   title: const Text('测试'),
        //   body: SizedBox(
        //     child: Center(
        //       child: InfoLabel(
        //         label: '',
        //         child: Button(
        //           onPressed: () {
        //             context.push('/navigation_view');
        //           },
        //           child: const Text('Open in a new shell route'),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ];
}
