import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatelessWidget {
  final bool isGameOver;
  final void Function() playAgain;
  const GameOver({
    super.key,
    required this.isGameOver,
    required this.playAgain,
  });

  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 24));

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, -0.2),
                child: Text(
                  "G A M E  O V E R",
                  style: gameFont,
                ),
              ),
              Container(
                alignment: const Alignment(0, 0),
                child: GestureDetector(
                  onTap: playAgain,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.deepPurple,
                      child: const Text(
                        "Play again",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
