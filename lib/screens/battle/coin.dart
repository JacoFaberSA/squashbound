import 'dart:math';

import 'package:flutter/material.dart';
import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/screens/battle/battle.dart';
import 'package:squashbound/theme.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  String title = "First play";

  int firstPlayer = Random().nextInt(2) + 1;
  double turns = 0.0;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        turns = firstPlayer == 1 ? 15 : 15.25;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: SquashboundTheme.textTheme.titleLarge,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: AnimatedRotation(
                    turns: turns,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    onEnd: () {
                      setState(() {
                        title = "Player $firstPlayer starts";
                      });

                      Future.delayed(Duration(seconds: 1), () {
                        if (context.mounted) {
                          Battle.of(context).reset();
                          Battle.of(context).nextTurn(playerTurn: firstPlayer);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BattleScreen(),
                            ),
                          );
                        }
                      });
                    },
                    child: CustomPaint(
                      size: const Size(300, 300),
                      painter: CirclePainter(
                        player1: Decks.of(context).player1.color,
                        player2: Decks.of(context).player2.color,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 120,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color player1;
  final Color player2;

  CirclePainter({this.player1 = Colors.blue, this.player2 = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Top left quadrant - player1
    final paint1 = Paint()
      ..color = player1
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 4,
      -pi,
      true,
      paint1,
    );

    // Top right quadrant - player2
    final paint2 = Paint()
      ..color = player2
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 4,
      pi / 2,
      true,
      paint2,
    );

    // Bottom right quadrant - player1
    final paint3 = Paint()
      ..color = player1
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 4,
      pi / 2,
      true,
      paint3,
    );

    // Bottom left quadrant - player2
    final paint4 = Paint()
      ..color = player2
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      3 * pi / 4,
      pi / 2,
      true,
      paint4,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
