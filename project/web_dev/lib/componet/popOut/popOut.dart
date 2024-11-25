import 'package:fluent_ui/fluent_ui.dart';

class popOut {
  static popContanier(
      {required Widget child,
      required Function close,
      required List<Widget> action}) {
    return Center(
        child: Stack(
      children: [
        Container(
          width: 800,
          height: 600,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: child,
        ),
        Positioned(
            top: 5,
            right: 5,
            child: IconButton(
                onPressed: () {},
                icon: IconButton(
                  icon: const Icon(FluentIcons.clear, size: 24.0),
                  onPressed: () => close(),
                ))),
        Positioned(
            left: 5,
            right: 5,
            bottom: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: action,
            ))
      ],
    ));
  }
}
