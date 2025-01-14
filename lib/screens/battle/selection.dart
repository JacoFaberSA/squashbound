import 'package:flutter/material.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';
import 'package:squashbound/model/heroes/barbarian_hero_card.dart';
import 'package:squashbound/model/heroes/bard_hero_card.dart';
import 'package:squashbound/model/heroes/cleric_hero_card.dart';
import 'package:squashbound/model/heroes/druid_hero_card.dart';
import 'package:squashbound/model/heroes/fighter_hero_card.dart';
import 'package:squashbound/model/heroes/monk_hero_card.dart';
import 'package:squashbound/model/heroes/paladin_hero_card.dart';
import 'package:squashbound/model/heroes/ranger_hero_card.dart';
import 'package:squashbound/model/heroes/rogue_hero_card.dart';
import 'package:squashbound/model/heroes/sorcerer_hero_card.dart';
import 'package:squashbound/model/heroes/warlock_hero_card.dart';
import 'package:squashbound/model/heroes/wizard_hero_card.dart';
import 'package:squashbound/screens/battle/coin.dart';
import 'package:squashbound/screens/home.dart';
import 'package:squashbound/widgets/cards/card.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({
    super.key,
    required this.deck,
    this.nextDeck,
    this.previousDeck,
  });

  final SelectionData deck;
  final SelectionData? nextDeck;
  final SelectionData? previousDeck;

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  List<BattleCard> heroCards = [
    BarbarianHeroCard(),
    BardHeroCard(),
    ClericHeroCard(),
    DruidHeroCard(),
    FighterHeroCard(),
    MonkHeroCard(),
    PaladinHeroCard(),
    RangerHeroCard(),
    RogueHeroCard(),
    SorcererHeroCard(),
    WarlockHeroCard(),
    WizardHeroCard()
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.deck,
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.previousDeck == null)
                TextButton(
                  onPressed: () {
                    Decks.of(context).reset();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Text("Exit"),
                ),
              if (widget.previousDeck != null)
                TextButton(
                  onPressed: () {
                    if (widget.previousDeck != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectionScreen(
                            deck: widget.previousDeck!,
                            nextDeck: widget.deck,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Back"),
                ),
              if (widget.deck.isReady)
                ElevatedButton(
                  onPressed: () {
                    if (widget.nextDeck != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectionScreen(
                            deck: widget.nextDeck!,
                            previousDeck: widget.deck,
                          ),
                        ),
                      );
                    } else if (widget.nextDeck == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoinScreen(),
                        ),
                      );
                    }
                  },
                  child: Text(widget.nextDeck == null ? "To Battle!" : "Next"),
                )
            ],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
                padding: EdgeInsets.all(32.0),
                child: Column(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.deck.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      'Select your hero',
                    ),
                    Wrap(
                      spacing: 24.0,
                      runSpacing: 24.0,
                      children: [
                        for (var heroCard in heroCards)
                          CardWidget(
                            selected: widget.deck.hero != null &&
                                widget.deck.hero?.name == heroCard.name,
                            card: heroCard,
                            selectionColor: widget.deck.color,
                            onSelected: (card) {
                              widget.deck.setHero(card);
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
