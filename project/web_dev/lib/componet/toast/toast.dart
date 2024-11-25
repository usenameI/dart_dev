import 'package:fluent_ui/fluent_ui.dart';

class toast {
  static show(context,
      {required String content, InfoBarSeverity type = InfoBarSeverity.info}) {
    displayInfoBar(context, builder: (context, close) {
      return InfoBar(
        title: const Text('提示 :/'),
        content: Text(content),
        action: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: close,
        ),
        severity: type,
      );
    });
  }
}
