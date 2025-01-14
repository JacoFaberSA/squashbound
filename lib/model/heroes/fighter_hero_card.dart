import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class FighterHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  FighterHeroCard({
    this.stats = const {"power": 7, "stamina": 85, "speed": 5},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Fighter",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/fighter.png",
          skillName: "Battle Resolve",
          skillDescription:
              "After losing a point, the Battle Resolve increases all stats by 1.",
          skillStaminaCostPerTurn: 9,
          isHero: true,
        );

  @override
  FighterHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return FighterHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyFail(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)..updateAll((key, value) => value + 1),
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
