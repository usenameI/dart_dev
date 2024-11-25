import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:web_dev/childPage/apiDocument/apiDocument.dart';
import 'package:web_dev/childPage/homePage/homePage.dart';
import 'package:web_dev/childPage/login/login.dart';
import 'package:web_dev/childPage/record/record.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: rootNavigatorKey, routes: [
  // GoRoute(path: '/', builder: (context, state) => login(child: ,)),

  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) {
      return login(
        child: child,
      );
      // return home(
      //   child: child,
      // );
    },
    routes: <GoRoute>[
      GoRoute(path: '/', builder: (context, state) => homePage()),
      GoRoute(path: '/record', builder: (context, state) => recordRouter()),
      GoRoute(path: '/apiDocument', builder: (context, state) => apiDocument())
    ],
  ),
]);

class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.blue,
    );
  }
}
