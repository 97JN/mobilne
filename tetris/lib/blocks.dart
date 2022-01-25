import 'package:flutter/material.dart';
import 'blocks_position.dart';

enum Movement { left, right, up, down, rotate, rotateCounter }

class Blocks {
  List<List<BlockPosition>> orientations = <List<BlockPosition>>[];
  late int x;
  late int y;
  late int orient;

  Blocks(this.orientations, Color color, this.orient) {
    x = 3;
    y = -height;
    this.color = color;
  }

  get blocksPos {
    return orientations[orient];
  }

  get width {
    // ignore: non_constant_identifier_names
    int x_max = 0;
    blocksPos.forEach((blockPos) {
      if (blockPos.x > x_max) x_max = blockPos.x;
    });
    return x_max + 1;
  }

  get height {
    // ignore: non_constant_identifier_names
    int y_max = 0;
    blocksPos.forEach((blockPos) {
      if (blockPos.y > y_max) y_max = blockPos.y;
    });
    return y_max + 1;
  }

  set color(Color color) {
    orientations.forEach((orientation) {
      orientation.forEach((blockPos) {
        blockPos.color = color;
      });
    });
  }

  Color get color {
    return orientations[0][0].color;
  }

  void move(Movement movement) {
    switch (movement) {
      case Movement.left:
        x -= 1;
        break;
      case Movement.right:
        x += 1;
        break;
      case Movement.up:
        y -= 1;
        break;
      case Movement.down:
        y += 1;
        break;
      case Movement.rotate:
        orient = ++orient % 4;
        break;
      case Movement.rotateCounter:
        orient = (orient + 3) % 4;
        break;
    }
  }
}

// ignore: camel_case_types
/*
   x
   x
   x
   x
*/
// ignore: camel_case_types
class iBlock extends Blocks {
  iBlock(int orient)
      : super([
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(0, 2),
            BlockPosition(0, 3)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(3, 0)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(0, 2),
            BlockPosition(0, 3)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(3, 0)
          ],
        ], Colors.cyan, orient);
}

// ignore: camel_case_types
/*
    x
    x
  xxx
*/
class jBlock extends Blocks {
  jBlock(int orient)
      : super([
          [
            BlockPosition(1, 0),
            BlockPosition(1, 1),
            BlockPosition(1, 2),
            BlockPosition(0, 2)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(2, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(0, 2)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(2, 1)
          ],
        ], Colors.blue, orient);
}

// ignore: camel_case_types
/*
    x
    x
    xxx
*/
class lBlock extends Blocks {
  lBlock(int orient)
      : super([
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(0, 2),
            BlockPosition(1, 2)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(0, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(1, 1),
            BlockPosition(1, 2)
          ],
          [
            BlockPosition(2, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(2, 1)
          ],
        ], Colors.orange, orient);
}

// ignore: camel_case_types
/*
    xxx
  xxx
*/
class sBlock extends Blocks {
  sBlock(int orient)
      : super([
          [
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(1, 2)
          ],
          [
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(1, 2)
          ],
        ], Colors.green, orient);
}

// ignore: camel_case_types
/* 
  xxx
    xxx
*/
// ignore: camel_case_types
class zBlock extends Blocks {
  zBlock(int orient)
      : super([
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(1, 1),
            BlockPosition(2, 1)
          ],
          [
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(0, 2)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(1, 1),
            BlockPosition(2, 1)
          ],
          [
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(0, 2)
          ],
        ], Colors.red, orient);
}

// ignore: camel_case_types
/*
    xxx
    xxx
*/
class oBlock extends Blocks {
  oBlock(int orient)
      : super([
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1)
          ],
        ], Colors.yellow, orient);
}

// ignore: camel_case_types
/*
    x
   xxx
*/
class tBlock extends Blocks {
  tBlock(int orient)
      : super([
          [
            BlockPosition(0, 0),
            BlockPosition(1, 0),
            BlockPosition(2, 0),
            BlockPosition(1, 1)
          ],
          [
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(1, 2)
          ],
          [
            BlockPosition(1, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(2, 1)
          ],
          [
            BlockPosition(0, 0),
            BlockPosition(0, 1),
            BlockPosition(1, 1),
            BlockPosition(0, 2)
          ],
        ], Colors.purple, orient);
}
