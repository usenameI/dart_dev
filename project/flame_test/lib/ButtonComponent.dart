import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_test/Direction.dart';
import 'package:flame_test/demo.dart';
import 'package:flutter/material.dart';



class ButtonComponent1 extends RectangleComponent with TapCallbacks {
  late final Paint _paint = Paint();
  bool _isPressed = false;

  @override
  // TODO: implement paint
  Paint get paint => _paint;

  Direction direction;

  ButtonComponent1({required this.direction}) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.fill;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Change color when pressed
    if (_isPressed) {
      _paint.color = Colors.green;
    } else {
      _paint.color = Colors.red;
    }
    // Draw the rectangle (button)
    // canvas.drawRect(size.toRect().shift(position.toOffset()), _paint);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    // TODO: implement onTapCancel
    super.onTapCancel(event);
    QController().square.currentDir=null;
    _isPressed = false;
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    // TODO: implement onLongTapDown
    super.onLongTapDown(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    super.onTapDown(event);
    QController().square.currentDir=direction;
    // switch (direction) {
    //   case Direction.up:
    //     QController().square.moveUp();
    //     break;
    //   case Direction.down:
    //     // TODO: Handle this case.
    //     QController().square.moveDown();
    //     break;
    //   case Direction.left:
    //     // TODO: Handle this case.
    //     QController().square.moveLeft();
    //     break;
    //   case Direction.right:
    //     // TODO: Handle this case.
    //     QController().square.moveRight();
    //     break;
    // }
    _isPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    super.onTapUp(event);
    QController().square.currentDir=null;
    _isPressed = false;
  }
}
