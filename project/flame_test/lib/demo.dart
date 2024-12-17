import 'package:flame/game.dart';
import 'package:flame/components.dart';

import 'package:flame_test/ButtonComponent.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame {
  late final ButtonComponent1 up;
  late final ButtonComponent1 left;
  late final ButtonComponent1 right;
  late final ButtonComponent1 down;

  ///button size
  final btsize = Vector2(50, 50);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    QController().square = RectangleComponent()
      ..size = Vector2(50, 50)
      ..position = Vector2(100, 100);
    add(QController().square as Component);
    QController().content = this;
    // button
    //   ..position = Vector2(100, 100)
    //   ..size = Vector2(200, 60);
    up = ButtonComponent1()
      ..size = btsize
      ..position = Vector2(size.x / 2 - 25, size.y - 170);
    left = ButtonComponent1()
      ..size = btsize
      ..position = Vector2(size.x / 2 - 75, size.y - 120);
    right = ButtonComponent1()
      ..size = btsize
      ..position = Vector2(size.x / 2 + 25, size.y - 120);
    down = ButtonComponent1()
      ..size = btsize
      ..position = Vector2(size.x / 2 - 25, size.y - 70);
    add(up);
    add(left);
    add(right);
    add(down);
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);

  //   // Move the square to the right every frame
  //   controller.square?.position.x += 100 * dt;
  //   if (controller.square!.position.x > size.x) {
  //     controller.square?.position.x = -50;
  //   }
  // }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   // Draw the square manually using the custom canvas drawing
  //   final paint = Paint()..color = Colors.blue;
  //   canvas.drawRect(
  //     Rect.fromLTWH(
  //         controller.square!.position.x,
  //         controller.square!.position.y,
  //         controller.square!.size.x,
  //         controller.square!.size.y),
  //     paint,
  //   );
  // }
}

class QController {
  // 私有构造函数
  QController._privateConstructor();

  // 静态变量保存唯一实例
  static final QController _instance = QController._privateConstructor();

  // 提供一个静态方法获取实例
  static QController get instance => _instance;
  factory QController() {
    return _instance;
  }
  late final RectangleComponent? square;
  var content;

  moveRight() {
    square?.position.x += 100;
    if (square!.position.x > content.size.x) {
      square?.position.x = -50;
    }
  }

  moveLeft() {
    square?.position.x -= 100;
    if (square!.position.x > content.size.x) {
      square?.position.x = content.size.x + 50;
    }
  }

  moveUp() {
    square?.position.x += 100;
    if (square!.position.x > content.size.x) {
      square?.position.x = -50;
    }
  }

  moveDown() {
    square?.position.x += 100;
    if (square!.position.x > content.size.x) {
      square?.position.x = -50;
    }
  }
}
