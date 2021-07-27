import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickX;
  final brickY;
  double brickWidth; // out of 2
  double brickHeight; // out of 2
  final ballX;
  final ballY;
  final brickBroken;
  final bool isGameOver;
  final bool hasGameStarted;

  MyBrick(
      {this.brickX,
      this.brickY,
      this.ballX,
      this.ballY,
      this.brickBroken,
      required this.isGameOver,
      required this.brickWidth,
      required this.brickHeight,
      required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment((2 * brickX + brickWidth) / (2 - brickWidth),
            (2 * brickY + brickHeight) / (2 - brickHeight)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: MediaQuery.of(context).size.width * brickWidth / 2,
            height: brickBroken
                ? 0
                : MediaQuery.of(context).size.height * brickHeight / 2,
            color: hasGameStarted
                ? (isGameOver ? Colors.deepPurple[200] : Colors.deepPurple)
                : Colors.deepPurple[200],
          ),
        ));
  }
}
