import 'package:fluent_ui/fluent_ui.dart';
import 'package:web_dev/childPage/record/recordTool.dart';
import 'package:web_dev/componet/popOut/popOut.dart';

class recordComponent {
  static showAdd(contextOut) async {
    Map d = {
      'name': '',
      'description': '',
    };
    return await showDialog(
        context: contextOut,
        builder: (context) {
          return popOut.popContanier(
              child: ListView(
                padding: const EdgeInsets.only(top: 20),
                children: [
                  InfoLabel(
                    label: '笔记标题',
                    child: TextBox(
                      placeholder: '请输入',
                      expands: false,
                      unfocusedColor: Colors.transparent,
                      onChanged: (value) {
                        d['name'] = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InfoLabel(
                    label: '笔记标题',
                    child: TextBox(
                      placeholder: '请输入',
                      expands: false,
                      unfocusedColor: Colors.transparent,
                      minLines: 4,
                      maxLines: 99,
                      onChanged: (value) {
                        d['description'] = value;
                      },
                    ),
                  )
                ],
              ),
              close: () {
                Navigator.pop(context);
              },
              action: [
                FilledButton(
                    child: const Text('确定'),
                    onPressed: () {
                      recordTool.addG(d).then((res) {
                        if (res['code'] == 200) {
                          Navigator.pop(contextOut, true);
                        }
                      });
                    })
              ]);
        });
  }
}
