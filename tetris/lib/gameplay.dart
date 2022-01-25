import 'package:flutter/material.dart';
import 'package:tetris/blocks.dart';
import 'package:provider/provider.dart';
import 'package:tetris/main.dart';
import 'dart:async';
import 'dart:math';
import 'blocks.dart';
import 'blocks_position.dart';

const x_axis = 10;
const y_axis = 20;
const game_width = 2.0;

enum collision { land, blockLand, wallHit, blockHit, clears }

class Gameplay extends StatefulWidget {
  const Gameplay({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GameplayStatus();
}

class GameplayStatus extends State<Gameplay> {
  Duration duration = Duration(milliseconds: 300);
  Blocks? blocks;
  GlobalKey gameArea = GlobalKey();

  late double width;
  late Timer timer;

  late Movement? action = null;
  late List<BlockPosition> usedBlocks;
  late bool isFinished = false;

  Blocks? newBlock() {
    int blockType = Random().nextInt(7);
    int orient = Random().nextInt(4);

    switch (blockType) {
      case 0:
        return iBlock(orient);
      case 1:
        return jBlock(orient);
      case 2:
        return lBlock(orient);
      case 3:
        return sBlock(orient);
      case 4:
        return zBlock(orient);
      case 5:
        return oBlock(orient);
      case 6:
        return tBlock(orient);
      default:
        return null;
    }
  }

  bool isBlockTouch() {
    for (var usedBlock in usedBlocks) {
      for (var blockPos in blocks!.blocksPos) {
        var x = blocks!.x + blockPos.x;
        var y = blocks!.y + blockPos.y;
        if (x == usedBlock.x && y + 1 == usedBlock.y) {
          return true;
        }
      }
    }
    return false;
  }

  bool isTouchEnd() {
    return blocks!.y + blocks!.height == y_axis;
  }

  bool isMapEnding(Movement? action) {
    return ((action == Movement.right && blocks!.x + blocks!.width >= x_axis) ||
        (action == Movement.left && blocks!.x <= 0));
  }

  void startGame() {
    Provider.of<Data>(context, listen: false).getIsPlay(true);
    Provider.of<Data>(context, listen: false).setScore(0);

    isFinished = false;
    usedBlocks = <BlockPosition>[];
    RenderBox? renderBoxGame =
        gameArea.currentContext!.findRenderObject() as RenderBox?;
    width = (renderBoxGame!.size.width - 2.0 * 2) / x_axis;

    var newBlock2 = newBlock();
    Provider.of<Data>(context, listen: false).setNext(newBlock2!);
    blocks = newBlock()!;

    timer = Timer.periodic(duration, onPlay);
  }

  void scored() {
    var points = 1;
    Map<int, int> rows = Map();
    List<int> removeRows = <int>[];

    usedBlocks.forEach((blockPos) {
      rows.update(blockPos.y, (value) => ++value, ifAbsent: () => 1);
    });

    rows.forEach((rowNr, count) {
      if (count == x_axis) {
        Provider.of<Data>(context, listen: false).getScore(points++);
        removeRows.add(rowNr);
      }
    });

    if (removeRows.length > 0) {
      remove(removeRows);
    }
  }

  void remove(List<int> remoweRows) {
    remoweRows.sort();
    remoweRows.forEach((rowNr) {
      usedBlocks.removeWhere((blockPos) => blockPos.y == rowNr);
      usedBlocks.forEach((blockPos) {
        if (blockPos.y < rowNr) {
          ++blockPos.y;
        }
      });
    });
  }

  void FinishGame() {
    Provider.of<Data>(context, listen: false).getIsPlay(false);
    timer.cancel();
  }

  void onPlay(Timer timer) {
    var stat = collision.clears;

    setState(() {
      if (action != null) {
        if (!isMapEnding(action)) {
          blocks!.move(action!);
        }
      }

      //disapearing
      for (var usedBlock in usedBlocks) {
        for (var blockPos in blocks!.blocksPos) {
          var x = blocks!.x + blockPos.x;
          var y = blocks!.y + blockPos.y;
          if (y == usedBlock.y && x == usedBlock.x) {
            switch (action) {
              case Movement.right:
                blocks!.move(Movement.right);
                break;
              case Movement.left:
                blocks!.move(Movement.left);
                break;

              default:
                break;
            }
          }
        }
      }

      if (!isTouchEnd()) {
        if (!isBlockTouch()) {
          blocks!.move(Movement.down);
        } else {
          stat = collision.blockLand;
        }
      } else {
        stat = collision.land;
      }

      if (stat == collision.blockLand && blocks!.y < 0) {
        isFinished = true;
        FinishGame();
      } else if (stat == collision.land || stat == collision.blockLand) {
        blocks!.blocksPos.forEach((blockPos) {
          blockPos.x += blocks!.x;
          blockPos.y += blocks!.y;
          usedBlocks.add(blockPos);
        });
        blocks = Provider.of<Data>(context, listen: false).nextBlock;
        var newBlock2 = newBlock();
        Provider.of<Data>(context, listen: false).setNext(newBlock2!);
      }
      action = null;
      scored();
    });
  }

  Positioned PositionContainer(Color color, int x, int y) {
    return Positioned(
      left: x * width,
      top: y * width,
      child: Container(
        width: width - 2.0,
        height: width - 2.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(const Radius.circular(3.0)),
        ),
      ),
    );
  }

  Widget? showBlocks() {
    if (blocks == null) return null;
    List<Positioned> blocksPos = <Positioned>[];

    blocks!.blocksPos.forEach((blockPos) {
      blocksPos.add(PositionContainer(
          blockPos.color, blockPos.x + blocks!.x, blockPos.y + blocks!.y));
    });

    usedBlocks.forEach((usedBlock) {
      blocksPos
          .add(PositionContainer(usedBlock.color, usedBlock.x, usedBlock.y));
    });

    if (isFinished) {
      blocksPos.add(Positioned(
          child: Container(
            width: 180,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.grey.shade700),
            child: Text(
              'Game Over',
              style: TextStyle(fontSize: 30, color: Colors.white70),
            ),
          ),
          left: 45,
          top: 200));
    }

    return Stack(
      children: blocksPos,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < 0) {
          action = Movement.left;
        } else {
          action = Movement.right;
        }
      },
      onTap: () {
        action = Movement.rotate;
      },
      child: AspectRatio(
        aspectRatio: x_axis / y_axis,
        child: Container(
          key: gameArea,
          decoration: BoxDecoration(
            color: Colors.black87,
            border: Border.all(
              width: game_width,
              color: Colors.white30,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: showBlocks(),
        ),
      ),
    );
  }
}
