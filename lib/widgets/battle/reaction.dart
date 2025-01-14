import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';
import 'package:squashbound/theme.dart';

enum BattleReactionResult { fail, success, perfect }

class BattleReactionDialog extends StatefulWidget {
  const BattleReactionDialog({super.key});

  @override
  State<BattleReactionDialog> createState() => _BattleReactionDialogState();
}

class _BattleReactionDialogState extends State<BattleReactionDialog> {
  SliderController controller = SliderController(
    successStart: 30,
    successEnd: 70,
    perfectStart: 45,
    perfectEnd: 55,
  );

  BattleReactionResult? result;

  int successStart = 30;
  int successEnd = 70;
  int perfectStart = 45;
  int perfectEnd = 55;

  Duration timeToRespond = Duration(seconds: 3);

  int points = 0;

  bool preparing = true;

  @override
  void didChangeDependencies() {
    points = points + Battle.of(context).currentRally;

    BattleCard attackingCard = Battle.of(context).isPlayer1Rallying
        ? Decks.of(context).player2.hero!
        : Decks.of(context).player1.hero!;

    BattleCard defendingCard = Battle.of(context).isPlayer1Rallying
        ? Decks.of(context).player2.hero!
        : Decks.of(context).player1.hero!;

    // Use attacking card power to decrease the time to respond
    timeToRespond = timeToRespond -
        Duration(milliseconds: attackingCard.stats["power"]!.toInt() * 100);

    // Use defending card speed to slow down the reaction speed and increase the time to respond
    timeToRespond = timeToRespond +
        Duration(milliseconds: defendingCard.stats["speed"]!.toInt() * 100);

    controller.setSpeed(
        Duration(milliseconds: 16 + defendingCard.stats["speed"]!.toInt()));

    // Use the power of the attacking card to determine the success and perfect range
    // Higher power makes the success range smaller
    int powerFactor = attackingCard.stats["power"]!.toInt();
    successStart = 30 + powerFactor;
    successEnd = 70 - powerFactor;

    // Perfect range is always centered within success range
    int perfectWidth = 10;
    perfectStart = ((successStart + successEnd) ~/ 2) - (perfectWidth ~/ 2);
    perfectEnd = perfectStart + perfectWidth;

    controller = SliderController(
      successStart: successStart,
      successEnd: successEnd,
      perfectStart: perfectStart,
      perfectEnd: perfectEnd,
    );

    super.didChangeDependencies();
  }

  String _getPreparingText() {
    BattleData battle = Battle.of(context);
    Decks decks = Decks.of(context);

    BattleCard card =
        battle.isPlayer1Rallying ? decks.player1.hero! : decks.player2.hero!;

    String playerName = battle.isPlayer1Rallying ? "Player 1" : "Player 2";

    return "$playerName get ready to react! You have ${card.stats['stamina']} stamina remaining. Continuing will cost 5 stamina.";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.stop();
        if (controller.isPerfect) {
          setState(() {
            result = BattleReactionResult.perfect;
          });
        } else if (controller.isSuccess) {
          setState(() {
            result = BattleReactionResult.success;
          });
        } else {
          setState(() {
            result = BattleReactionResult.fail;
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Battle.of(context).isPlayer1Rallying
                  ? Decks.of(context).player1.color
                  : Decks.of(context).player2.color,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Battle.of(context).isPlayer1Rallying
                  ? Decks.of(context).player1.color
                  : Decks.of(context).player2.color,
            ],
          ),
        ),
        child: Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(),
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 320),
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16.0,
                children: result != null || preparing
                    ? (preparing
                        ? [
                            Text(
                              "Get ready!",
                              style: SquashboundTheme.textTheme.titleLarge,
                            ),
                            Text(
                              _getPreparingText(),
                              style: SquashboundTheme.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              spacing: 8.0,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(BattleReactionResult.fail);
                                  },
                                  child: Text(
                                    "Concede",
                                    style:
                                        SquashboundTheme.textTheme.bodyMedium,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      preparing = false;
                                    });
                                  },
                                  child: Text(
                                    "Continue",
                                    style:
                                        SquashboundTheme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ]
                        : [
                            Text(
                              result == BattleReactionResult.perfect
                                  ? "Perfect!"
                                  : result == BattleReactionResult.success
                                      ? "Success!"
                                      : "Too slow!",
                              style: SquashboundTheme.textTheme.titleLarge,
                            ),
                            Text(
                              result == BattleReactionResult.perfect ||
                                      result == BattleReactionResult.success
                                  ? "Spot on!"
                                  : "Too slow! ${Battle.of(context).isPlayer1Rallying ? "Player 2 +$points point${points > 1 ? 's' : ''}!" : "Player 1 +$points point${points > 1 ? 's' : ''}!"}",
                              style: SquashboundTheme.textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(result);
                              },
                              child: Text(
                                "Continue",
                                style: SquashboundTheme.textTheme.bodyMedium,
                              ),
                            ),
                          ])
                    : [
                        Text(
                          "Player ${Battle.of(context).isPlayer1Rallying ? 1 : 2}",
                          style: SquashboundTheme.textTheme.titleLarge,
                        ),
                        Text("Tap to react!"),
                        TweenAnimationBuilder<double>(
                          onEnd: () {
                            setState(() {
                              result = BattleReactionResult.fail;
                            });
                          },
                          duration: timeToRespond,
                          tween: Tween(begin: 1.0, end: 0.0),
                          builder: (context, value, _) =>
                              LinearProgressIndicator(
                            value: value,
                            backgroundColor: SquashboundTheme.cardColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Battle.of(context).isPlayer1Rallying
                                  ? Decks.of(context).player1.color
                                  : Decks.of(context).player2.color,
                            ),
                          ),
                        ),
                        BattleReactionSlider(
                          controller: controller,
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SliderController {
  Timer? _timer;
  double _value = 0;
  bool _increasing = true;
  Duration _speed = Duration(milliseconds: 16);

  final int successStart;
  final int successEnd;
  final int perfectStart;
  final int perfectEnd;

  SliderController({
    required this.successStart,
    required this.successEnd,
    required this.perfectStart,
    required this.perfectEnd,
  }) {
    // Start at a random position
    _value = Random().nextInt(100).toDouble();
  }

  Function(double)? onValueChanged;

  void start() {
    _timer = Timer.periodic(_speed, (timer) {
      if (_increasing) {
        _value += 2;
        if (_value >= 100) {
          _increasing = false;
        }
      } else {
        _value -= 2;
        if (_value <= 0) {
          _increasing = true;
        }
      }
      onValueChanged?.call(_value);
    });
  }

  void setSpeed(Duration speed) {
    _speed = speed;
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  double get value => _value;

  bool get isPerfect => value >= perfectStart && value <= perfectEnd;

  bool get isSuccess => value >= successStart && value <= successEnd;
}

class BattleReactionSlider extends StatefulWidget {
  final SliderController controller;

  const BattleReactionSlider({
    super.key,
    required this.controller,
  });

  @override
  State<BattleReactionSlider> createState() => _BattleReactionSliderState();
}

class _BattleReactionSliderState extends State<BattleReactionSlider> {
  double _sliderValue = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.onValueChanged = (value) {
      setState(() {
        _sliderValue = value;
      });
    };
    widget.controller.start();
  }

  @override
  void dispose() {
    widget.controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: CustomPaint(
        painter: ReactionPainter(
          successStart: widget.controller.successStart,
          successEnd: widget.controller.successEnd,
          perfectStart: widget.controller.perfectStart,
          perfectEnd: widget.controller.perfectEnd,
          indicator: _sliderValue,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class ReactionPainter extends CustomPainter {
  final int successStart;
  final int successEnd;
  final int perfectStart;
  final int perfectEnd;
  final double indicator;

  ReactionPainter({
    required this.successStart,
    required this.successEnd,
    required this.perfectStart,
    required this.perfectEnd,
    required this.indicator,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    final backgroundPaint = Paint()
      ..color = SquashboundTheme.cardColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Success range
    final successPaint = Paint()
      ..color = SquashboundTheme.foregroundColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(size.width * successStart / 100, 0,
            size.width * (successEnd - successStart) / 100, size.height),
        successPaint);

    // Perfect range
    final perfectPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(size.width * perfectStart / 100, 0,
            size.width * (perfectEnd - perfectStart) / 100, size.height),
        perfectPaint);

    // Indicator
    final indicatorPaint = Paint()
      ..color = SquashboundTheme.primaryColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTWH(size.width * indicator / 100 - 2, 0, 4, size.height),
        indicatorPaint);
  }

  @override
  bool shouldRepaint(ReactionPainter oldDelegate) {
    return oldDelegate.indicator != indicator;
  }
}
