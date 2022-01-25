import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class ScoreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScoreStatus();
}

class _ScoreStatus extends State {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Score: ${Provider.of<Data>(context).score}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
