import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class MonkHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  MonkHeroCard({
    this.stats = const {"power": 6, "stamina": 80, "speed": 8},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Monk",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/monk.png",
          skillName: "Zen Focus",
          skillDescription:
              "While using Zen Focus volleys do not consume stamina.",
          skillStaminaCostPerTurn: 6,
          isHero: true,
        );

  @override
  MonkHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return MonkHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallyStart(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)
          ..update("stamina",
              (value) => value + 5), // Refund 5 stamina for the volley
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
