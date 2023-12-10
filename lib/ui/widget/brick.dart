import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickHeight;
  final double brickWidth;
  final double brickX;
  final double brickY;
  final bool brickBroken;
  const Brick({
    super.key,
    required this.brickHeight,
    required this.brickWidth,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? Container()
        : Container(
            alignment: Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: Container(
              height: MediaQuery.of(context).size.height * brickHeight / 2,
              width: MediaQuery.of(context).size.width * brickWidth / 2,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
  }
}
