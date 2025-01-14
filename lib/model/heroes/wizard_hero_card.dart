import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class WizardHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  WizardHeroCard({
    this.stats = const {"power": 6, "stamina": 70, "speed": 7},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Wizard",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/wizard.png",
          skillName: "Arcane Focus",
          skillDescription:
              "Perfect volleys reduce the opponents stamina by 10 and increases Speed by 1.",
          skillStaminaCostPerTurn: 7,
          isHero: true,
        );

  @override
  WizardHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return WizardHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyPerfect(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      if (deck.name == "Player 1") {
        decks.player2.setHero(
          decks.player2.hero!.copyWith(
              stats: Map.from(decks.player2.hero!.stats)
                ..update("stamina", (value) => value - 10),
              modifications: List.from(decks.player2.hero!.modifications)
                ..add("Arcane Focus: -10 Stamina")),
        );
      } else {
        decks.player1.setHero(
          decks.player1.hero!.copyWith(
              stats: Map.from(decks.player1.hero!.stats)
                ..update("stamina", (value) => value - 10),
              modifications: List.from(decks.player2.hero!.modifications)
                ..add("Arcane Focus: -10 Stamina")),
        );
      }

      deck.setHero(copyWith(
        stats: Map.from(stats)..update("speed", (value) => value + 1),
        modifications: List.from(modifications)..add("Arcane Focus: +1 Speed"),
      ));
    }
  }

  @override
  void onActivateSkill(SelectionData deck, BattleData battle, Decks decks) {
    deck.setHero(copyWith(
      additionalData: Map.from(additionalData)
        ..update("skill_active", (value) => true),
    ));
  }

  @override
  void onDeactivateSkill(SelectionData deck, BattleData battle, Decks decks) {
    deck.setHero(copyWith(
      additionalData: Map.from(additionalData)
        ..update("skill_active", (value) => false),
    ));
  }
}
