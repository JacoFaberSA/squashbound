import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class BardHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  BardHeroCard({
    this.stats = const {"power": 5, "stamina": 75, "speed": 6},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Bard",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/bard.png",
          skillName: "Inspiring Tune",
          skillDescription:
              "Inspiring Tune grants 1 additional Speed and Power every time a perfect volley is made.",
          skillStaminaCostPerTurn: 6,
          isHero: true,
        );

  @override
  BardHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return BardHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyPerfect(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(
        copyWith(
          stats: Map.from(stats)
            ..updateAll((key, value) {
              switch (key) {
                case "speed":
                  return value + 1;
                case "power":
                  return value + 1;
                default:
                  return value;
              }
            }),
          modifications: List.from(modifications)
            ..addAll([
              "Inspiring Tune: +1 Speed, +1 Power",
            ]),
        ),
      );
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
