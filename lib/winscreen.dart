import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  final bool playerWon;
  final function;

  WinScreen({required this.playerWon, this.function});

  @override
  Widget build(BuildContext context) {
    return playerWon
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.2),
                child: Container(
                  child: Text(
                    'Y O U  W I N',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                    ),
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
                      padding: EdgeInsets.all(10),
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
