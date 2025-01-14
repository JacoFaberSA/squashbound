import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class PaladinHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  PaladinHeroCard({
    this.stats = const {"power": 7, "stamina": 85, "speed": 4},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Paladin",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/paladin.png",
          skillName: "Holy Presence",
          skillDescription:
              "Holy Presence reduces the opponent's Power stat by 50%.",
          skillStaminaCostPerTurn: 8,
          isHero: true,
        );

  @override
  PaladinHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return PaladinHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onActivateSkill(SelectionData deck, BattleData battle, Decks decks) {
    double adjustment = decks.player2.hero!.stats["power"] ?? 0;
    adjustment = (adjustment * .50).floorToDouble();

    deck.setHero(copyWith(
      additionalData: {'skill_active': true, 'skill_adjustment': adjustment},
    ));

    if (deck.name == "Player 1") {
      decks.player2.setHero(
        decks.player2.hero!.copyWith(
            stats: Map.from(decks.player2.hero!.stats)
              ..update("power", (value) => value - adjustment),
            modifications: List.from(decks.player2.hero!.modifications)
              ..add("Holy Presence: -$adjustment power")),
      );
    } else {
      decks.player1.setHero(
        decks.player1.hero!.copyWith(
            stats: Map.from(decks.player1.hero!.stats)
              ..update("power", (value) => value - adjustment),
            modifications: List.from(decks.player1.hero!.modifications)
              ..add("Holy Presence: -$adjustment power")),
      );
    }
  }

  @override
  void onDeactivateSkill(SelectionData deck, BattleData battle, Decks decks) {
    double adjustment = additionalData["skill_adjustment"] ?? 0;
    if (deck.name == "Player 1") {
      decks.player2.setHero(
        decks.player2.hero!.copyWith(
            stats: Map.from(decks.player2.hero!.stats)
              ..update("power", (value) => value + adjustment),
            modifications: List.from(decks.player2.hero!.modifications)
              ..remove("Holy Presence: -$adjustment power")),
      );
    } else {
      decks.player1.setHero(
        decks.player1.hero!.copyWith(
            stats: Map.from(decks.player1.hero!.stats)
              ..update("power", (value) => value + adjustment),
            modifications: List.from(decks.player1.hero!.modifications)
              ..remove("Holy Presence: -$adjustment power")),
      );
    }

    deck.setHero(copyWith(
      additionalData: Map.from(additionalData)
        ..update("skill_active", (value) => false)
        ..remove("skill_adjustment"),
    ));
  }
}
