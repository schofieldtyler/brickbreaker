import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  final playerWidth;
  final bool isGameOver;
  final bool hasGameStarted;

  MyPlayer(
      {this.playerX,
      this.playerWidth,
      required this.isGameOver,
      required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container(
            alignment:
                Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: MediaQuery.of(context).size.width / 5,
                  height: 5,
                  color:
                      isGameOver ? Colors.deepPurple[200] : Colors.deepPurple),
            ),
          )
        : Container();
  }
}
