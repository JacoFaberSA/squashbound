import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class RangerHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  RangerHeroCard({
    this.stats = const {"power": 6, "stamina": 80, "speed": 9},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Ranger",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/ranger.png",
          skillName: "Hunter's Precision",
          skillDescription:
              "Hunter's Precision doubles speed for the first volley.",
          skillStaminaCostPerTurn: 7,
          isHero: true,
        );

  @override
  RangerHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return RangerHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyEnd(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      onDeactivateSkill(deck, battle, decks);
    }
  }

  @override
  void onActivateSkill(SelectionData deck, BattleData battle, Decks decks) {
    deck.setHero(copyWith(
      additionalData: Map.from(additionalData)
        ..update("skill_active", (value) => true),
    ));

    if (!additionalData.containsKey("skill_adjustment")) {
      double speed = deck.hero!.stats["speed"]!;
      deck.setHero(deck.hero!.copyWith(
        stats: Map.from(deck.hero!.stats)
          ..update("speed", (value) => value + speed),
        additionalData: Map.from(deck.hero!.additionalData)
          ..addAll({
            "skill_adjustment": speed,
          }),
      ));
    }
  }

  @override
  void onDeactivateSkill(SelectionData deck, BattleData battle, Decks decks) {
    deck.setHero(copyWith(
      additionalData: Map.from(additionalData)
        ..update("skill_active", (value) => false),
    ));

    double? speed = deck.hero!.additionalData["skill_adjustment"];
    if (speed != null) {
      deck.setHero(copyWith(
        stats: Map.from(deck.hero!.stats)
          ..update("speed", (value) => value - speed),
        additionalData: Map.from(deck.hero!.additionalData)
          ..remove("skill_adjustment"),
      ));
    }
  }
}
