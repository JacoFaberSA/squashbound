import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/model/battle_card.dart';

class WarlockHeroCard extends BattleCard {
  @override
  final Map<String, double> stats;
  @override
  final List<String> modifications;
  @override
  final Map<String, dynamic> additionalData;

  WarlockHeroCard({
    this.stats = const {"power": 9, "stamina": 75, "speed": 3},
    this.modifications = const [],
    this.additionalData = const {
      'skill_active': false,
    },
  }) : super(
          name: "Warlock",
          description: "",
          artwork: "https://djg6cmln9rw68.cloudfront.net/warlock.png",
          skillName: "Soul Tether",
          skillDescription:
              "Soul Tether restores 10 stamina for every successfully volley.",
          skillStaminaCostPerTurn: 8,
          isHero: true,
        );

  @override
  WarlockHeroCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  }) {
    return WarlockHeroCard(
      stats: stats ?? this.stats,
      modifications: modifications ?? this.modifications,
      additionalData: additionalData ?? this.additionalData,
    );
  }

  @override
  void onRallySuccess(SelectionData deck, BattleData battle, Decks decks) {
    if (isSkillActive) {
      deck.setHero(copyWith(
        stats: Map.from(stats)..update("stamina", (value) => value + 10),
        modifications: List.from(modifications)..add("Soul Tether: +10 Speed"),
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
