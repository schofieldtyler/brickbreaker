import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverSreen extends StatelessWidget {
  // font
  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 2, fontSize: 30));

  final bool gameHasStarted;
  final bool isGameOver;

  CoverSreen({required this.gameHasStarted, required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(0, -0.5),
            child: Text(isGameOver ? '' : 'BRICKBREAKER',
                style: gameFont.copyWith(color: Colors.deepPurple[200])),
          )
        : Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.5),
                child: Text('BRICKBREAKER', style: gameFont),
              ),
              Container(
                alignment: Alignment(0, -0.1),
                child: Text(
                  't a p   t o   p l a y',
                  style: TextStyle(
                      color: Colors.deepPurple[300],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment(0, 0.85),
                child: Text(
                  '❤  c r e a t e d b y k o k o',
                  style: TextStyle(
                      color: Colors.deepPurple[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ],
          );
  }
}
