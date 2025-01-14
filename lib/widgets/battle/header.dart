import 'package:flutter/material.dart';
import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/theme.dart';

class BattleHeaderWidget extends StatelessWidget {
  const BattleHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 650;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Squashbound',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Row(
          spacing: 8.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8.0,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Decks.of(context).player1.color,
                  ),
                  child: Center(
                    child: Text(
                      '${Battle.of(context).player1Score}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                Text(
                  'Player 1',
                  style: isMobile
                      ? SquashboundTheme.textTheme.bodySmall
                      : SquashboundTheme.textTheme.bodyMedium,
                ),
              ],
            ),
            Text(
              'Turn ${Battle.of(context).currentTurn}: ${Battle.of(context).isPlayer1Turn ? 'Player 1' : 'Player 2'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Row(
              spacing: 8.0,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Player 2',
                  style: isMobile
                      ? SquashboundTheme.textTheme.bodySmall
                      : SquashboundTheme.textTheme.bodyMedium,
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Decks.of(context).player2.color,
                  ),
                  child: Center(
                    child: Text(
                      '${Battle.of(context).player2Score}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: SquashboundTheme.backgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
