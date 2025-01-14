import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class RogueHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  RogueHeroCard({
    this.stats = const {"power": 5, "stamina": 70, "speed": 10},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Rogue",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/rogue.png",
          skillName: "Sudden Strike",
          skillDescription:
              "Sudden Strike increases Power x2 for every perfect volley.",
          skillStaminaCostPerTurn: 8,
          isHero: true,
        );

  @override
  RogueHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return RogueHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyPerfect(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)..update("power", (value) => value * 2),
        modifications: List.from(modifications)..add("Sudden Strike: Power x2"),
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
