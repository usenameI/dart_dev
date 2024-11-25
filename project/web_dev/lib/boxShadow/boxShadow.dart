import 'package:flutter/material.dart';

class boxShadow {
  static BoxShadow shadow = BoxShadow(
    color: Colors.black.withOpacity(0.2), // 阴影颜色
    spreadRadius: 2, // 阴影扩散半径
    blurRadius: 3, // 模糊半径
    offset: Offset(0, 3), // 阴影偏移
  );
}
