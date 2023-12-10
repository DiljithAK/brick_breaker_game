import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool isGameStarted;

  const Ball({
    super.key,
    required this.ballX,
    required this.ballY,
    required this.isGameStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(ballX, ballY),
      child: isGameStarted
          ? const BallWidget()
          : const AvatarGlow(
              endRadius: 60.0,
              child: BallWidget(),
            ),
    );
  }
}

class BallWidget extends StatelessWidget {
  const BallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        shape: BoxShape.circle,
      ),
    );
  }
}
