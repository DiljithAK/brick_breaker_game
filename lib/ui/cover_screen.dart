import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool isGameStarted;
  const CoverScreen({
    super.key,
    required this.isGameStarted,
  });

  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 24));

  @override
  Widget build(BuildContext context) {
    return isGameStarted
        ? Container()
        : Stack(
          children: [
            Container(
                alignment: const Alignment(0, -0.2),
                child: Text(
                  'BRICK BRACKER',style: gameFont)),
            Container(
                alignment: const Alignment(0, -0.1),
                child: Text(
                  'Tap to Play',
                  style: TextStyle(color: Colors.deepPurple[400],
                  )))
          ],
        );
  }
}
