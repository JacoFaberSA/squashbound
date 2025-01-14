import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class BarbarianHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  BarbarianHeroCard({
    this.stats = const {"power": 9, "stamina": 90, "speed": 3},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Barbarian",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/barbarian.png",
          skillName: "Raging Smash",
          skillDescription:
              "Raging Smash increases Power by 2 if a volley is successful.",
          skillStaminaCostPerTurn: 10,
          isHero: true,
        );

  @override
  BarbarianHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return BarbarianHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyPerfect(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)..update("power", (value) => value + 2),
        modifications: List.from(modifications)..add("Raging Smash: +2 Power"),
      ));
    }
  }

  @override
  void onRallySuccess(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)..update("power", (value) => value + 2),
        modifications: List.from(modifications)..add("Raging Smash: +2 Power"),
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
