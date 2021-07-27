import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeadScreen extends StatelessWidget {
  // font
  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 28));
  final bool isGameOver;
  final function;

  DeadScreen({required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.2),
                child: Container(
                  child: Text(
                    'GAME OVER',
                    style: gameFont.copyWith(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: function,
                child: Container(
                  alignment: Alignment(0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.deepPurple,
                      padding: EdgeInsets.all(20),
                      child: Text('PLAY AGAIN',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}
