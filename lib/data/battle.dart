import 'package:flutter/material.dart';

class Battle extends InheritedWidget {
  Battle({
    super.key,
    required super.child,
  });

  final BattleData _battle = BattleData();

  BattleData get battle => _battle;

  static BattleData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Battle>()!._battle;
  }

  @override
  bool updateShouldNotify(covariant Battle oldWidget) {
    return _battle != oldWidget._battle;
  }
}

class BattleData extends ChangeNotifier {
  int _turn = 1;
  int? _playerTurn;

  int? _rally;
  int? _playerRallying;

  double _player1Score = 0;
  double _player2Score = 0;

  int get currentTurn => _turn;
  bool get isPlayer1Turn => _playerTurn == 1;
  bool get isPlayer2Turn => _playerTurn == 2;
  bool get isRallying => _rally != null;
  int get currentRally => _rally ?? 0;
  bool get isPlayer1Rallying => _playerRallying == 1;
  bool get isPlayer2Rallying => _playerRallying == 2;

  bool get isPlayer1Winner =>
      _player1Score > _player2Score || _player1Score >= 11;
  bool get isPlayer2Winner =>
      _player2Score > _player1Score || _player2Score >= 11;

  double get player1Score => _player1Score;
  double get player2Score => _player2Score;

  void nextTurn({int? playerTurn}) {
    if (_playerTurn == null || playerTurn != null) {
      _turn = 1;
      _playerTurn = playerTurn ?? 1;
      _rally = null;
      _playerRallying = null;
      notifyListeners();
      return;
    }

    _turn++;
    _playerTurn = _playerTurn == 1 ? 2 : 1;
    _rally = null;
    _playerRallying = null;
    notifyListeners();
  }

  void nextRally() {
    if (_playerTurn != null) {
      if (_rally == null) {
        _rally = 1;
        _playerRallying = _playerTurn == 1 ? 2 : 1;
        notifyListeners();
        return;
      }

      _rally = _rally! + 1;
      _playerRallying = _playerRallying == 1 ? 2 : 1;
    }
  }

  void addScore(double score, int player) {
    if (player == 1) {
      _player1Score += score;
    } else if (player == 2) {
      _player2Score += score;
    }
    _rally = null;
    _playerRallying = null;
    notifyListeners();
  }

  void reset() {
    _turn = 1;
    _playerTurn = null;
    _rally = null;
    _playerRallying = null;
    _player1Score = 0;
    _player2Score = 0;
    notifyListeners();
  }
}
