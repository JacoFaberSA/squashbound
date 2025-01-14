import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class SorcererHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  SorcererHeroCard({
    this.stats = const {"power": 8, "stamina": 75, "speed": 5},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Sorcerer",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/sorcerer.png",
          skillName: "Arcane Surge",
          skillDescription:
              "For every perfect volley Arcane Surge restores 5 stamina and increases Speed by 1.",
          skillStaminaCostPerTurn: 9,
          isHero: true,
        );

  @override
  SorcererHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return SorcererHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyPerfect(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)
          ..updateAll((key, value) {
            switch (key) {
              case "stamina":
                return value + 5;
              case "speed":
                return value + 1;
              default:
                return value;
            }
          }),
        modifications: List.from(modifications)
          ..add("Arcane Surge: +5 Stamina, +1 Speed"),
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
