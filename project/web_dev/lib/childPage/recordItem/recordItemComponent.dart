import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:web_dev/childPage/recordItem/recordItemTool.dart';
import 'package:web_dev/componet/toast/toast.dart';

class recordItemComponent {
  ///
  static listComponent({required Function(Map) onTap}) {
    return Container(
      width: 250,
      child: Consumer<list>(
        builder: (BuildContext context, list l, Widget? child) {
          return Scrollbar(
              child: ListView.builder(
                  itemCount: l.record.length,
                  itemBuilder: (context, index) {
                    var item = l.record[index];
                    return ListTile.selectable(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] == '' ? '请输入标题' : item['name'],
                            style: TextStyle(
                                fontStyle: item['name'] == ''
                                    ? FontStyle.italic
                                    : null),
                          ),
                          Text(
                            item['createTime'],
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      selected: l.currentIndex == item['uniId'],
                      onSelectionChange: (v) {
                        l.currentIndex = item['uniId'];
                        l.notifyListeners();
                        onTap(item);
                      },
                    );
                  }));
        },
      ),
    );
  }

  ///编辑弹窗
  static eidtComponent({required Function updata}) {
    return Consumer<edit>(
      builder: (context, e, child) {
        return Stack(
          children: [
            if (e.currentData.isEmpty)
              const Center(
                child: Text('请选择一条数据'),
              )
            else
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('标题'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBox(
                        unfocusedColor: Colors.transparent,
                        controller: e.name,
                        onChanged: (value) {
                          e.currentData['name'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('内容'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBox(
                        onChanged: (value) {
                          e.currentData['word'] = value;
                        },
                        controller: e.content,
                        minLines: 4,
                        maxLines: 9999,
                        unfocusedColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
                right: 10,
                top: 5,
                child: DropDownButton(
                  title: const Text('新增'),
                  items: [
                    MenuFlyoutItem(
                        text: const Text('文字'),
                        onPressed: () {
                          e.addWord().then((res) {
                            if (res['code'] == 200) {
                              updata();
                              toast.show(context,
                                  content: '新增成功',
                                  type: InfoBarSeverity.success);
                            } else {
                              toast.show(context,
                                  content: '新增失败', type: InfoBarSeverity.error);
                            }
                          });
                        }),
                    const MenuFlyoutSeparator(),
                    MenuFlyoutItem(text: const Text('表格'), onPressed: null),
                  ],
                )),
            if (e.currentData.isNotEmpty)
              Positioned(
                  right: 10,
                  bottom: 5,
                  child: Row(
                    children: [
                      FilledButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.red)),
                          child: const Text('删除'),
                          onPressed: () async {
                            var state = await _showContentDialog(context);
                            if (state != true) {
                              return;
                            }
                            e.deleteData().then((res) {
                              if (res['code'] == 200) {
                                updata();
                                toast.show(context,
                                    content: '删除成功',
                                    type: InfoBarSeverity.success);
                              } else {
                                toast.show(context,
                                    content: '删除失败',
                                    type: InfoBarSeverity.error);
                              }
                            });
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      FilledButton(
                          child: const Text('保存'),
                          onPressed: () {
                            e.updata().then((res) {
                              if (res['code'] == 200) {
                                updata();
                                toast.show(context,
                                    content: '修改成功',
                                    type: InfoBarSeverity.success);
                              } else {
                                toast.show(context,
                                    content: '修改失败',
                                    type: InfoBarSeverity.error);
                              }
                            });
                          })
                    ],
                  )),
          ],
        );
      },
    );
  }

  ///删除弹窗
  static _showContentDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('提示'),
        content: const Text(
          '是否要删除这条数据',
        ),
        actions: [
          Button(
            child: const Text('删除'),
            onPressed: () {
              Navigator.pop(context, true);
              // Delete file here
            },
          ),
          FilledButton(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
