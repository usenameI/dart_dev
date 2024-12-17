import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_test/demo.dart';
import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

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
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    super.onTapDown(event);
    switch (direction) {
      case Direction.up:
        QController().moveUp();
        break;
      case Direction.down:
        // TODO: Handle this case.
        QController().moveDown();
        break;
      case Direction.left:
        // TODO: Handle this case.
        QController().moveLeft();
        break;
      case Direction.right:
        // TODO: Handle this case.
        QController().moveRight();
        break;
    }
    _isPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    super.onTapUp(event);
    _isPressed = false;
  }
}
