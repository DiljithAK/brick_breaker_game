import 'dart:async';

import 'package:first_game_app/ui/widget/ball.dart';
import 'package:first_game_app/ui/cover_screen.dart';
import 'package:first_game_app/ui/widget/brick.dart';
import 'package:first_game_app/ui/widget/game_over.dart';
import 'package:first_game_app/ui/widget/player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum direction { UP, DOWN }

class _HomeScreenState extends State<HomeScreen> {
  double ballX = 0;
  double ballY = 0;

  double playerX = -0.2;
  double playerWidth = 0.4;

  bool isGameStarted = false;
  bool isGameOver = false;

  var ballDirection = direction.DOWN;

  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4;
  double brickHeight = 0.05;

  bool brickBroken = false;

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
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void updateDirection() {
    if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
      ballDirection = direction.UP;
    } else if (ballY <= -1) {
      ballDirection = direction.DOWN;
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
    if (ballX >= brickX &&
        ballX <= brickX + brickWidth &&
        ballY <= brickY + brickHeight &&
        brickBroken == false) {
      brickBroken = true;
      ballDirection = direction.DOWN;
    }
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
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                CoverScreen(isGameStarted: isGameStarted),
                GameOver(
                  isGameOver: isGameOver,
                ),
                Ball(ballX: ballX, ballY: ballY),
                Player(playerX: playerX, playerWidth: playerWidth),
                Brick(
                  brickHeight: brickHeight,
                  brickWidth: brickWidth,
                  brickX: brickX,
                  brickY: brickY,
                  brickBroken: brickBroken,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
