import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class NextBlock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NextBlockStatus();
}

class _NextBlockStatus extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white30,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Next',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.black87,
              child: Center(
                child:
                    Provider.of<Data>(context, listen: false).getNextWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
