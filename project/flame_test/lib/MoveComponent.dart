import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/layout.dart';
import 'package:flame_test/Direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MoveComponent extends SpriteComponent {
  Vector2? parentSize;
  Direction? currentDir;
  ///move rection
  double length=1;
  ///destination
  Vector2? destination;

MoveComponent({
    super.sprite,
    super.autoResize,
    super.paint,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.nativeAngle,
    super.anchor,
    super.children,
    super.priority,
    super.key,
  });


  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    // size = Vector2(50, 50);
    
  //     children.add(
  //    AlignComponent(
  //   alignment: Anchor.center,
  //   child: TextComponent(text: '人',textRenderer: TextPaint(
  //   style: const TextStyle(
  //     color: Colors.white,
  //     fontSize: 50
  //   )
  // ))
  // )
  //   );
  //   paint.color=Colors.transparent;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
 destinationMove();

  }
  ///automatic move to destination
  destinationMove(){
    if (parentSize == null && parent != null) {
      parentSize = (parent! as RectangleComponent).size; // 确保 parent 不为 null
    }
    if(destination==null){
      return ;
    }
    if(position.x==destination!.x&&position.y==destination!.y){
      destination=null;
    }
    if(position.x<destination!.x){
      
      moveRight();
    }else if(position.x>destination!.x){
      moveLeft();
    }

    if(position.y<destination!.y){
      moveDown();
    }else if(position.y>destination!.y){
      moveUp();
    }



  }



  ///according to direction to move
  directionMove(){
   // 获取父组件的尺寸
    if (parentSize == null && parent != null) {
      parentSize = (parent! as RectangleComponent).size; // 确保 parent 不为 null
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
