import 'package:flutter/material.dart';
import 'package:tetris/blocks.dart';
import 'package:tetris/blocks_position.dart';
import 'score_screen.dart';
import 'gameplay.dart';
import 'next_block.dart';
import 'blocks.dart';
import 'package:provider/provider.dart';

class Data with ChangeNotifier {
  late Blocks nextBlock;
  num score = 0;
  bool isPlay = false;

  void setNext(Blocks nextBlock) {
    this.nextBlock = nextBlock;
    notifyListeners();
  }

  Widget getNextWidget() {
    if (!isPlay) return Container();
    var height = nextBlock.height;
    var width = nextBlock.width;
    var color;

    List<Widget> columns = [];
    for (var y = 0; y < width; ++y) {
      List<Widget> rows = [];
      for (var x = 0; x < height; ++x) {
        if (nextBlock.blocksPos
                .where((blockPos) => blockPos.x == x && blockPos.y == y)
                .length >
            0) {
          color = nextBlock.color;
        } else {
          color = Colors.transparent;
        }
        rows.add(Container(
          width: 12,
          height: 12,
          color: color,
        ));
      }
      columns.add(
        Row(mainAxisAlignment: MainAxisAlignment.center, children: rows),
      );
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: columns);
  }

  void setScore(score) {
    this.score = score;
    notifyListeners();
  }

  void getIsPlay(isPlay) {
    this.isPlay = isPlay;
    notifyListeners();
  }

  void getScore(score) {
    this.score += score;
    notifyListeners();
  }
}

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => Data(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tetris(),
    );
  }
}

class Tetris extends StatefulWidget {
  const Tetris({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  final GlobalKey<GameplayStatus> _key = GlobalKey();
  late Movement action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tetris'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ScoreScreen(),
            Expanded(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Gameplay(key: _key),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            NextBlock(),
                            const SizedBox(
                              height: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                Provider.of<Data>(context, listen: false).isPlay
                                    ? _key.currentState!.FinishGame()
                                    : _key.currentState!.startGame();
                              },
                              child: Text(
                                Provider.of<Data>(context, listen: false).isPlay
                                    ? 'End'
                                    : 'Start',
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
