import 'package:flutter/material.dart';

class BlockPosition {
  late int x;
  late int y;
  late Color color;
  BlockPosition(int x, int y, [Color color = Colors.transparent]) {
    this.x = x;
    this.y = y;
    this.color = color;
  }
}
