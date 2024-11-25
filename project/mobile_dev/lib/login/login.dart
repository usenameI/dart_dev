import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_dev/home/home.dart';
import 'package:mobile_dev/login/loginTool.dart';
import 'package:pro_mana/apiMana/apiMana.dart';
import 'package:pro_mana/style/color/colorUse.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() {
    // TODO: implement createState
    return _login();
  }
}

class _login extends State<login> {
  TextEditingController username = TextEditingController(text: 'admin');
  TextEditingController password = TextEditingController(text: '123456');
  Map get loginData => {'username': username.text, 'password': password.text};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///设置网球请求地址
    apiConfig.internetAddress = 'http://192.168.1.4:86';
    apiConfig.imageInter = 'http://192.168.1.4:86/assets/';
  }

  var data = Get.put(loginTool());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<loginTool>();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: colorUse.bc,
      // resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TDText(
            '个人管理平台',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          TDInput(
            leftLabel: '账号:',
            controller: username,
            backgroundColor: Colors.white,
            hintText: '请输入文字',
            onChanged: (text) {},
            onClearTap: () {
              username.clear();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TDInput(
            obscureText: true,
            leftLabel: '密码:',
            controller: password,
            backgroundColor: Colors.white,
            hintText: '请输入文字',
            onChanged: (text) {},
            onClearTap: () {
              password.clear();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<loginTool>(
            id: 'login',
            builder: (controller) {
              return TDButton(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                text: data.loading ? '登录中' : '登录',
                theme: TDButtonTheme.primary,
                onTap: () {
                  if (data.loading) {
                    return;
                  }
                  TDLoadingController.show(context);
                  data.update(['login']);
                  data.login(loginData).then((value) {
                    data.update(['login']);
                    TDLoadingController.dismiss();
                    if (value == true) {
                      TDToast.showSuccess('登录成功', context: context);
                      Get.to(() => home(), transition: Transition.noTransition);
                    } else {
                      TDToast.showFail('登录失败', context: context);
                    }
                  });
                },
              );
            },
          ),
          // SizedBox(
          //   height: 10,
          // ),
          TDButton(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            text: '注册',
            theme: TDButtonTheme.primary,
            type: TDButtonType.text,
            onTap: () async {
              const platform = MethodChannel('com.example.mobile_dev/android');
              final String result = await platform.invokeMethod('test');
              print('log__$result');
            },
          ),
        ],
      ),
    );
  }
}
