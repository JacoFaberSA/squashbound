import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';

abstract class BattleCard {
  final String name;
  final String description;
  final String artwork;

  final String? skillName;
  final String? skillDescription;
  final int? skillStaminaCostPerTurn;

  final bool isHero;
  final bool isArtifact;

  final Map<String, double> stats;
  final List<String> modifications;
  final Map<String, dynamic> additionalData;

  BattleCard({
    required this.name,
    required this.description,
    required this.artwork,
    this.skillName,
    this.skillDescription,
    this.skillStaminaCostPerTurn,
    this.isHero = false,
    this.isArtifact = false,
    this.stats = const {},
    this.modifications = const [],
    this.additionalData = const {},
  });

  BattleCard copyWith({
    Map<String, double>? stats,
    List<String>? modifications,
    Map<String, dynamic>? additionalData,
  });

  /// Called when the card is played
  void onPlayed(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called at the start of every turn
  void onTurnStart(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called at the end of every turn
  void onTurnEnd(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called before every rally
  void onRallyStart(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called if a rally was perfect
  void onRallyPerfect(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called if a rally was successful
  void onRallySuccess(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called if a rally failed
  void onRallyFail(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called after every rally
  void onRallyEnd(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called when the card is trashed
  void onTrashed(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called when an attack is initiated
  void onAttack(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called when an attack is initiated against this hero
  void onAttacked(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called when the skill of the card is activated
  void onActivateSkill(SelectionData deck, BattleData battle, Decks decks) {}

  /// Called when the skill of the card is deactivated
  void onDeactivateSkill(SelectionData deck, BattleData battle, Decks decks) {}

  bool get isSkillActive => additionalData['skill_active'] == true;
}
