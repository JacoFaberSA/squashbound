import 'package:flutter/material.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/screens/battle/selection.dart';
import 'package:squashbound/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          padding: EdgeInsets.all(32.0),
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Squashbound',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionScreen(
                        deck: Decks.of(context).player1,
                        nextDeck: Decks.of(context).player2,
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.bottomLeft,
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: SquashboundTheme.primaryColor,
                    borderRadius: BorderRadius.circular(
                        SquashboundTheme.borderRadiusLarge),
                    border: Border.fromBorderSide(
                      SquashboundTheme.roundedRectangleBorder(radius: 0).side,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    spacing: 16.0,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.stadium_rounded, size: 48.0),
                      Text(
                        'Battle',
                        style:
                            SquashboundTheme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
