import 'package:flutter/material.dart';
import 'package:squashbound/data/battle.dart';
import 'package:squashbound/data/decks.dart';
import 'package:squashbound/screens/home.dart';
import 'package:squashbound/widgets/battle/defending_card.dart';
import 'package:squashbound/widgets/battle/header.dart';
import 'package:squashbound/widgets/battle/attacking_card.dart';
import 'package:squashbound/widgets/battle/reaction.dart';
import 'package:squashbound/widgets/battle/result.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (Battle.of(context).currentTurn == 1 &&
        Battle.of(context).isPlayer1Turn) {
      Decks.of(context).player1.hero?.onTurnStart(
          Decks.of(context).player1, Battle.of(context), Decks.of(context));
    } else {
      Decks.of(context).player2.hero?.onTurnStart(
          Decks.of(context).player2, Battle.of(context), Decks.of(context));
    }
  }

  void handleGameOver() async {
    await showDialog(
      context: context,
      builder: (context) {
        return BattleResultDialog();
      },
      barrierDismissible: false,
    );
    if (mounted) {
      Battle.of(context).reset();
      Decks.of(context).reset();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  void handleFail() {
    if (Battle.of(context).isPlayer1Rallying) {
      Decks.of(context).player1.hero!.onRallyFail(
          Decks.of(context).player1, Battle.of(context), Decks.of(context));
    } else {
      Decks.of(context).player2.hero!.onRallyFail(
          Decks.of(context).player2, Battle.of(context), Decks.of(context));
    }

    Battle.of(context).addScore(
      Battle.of(context).currentRally.toDouble(),
      Battle.of(context).isPlayer1Rallying ? 2 : 1,
    );

    if (Battle.of(context).isPlayer1Rallying) {
      Decks.of(context).player1.hero?.onRallyEnd(
          Decks.of(context).player1, Battle.of(context), Decks.of(context));
    } else {
      Decks.of(context).player2.hero?.onRallyEnd(
          Decks.of(context).player2, Battle.of(context), Decks.of(context));
    }

    // Consume skill cost if active
    if (Battle.of(context).isPlayer1Turn) {
      if (Decks.of(context).player1.hero!.isSkillActive) {
        Decks.of(context).player1.setHero(
              Decks.of(context).player1.hero!.copyWith(
                    stats: Map.from(Decks.of(context).player1.hero!.stats)
                      ..update(
                          "stamina",
                          (value) =>
                              value -
                              (Decks.of(context)
                                      .player1
                                      .hero!
                                      .skillStaminaCostPerTurn ??
                                  0)),
                  ),
            );
      }
    } else {
      if (Decks.of(context).player2.hero!.isSkillActive) {
        Decks.of(context).player2.setHero(
              Decks.of(context).player2.hero!.copyWith(
                    stats: Map.from(Decks.of(context).player2.hero!.stats)
                      ..update(
                          "stamina",
                          (value) =>
                              value -
                              (Decks.of(context)
                                      .player1
                                      .hero!
                                      .skillStaminaCostPerTurn ??
                                  0)),
                  ),
            );
      }
    }

    if (Battle.of(context).isPlayer1Turn) {
      Decks.of(context).player1.hero?.onTurnEnd(
          Decks.of(context).player1, Battle.of(context), Decks.of(context));
    } else {
      Decks.of(context).player2.hero?.onTurnEnd(
          Decks.of(context).player2, Battle.of(context), Decks.of(context));
    }

    Battle.of(context).nextTurn();

    if (Battle.of(context).isPlayer1Turn) {
      Decks.of(context).player1.hero?.onTurnStart(
          Decks.of(context).player1, Battle.of(context), Decks.of(context));
    } else {
      Decks.of(context).player2.hero?.onTurnStart(
          Decks.of(context).player2, Battle.of(context), Decks.of(context));
    }

    // If either of the player scores hit 11 end the game
    if (Battle.of(context).player1Score >= 11 ||
        Battle.of(context).player2Score >= 11) {
      handleGameOver();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 650;

    void handleAttack() async {
      BattleData battle = Battle.of(context);
      Decks decks = Decks.of(context);

      // If the attacking player has less than 5 stamina, they fail instantly
      if (battle.isPlayer1Turn
          ? decks.player1.hero!.stats["stamina"]! < 5
          : decks.player2.hero!.stats["stamina"]! < 5) {
        handleGameOver();
        return;
      }

      if (battle.currentRally == 1) {
        if (battle.isPlayer1Turn) {
          decks.player1.hero?.onAttack(decks.player1, battle, decks);
          decks.player2.hero?.onAttacked(decks.player2, battle, decks);
        } else {
          decks.player2.hero?.onAttack(decks.player2, battle, decks);
          decks.player1.hero?.onAttacked(decks.player1, battle, decks);
        }
      }

      battle.nextRally();

      if (battle.isPlayer1Rallying) {
        decks.player1.hero?.onRallyStart(decks.player1, battle, decks);
      } else {
        decks.player2.hero?.onRallyStart(decks.player2, battle, decks);
      }

      BattleReactionResult? result = await showDialog<BattleReactionResult?>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BattleReactionDialog();
        },
      );

      if (result != null) {
        if (battle.isPlayer1Rallying) {
          decks.player1.setHero(
            decks.player1.hero!.copyWith(
              stats: Map.from(decks.player1.hero!.stats)
                ..update("stamina", (value) => value - 5),
            ),
          );
        } else {
          decks.player2.setHero(
            decks.player2.hero!.copyWith(
              stats: Map.from(decks.player2.hero!.stats)
                ..update("stamina", (value) => value - 5),
            ),
          );
        }
      }

      if (result == null || result == BattleReactionResult.fail) {
        handleFail();
      }

      if (result == BattleReactionResult.perfect) {
        if (battle.isPlayer1Rallying) {
          decks.player1.hero?.onRallyPerfect(decks.player1, battle, decks);
        } else {
          decks.player2.hero?.onRallyPerfect(decks.player2, battle, decks);
        }
      }

      if (result == BattleReactionResult.success) {
        if (battle.isPlayer1Rallying) {
          decks.player1.hero?.onRallySuccess(decks.player1, battle, decks);
        } else {
          decks.player2.hero?.onRallySuccess(decks.player2, battle, decks);
        }
      }

      if (result == BattleReactionResult.perfect ||
          result == BattleReactionResult.success) {
        handleAttack();
      }
    }

    return AnimatedBuilder(
      animation: Listenable.merge([
        Battle.of(context),
        Decks.of(context).player1,
        Decks.of(context).player2,
      ]),
      builder: (context, child) {
        return Scaffold(
          floatingActionButton: TextButton(
            onPressed: () async {
              bool? confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Exit"),
                    content: Text("Are you sure you want to exit?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text("No"),
                      ),
                    ],
                  );
                },
              );

              if ((confirm ?? false) && context.mounted) {
                Battle.of(context).reset();
                Decks.of(context).reset();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }
            },
            child: Text("Exit"),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Battle.of(context).isPlayer1Turn
                      ? Decks.of(context).player1.color
                      : Decks.of(context).player2.color,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Battle.of(context).isPlayer1Turn
                      ? Decks.of(context).player1.color
                      : Decks.of(context).player2.color,
                ],
              ),
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
                color: Colors.transparent,
                padding: EdgeInsets.all(32.0),
                child: Column(
                  spacing: 16.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BattleHeaderWidget(),
                    if (!isMobile) SizedBox(height: 32.0),
                    Flex(
                      direction: Axis.horizontal,
                      spacing: 16.0,
                      children: [
                        if (!isMobile)
                          Flexible(
                            flex: 1,
                            child: BattleDefendingCardWidget(
                              card: Battle.of(context).isPlayer1Turn
                                  ? Decks.of(context).player2.hero!
                                  : Decks.of(context).player1.hero!,
                              color: Battle.of(context).isPlayer1Turn
                                  ? Decks.of(context).player2.color
                                  : Decks.of(context).player1.color,
                            ),
                          ),
                        if (!isMobile)
                          SizedBox(
                            width: 16.0,
                          ),
                        Flexible(
                          flex: 2,
                          child: BattleAttackingCardWidget(
                            card: Battle.of(context).isPlayer1Turn
                                ? Decks.of(context).player1.hero!
                                : Decks.of(context).player2.hero!,
                            color: Battle.of(context).isPlayer1Turn
                                ? Decks.of(context).player1.color
                                : Decks.of(context).player2.color,
                            onAttack: () async {
                              handleAttack();
                            },
                            onActivateSkill: () {
                              if (Battle.of(context).isPlayer1Turn) {
                                Decks.of(context).player1.hero?.onActivateSkill(
                                    Decks.of(context).player1,
                                    Battle.of(context),
                                    Decks.of(context));
                              } else {
                                Decks.of(context).player2.hero?.onActivateSkill(
                                    Decks.of(context).player2,
                                    Battle.of(context),
                                    Decks.of(context));
                              }
                            },
                            onDeactivateSkill: () {
                              if (Battle.of(context).isPlayer1Turn) {
                                Decks.of(context)
                                    .player1
                                    .hero
                                    ?.onDeactivateSkill(
                                        Decks.of(context).player1,
                                        Battle.of(context),
                                        Decks.of(context));
                              } else {
                                Decks.of(context)
                                    .player2
                                    .hero
                                    ?.onDeactivateSkill(
                                        Decks.of(context).player2,
                                        Battle.of(context),
                                        Decks.of(context));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
