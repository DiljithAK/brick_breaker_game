import 'dart:async';

import 'package:brick_breaker_game/ui/cover_screen.dart';
import 'package:brick_breaker_game/ui/widget/ball.dart';
import 'package:brick_breaker_game/ui/widget/brick.dart';
import 'package:brick_breaker_game/ui/widget/game_over.dart';
import 'package:brick_breaker_game/ui/widget/player.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Direction { up, down, left, right }

class _HomeScreenState extends State<HomeScreen> {
  double ballX = 0;
  double ballY = 0;
  double ballXincrement = 0.02;
  double ballYincrement = 0.01;

  double playerX = -0.2;
  double playerWidth = 0.4;

  bool isGameStarted = false;
  bool isGameOver = false;

  var ballXDirection = Direction.left;
  var ballYDirection = Direction.down;

  bool brickBroken = false;

  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.5;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;

  static int numberOfBricksInEachRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInEachRow * brickWidth -
          (numberOfBricksInEachRow - 1) * brickGap);

  List bricks = List.generate(numberOfBricksInEachRow, (index) {
    double x = firstBrickX + index * (brickWidth + brickGap);
    double y = firstBrickY;
    bool isBrickBoken = false;

    return [x, y, isBrickBoken];
  });

  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      moveBall();

      updateDirection();

      // Game over?
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      checkForBrokenBricks();
    });
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == Direction.left) {
        ballX -= ballXincrement;
      } else if (ballXDirection == Direction.right) {
        ballX += ballXincrement;
      }

      if (ballYDirection == Direction.down) {
        ballY += ballYincrement;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYincrement;
      }
    });
  }

  void updateDirection() {
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballYDirection = Direction.up;
    } else if (ballY <= -1) {
      ballYDirection = Direction.down;
    }

    if (ballX >= 1) {
      ballXDirection = Direction.left;
    } else if (ballX <= -1) {
      ballXDirection = Direction.right;
    }
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 <= -1.1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1.1)) {
        playerX += 0.2;
      }
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void checkForBrokenBricks() {
    for (var i = 0; i < bricks.length; i++) {
      if (ballX >= bricks[i][0] &&
          ballX <= bricks[i][0] + brickWidth &&
          ballY <= bricks[i][1] + brickHeight &&
          bricks[i][2] == false) {
        bricks[i][2] = true;

        double leftSideDist = (bricks[i][0] - ballX).abs();
        double rightSideDist = ((bricks[i][0] + brickWidth) - ballX).abs();
        double topSideDist = (bricks[i][1] - ballY).abs();
        double bottonSideDist = ((bricks[i][1] + brickHeight) - ballY).abs();

        String min =
            findMin(leftSideDist, rightSideDist, topSideDist, bottonSideDist);

        switch (min) {
          case "left":
            ballXDirection = Direction.left;
            break;
          case "right":
            ballXDirection = Direction.right;
            break;
          case "up":
            ballYDirection = Direction.up;
            break;
          case "bottom":
            ballYDirection = Direction.down;
            break;
        }
      }
    }
  }

  String findMin(
    double left,
    double right,
    double top,
    double bottom,
  ) {
    List<double> sideDist = [left, right, top, bottom];
    double currentSide = left;
    for (int i = 0; i < sideDist.length; i++) {
      if (sideDist[i] < currentSide) {
        currentSide = sideDist[i];
      }
    }

    if ((currentSide - left).abs() < 0.01) {
      return "left";
    } else if ((currentSide - right).abs() < 0.01) {
      return "right";
    } else if ((currentSide - top).abs() < 0.01) {
      return "top";
    } else if ((currentSide - bottom).abs() < 0.01) {
      return "bottom";
    }
    return "";
  }

  void restartGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      isGameStarted = false;
      isGameOver = false;
      bricks = List.generate(numberOfBricksInEachRow, (index) {
        double x = firstBrickX + index * (brickWidth + brickGap);
        double y = firstBrickY;
        bool isBrickBoken = false;

        return [x, y, isBrickBoken];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Center(
          child: Stack(
            children: [
              CoverScreen(isGameStarted: isGameStarted),
              GameOver(
                isGameOver: isGameOver,
                playAgain: restartGame,
              ),
              Ball(ballX: ballX, ballY: ballY, isGameStarted: isGameStarted),
              Player(playerX: playerX, playerWidth: playerWidth),
              for (var brick in bricks)
                Brick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: brick[0],
                  brickY: brick[1],
                  brickBroken: brick[2],
                ),
              Container(
                alignment: const Alignment(0, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: IconButton(
                        onPressed: () => moveLeft(),
                        icon: const Icon(Icons.play_circle_filled, size: 40),
                      ),
                    ),
                    IconButton(
                      onPressed: () => moveRight(),
                      icon: const Icon(Icons.play_circle_filled, size: 40),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
