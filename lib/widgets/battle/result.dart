import 'package:flutter/material.dart';
import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/theme.dart';

class BattleResultDialog extends StatefulWidget {
  const BattleResultDialog({super.key});

  @override
  State<BattleResultDialog> createState() => _BattleResultDialogState();
}

class _BattleResultDialogState extends State<BattleResultDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Battle.of(context).isPlayer1Winner
                ? Decks.of(context).player1.color
                : Decks.of(context).player2.color,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent,
            Battle.of(context).isPlayer1Winner
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
              children: [
                Text(
                  Battle.of(context).isPlayer1Winner
                      ? "Player 1 Wins!"
                      : "Player 2 Wins!",
                  textAlign: TextAlign.center,
                  style: SquashboundTheme.textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Exit",
                    style: SquashboundTheme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
