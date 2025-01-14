import 'package:flutter/material.dart';
import 'package:squashbound/model/battle_card.dart';
import 'package:squashbound/widgets/cards/card.dart';

class BattleDefendingCardWidget extends StatelessWidget {
  const BattleDefendingCardWidget({super.key, required this.card, this.color});

  final BattleCard card;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(-0.1)
        ..rotateY(0.5),
      alignment: Alignment.center,
      child: Transform.scale(
        scale: 0.8,
        child: SizedBox(
          width: 250,
          height: 310,
          child: CardWidget(
            card: card,
            selectionColor: color,
          ),
        ),
      ),
    );
  }
}
