import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({
    super.key,
    required this.isGameStarted,
  });

  final bool isGameStarted;

  @override
  Widget build(BuildContext context) {
    return isGameStarted
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.2),
            child: Text(
              'Tap to Play',
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          );
  }
}
