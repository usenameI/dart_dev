import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_test/demo.dart';
import 'package:flutter/material.dart';

class ButtonComponent1 extends RectangleComponent with TapCallbacks {
  late final Paint _paint = Paint();
  bool _isPressed = false;

  @override
  // TODO: implement paint
  Paint get paint => _paint;

  ButtonComponent1() {
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
    QController().moveRight();
    _isPressed = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    // TODO: implement onTapUp
    super.onTapUp(event);
    _isPressed = false;
  }
}
