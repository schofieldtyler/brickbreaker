import 'dart:async';
import 'package:brickbreaker/ball.dart';
import 'package:brickbreaker/brick.dart';
import 'package:brickbreaker/coverscreen.dart';
import 'package:brickbreaker/deadscreen.dart';
import 'package:brickbreaker/player.dart';
import 'package:brickbreaker/winscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum direction { LEFT, RIGHT, UP, DOWN }

class _HomePageState extends State<HomePage> {
  // player variables
  double playerX = -0.2;
  static double playerWidth = 0.4; // out of 2
  bool playerWon = false;
  double playerIncrements = 0.2;

  // ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXincrements = 0.0051;
  double ballYincrements = 0.0043;
  var ballXdirection = direction.LEFT;
  var ballYdirection = direction.DOWN;

  // brick variables
  static double brickWidth = 0.4;
  static double brickHeight = 0.05; // out of 2
  static int numberOfBricksInRow = 4;
  static double brickXGap = 0.01; // out of 2
  static double brickYGap = 0.01; // out of 2
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickXGap);
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.8;
  List myBricks = [
    // [x, y, broken = true/false]
    [
      firstBrickX + 0 * (brickWidth + brickXGap),
      firstBrickY + 0 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 1 * (brickWidth + brickXGap),
      firstBrickY + 0 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 2 * (brickWidth + brickXGap),
      firstBrickY + 0 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 3 * (brickWidth + brickXGap),
      firstBrickY + 0 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 0 * (brickWidth + brickXGap),
      firstBrickY + 1 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 1 * (brickWidth + brickXGap),
      firstBrickY + 1 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 2 * (brickWidth + brickXGap),
      firstBrickY + 1 * (brickHeight + brickYGap),
      false
    ],
    [
      firstBrickX + 3 * (brickWidth + brickXGap),
      firstBrickY + 1 * (brickHeight + brickYGap),
      false
    ],
  ];

  // game settings
  bool gameHasStarted = false;
  bool gameOver = false;

  void startGame() {
    gameHasStarted = true;

    Timer.periodic(Duration(milliseconds: 1), (timer) {
      // update direction
      updateDirection();

      // update ball position
      updateBallPosition();

      // check if ball hit brick
      isBrickDead();

      // check if player won
      if (didPlayerWin()) {
        timer.cancel();
        playerWon = true;
      }

      // check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        gameOver = true;
      }
    });
  }

  // void getScreenDimensions() {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   double brickGapFixed = screenWidth * brickXGap / 2;
  //   setState(() {
  //     brickYGap = 2 * brickGapFixed / screenHeight;
  //   });
  //   print(brickYGap);
  // }

  bool didPlayerWin() {
    int count = 0;
    for (int i = 0; i < myBricks.length; i++) {
      if (myBricks[i][1] == true) {
        count++;
      }
      if (count == myBricks.length) {
        return true;
      }
    }

    return false;
  }

  bool isPlayerDead() {
    // if ball reaches the bottom of the screen, then player is dead
    if (ballY >= 1) {
      return true;
    }

    return false;
  }

  void resetGame() {
    setState(() {
      gameOver = false;
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      myBricks = [
        // [x, y, broken = true/false]
        [
          firstBrickX + 0 * (brickWidth + brickXGap),
          firstBrickY + 0 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 1 * (brickWidth + brickXGap),
          firstBrickY + 0 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 2 * (brickWidth + brickXGap),
          firstBrickY + 0 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 3 * (brickWidth + brickXGap),
          firstBrickY + 0 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 0 * (brickWidth + brickXGap),
          firstBrickY + 1 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 1 * (brickWidth + brickXGap),
          firstBrickY + 1 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 2 * (brickWidth + brickXGap),
          firstBrickY + 1 * (brickHeight + brickYGap),
          false
        ],
        [
          firstBrickX + 3 * (brickWidth + brickXGap),
          firstBrickY + 1 * (brickHeight + brickYGap),
          false
        ],
      ];
      playerX = -0.2;
    });
  }

  void isBrickDead() {
    // checks each brick
    for (int i = 0; i < myBricks.length; i++) {
      // checks if ball is within a brick
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY >= myBricks[i][1] &&
          ballY <= myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false) {
        myBricks[i][2] = true;

        // check which side of the brick the ball hit
        // so that we can change the direction of the
        // ball accordingly

        // to do this, check distance from the ball to each side
        double leftSideDist = (myBricks[i][0] - ballX).abs();
        double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
        double topSideDist = (myBricks[i][1] - ballY).abs();
        double bottomSideDist = (myBricks[i][1] + brickHeight - ballY).abs();

        String min =
            findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
        switch (min) {
          case 'left':
            ballXdirection = direction.LEFT;
            break;
          case 'right':
            ballXdirection = direction.RIGHT;
            break;
          case 'top':
            ballYdirection = direction.UP;
            break;
          case 'bottom':
            ballYdirection = direction.DOWN;
            break;
        }
      }
    }
  }

  String findMin(double a, double b, double c, double d) {
    List<double> myList = [
      a,
      b,
      c,
      d,
    ];

    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'top';
    } else if ((currentMin - d).abs() < 0.01) {
      return 'bottom';
    }

    return '';
  }

  void updateBallPosition() {
    setState(() {
      // update horizontal ball position
      if (ballXdirection == direction.LEFT) {
        ballX -= ballXincrements;
      } else if (ballXdirection == direction.RIGHT) {
        ballX += ballXincrements;
      }

      // update vertical ball position
      if (ballYdirection == direction.UP) {
        ballY -= ballYincrements;
      } else if (ballYdirection == direction.DOWN) {
        ballY += ballYincrements;
      }
    });
  }

  void updateDirection() {
    // update vertical direction
    if (ballY >= 0.9 &&
        ballY <= 0.95 &&
        ballX >= playerX &&
        ballX <= playerX + playerWidth) {
      ballYdirection = direction.UP;
      // update horizontal depending on which side of brick the ball hits
      if (ballX <= playerX + playerWidth / 2) {
        ballXdirection = direction.LEFT;
      } else {
        ballXdirection = direction.RIGHT;
      }
    }
    if (ballY <= -1) {
      ballYdirection = direction.DOWN;
    }

    // update horizontal direction
    if (ballX >= 1) {
      ballXdirection = direction.LEFT;
    }

    if (ballX <= -1) {
      ballXdirection = direction.RIGHT;
    }
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - playerIncrements < -1)) {
        playerX -= playerIncrements;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerIncrements + playerWidth > 1)) {
        playerX += playerIncrements;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: gameHasStarted ? () {} : startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                // tap to play
                CoverSreen(
                  gameHasStarted: gameHasStarted,
                  isGameOver: gameOver,
                ),

                // win screen
                WinScreen(
                  playerWon: playerWon,
                  function: resetGame,
                ),

                // game over screen
                DeadScreen(
                  isGameOver: gameOver,
                  function: resetGame,
                ),

                // player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),

                // bricks
                MyBrick(
                  brickX: myBricks[0][0],
                  brickY: myBricks[0][1],
                  brickBroken: myBricks[0][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
                MyBrick(
                  brickX: myBricks[1][0],
                  brickY: myBricks[1][1],
                  brickBroken: myBricks[1][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
                MyBrick(
                  brickX: myBricks[2][0],
                  brickY: myBricks[2][1],
                  brickBroken: myBricks[2][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
                MyBrick(
                  brickX: myBricks[3][0],
                  brickY: myBricks[3][1],
                  brickBroken: myBricks[3][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),

                // 2nd row bricks
                MyBrick(
                  brickX: myBricks[4][0],
                  brickY: myBricks[4][1],
                  brickBroken: myBricks[4][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
                MyBrick(
                  brickX: myBricks[5][0],
                  brickY: myBricks[5][1],
                  brickBroken: myBricks[5][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
                MyBrick(
                  brickX: myBricks[6][0],
                  brickY: myBricks[6][1],
                  brickBroken: myBricks[6][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
                MyBrick(
                  brickX: myBricks[7][0],
                  brickY: myBricks[7][1],
                  brickBroken: myBricks[7][2],
                  ballX: ballX,
                  ballY: ballY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),

                // ball
                MyBall(
                  ballX: ballX,
                  ballY: ballY,
                  isGameOver: gameOver,
                  hasGameStarted: gameHasStarted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
