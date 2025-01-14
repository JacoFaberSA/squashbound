import 'package:flutter/material.dart';
import 'package:squashbound/model/battle_card.dart';
import 'package:squashbound/theme.dart';

class Decks extends InheritedWidget {
  Decks({
    super.key,
    required super.child,
  });

  final SelectionData _player1 = SelectionData(
    name: "Player 1",
    color: SquashboundTheme.primaryColor,
  );
  final SelectionData _player2 = SelectionData(
    name: "Player 2",
    color: SquashboundTheme.secondaryColor,
  );

  SelectionData get player1 => _player1;
  SelectionData get player2 => _player2;

  void reset() {
    _player1.clear();
    _player2.clear();
  }

  static Decks of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Decks>()!;
  }

  @override
  bool updateShouldNotify(covariant Decks oldWidget) {
    return _player1 != oldWidget._player1 || _player2 != oldWidget._player2;
  }
}

class SelectionData extends ChangeNotifier {
  final String name;
  final Color color;

  SelectionData({
    required this.name,
    required this.color,
  });

  BattleCard? _hero;
  final Set<BattleCard> _artifacts = {};

  BattleCard? get hero => _hero;

  void setHero(BattleCard card) {
    _hero = card;
    notifyListeners();
  }

  void addArtifact(BattleCard card) {
    _artifacts.add(card);
    notifyListeners();
  }

  void removeArtifact(BattleCard card) {
    _artifacts.remove(card);
    notifyListeners();
  }

  Set<BattleCard> get artifacts => _artifacts;

  void clear() {
    _hero = null;
    _artifacts.clear();
    notifyListeners();
  }

  bool get isReady => _hero != null;
}
