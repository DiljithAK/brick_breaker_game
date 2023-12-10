import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final bool isGameOver;
  const GameOver({
    super.key,
    required this.isGameOver,
  });

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Container(
            alignment: const Alignment(0, -0.3),
            child: const Text(
              "GAME OVER",
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          )
        : Container();
  }
}
