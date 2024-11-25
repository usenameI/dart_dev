import 'package:fluent_ui/fluent_ui.dart';
import 'package:pro_mana/apiMana/apiMana.dart';
import 'package:provider/provider.dart';
import 'package:web_dev/childPage/home/home.dart';
import 'package:web_dev/childPage/login/loginTool.dart';

Widget? childs;

class login extends StatefulWidget {
  Widget child;
  login({required this.child});

  @override
  State<login> createState() {
    // TODO: implement createState
    return _login();
  }
}

///登录页面
class _login extends State<login> {
  TextEditingController username = TextEditingController(text: 'admin');
  TextEditingController password = TextEditingController(text: '123456');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///设置网球请求地址
    apiConfig.internetAddress = 'http://localhost:86';
    apiConfig.imageInter = 'http://localhost:86/api/image/';
  }

  @override
  Widget build(BuildContext context) {
    print('log__状态');
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: Card(
        child: SizedBox(
          child: Stack(children: [
            const _AcrylicChildren(),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Acrylic(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 250,
                          child: PasswordBox(
                            controller: username,
                            unfocusedColor: Colors.transparent,
                            leadingIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('账号:'),
                            ),
                            revealMode: PasswordRevealMode.visible,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: PasswordBox(
                            controller: password,
                            unfocusedColor: Colors.transparent,
                            leadingIcon: const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('密码:'),
                            ),
                            revealMode: PasswordRevealMode.peekAlways,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Selector<Counter, bool>(
                          selector: (context, counter) => counter.loading,
                          builder: (context, par, child) {
                            final counter =
                                Provider.of<Counter>(context, listen: false);
                            return SizedBox(
                              width: 250,
                              child: FilledButton(
                                onPressed: par
                                    ? null
                                    : () {
                                        counter.increment();
                                        counter.login(context, {
                                          'username': username.text,
                                          'password': password.text
                                        }, () {
                                          // context.push('/s');
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).push(FluentPageRoute(
                                              builder: (context) {
                                            return home(child: widget.child);
                                          }));
                                        });
                                      },
                                child: par
                                    ? const SizedBox(
                                        width: 21,
                                        height: 21,
                                        child: ProgressRing(
                                          backgroundColor: Colors.transparent,
                                          activeColor: Colors.white,
                                        ),
                                      )
                                    : const Text('登    录'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
                top: 120,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'WTF学习平台',
                    style: TextStyle(fontSize: 40),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}

class _AcrylicChildren extends StatelessWidget {
  const _AcrylicChildren();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 200,
        width: 100,
        color: Colors.blue.lightest,
      ),
      Align(
        alignment: AlignmentDirectional.center,
        child: Container(
          height: 152,
          width: 152,
          color: Colors.magenta,
        ),
      ),
      Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          height: 100,
          width: 80,
          color: Colors.yellow,
        ),
      ),
    ]);
  }
}
