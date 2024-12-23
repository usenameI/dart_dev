import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/Direction.dart';

class MoveComponent extends RectangleComponent {
  Vector2? parentSize;
  Direction? currentDir;
  ///move rection
  double length=2;


  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    size = Vector2(50, 50);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    // 获取父组件的尺寸
    if (parentSize == null && parent != null) {
      parentSize = (parent! as FlameGame).size; // 确保 parent 不为 null
    }
    if (parentSize != null) {
      switch(currentDir){
        
        case null:
          // TODO: Handle this case.
          break;
        case Direction.up:
          // TODO: Handle this case.
          moveUp();
          break;
        case Direction.down:
          // TODO: Handle this case.
          moveDown();
          break;
        case Direction.left:
          // TODO: Handle this case.
          moveLeft();
          break;
        case Direction.right:
          // TODO: Handle this case.
          moveRight();
          break;
      }
    }
  }

  moveRight() {
    if (parentSize == null) {
      return;
    }
    position.x += length;
    if (position.x > parentSize!.x) {
      position.x = -50;
    }
  }

  moveLeft() {
    if (parentSize == null) {
      return;
    }
    position.x -= length;
    if (position.x < -50) {
      position.x = parentSize!.x;
    }
  }

  moveUp() {
    if (parentSize == null) {
      return;
    }
    position.y -= length;
    if (position.y < -50) {
      position.y = parentSize!.y;
    }
  }

  moveDown() {
    if (parentSize == null) {
      return;
    }
    position.y += length;
    if (position.y > parentSize!.y + 50) {
      position.y = 0;
    }
  }
}
