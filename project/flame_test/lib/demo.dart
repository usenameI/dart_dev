import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame_test/MoveComponent.dart';
import 'package:flutter/material.dart';


class MyGame extends FlameGame {

late final BackGroundLayer b;
  ///button size
  final btsize = Vector2(50, 50);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await images.load('role.png');
    QController().square=MoveComponent(sprite:Sprite(image));
    QController().square.position=Vector2(100,100);
    // children.add(QController().square as Component);
    // add(QController().square as Component);
    QController().content = this;
    var backGroundLayer = BackGroundLayer(
    size: size,
    paint: Paint()..color=Colors.white,
    children: [QController().square]);
    add(backGroundLayer);

  }

}

class BackGroundLayer extends RectangleComponent with TapCallbacks{
  
  BackGroundLayer({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    super.paint,
    super.paintLayers,
    super.key,
  });
  
  // @override
  // // TODO: implement paint
  // Paint get paint => (){
  //      final Paint _paint = Paint()..color=Colors.red;
   
  //   return _paint;
  // }();
@override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    super.onTapDown(event);
    QController().square.destination=event.localPosition;

  }

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

  late final MoveComponent square;

  var content;

}
