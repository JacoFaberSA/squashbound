import 'package:flutter/material.dart';
import 'package:squashbound/model/battle_card.dart';
import 'package:squashbound/widgets/battle/attack_action.dart';
import 'package:squashbound/widgets/cards/card.dart';

class BattleAttackingCardWidget extends StatelessWidget {
  const BattleAttackingCardWidget({
    super.key,
    required this.card,
    this.color,
    this.onAttack,
    this.onActivateSkill,
    this.onDeactivateSkill,
  });

  final BattleCard card;
  final Color? color;
  final Function()? onAttack;
  final Function()? onActivateSkill;
  final Function()? onDeactivateSkill;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 650;
    return isMobile
        ? Column(
            spacing: 32.0,
            children: [
              SizedBox(
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(-0.2)
                    ..rotateY(-0.5),
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: isMobile ? 0.8 : 1.2,
                    child: SizedBox(
                      width: 230,
                      child: CardWidget(
                        card: card,
                        selectionColor: color,
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                          maxHeight: 900,
                          minHeight: 265,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: BattleAttackActionWidget(
                        name: "Basic attack",
                        description:
                            "Each player reacts to the attack. Perfect reactions add 1 point; a miss lets you score all accumulated points.",
                        attackName: "Attack",
                        cost: "5 stamina",
                        onAttack: onAttack,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Flexible(
                      child: BattleAttackActionWidget(
                        name: card.skillName!,
                        description: card.skillDescription!,
                        onAttack: card.isSkillActive
                            ? onDeactivateSkill
                            : onActivateSkill,
                        attackName:
                            card.isSkillActive ? 'Deactivate' : 'Activate',
                        cost:
                            "${card.skillStaminaCostPerTurn} stamina per turn",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Row(
            spacing: 32.0,
            children: [
              SizedBox(
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(-0.2)
                    ..rotateY(-0.5),
                  alignment: Alignment.center,
                  child: Transform.scale(
                    scale: isMobile ? 0.8 : 1.2,
                    child: SizedBox(
                      width: 230,
                      child: CardWidget(
                        card: card,
                        selectionColor: color,
                        constraints: const BoxConstraints(
                            maxWidth: 300, maxHeight: 900, minHeight: 265),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 190,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BattleAttackActionWidget(
                      name: "Basic attack",
                      description:
                          "Each player reacts to the attack. Perfect reactions add 1 point; a miss lets you score all accumulated points.",
                      attackName: "Attack",
                      cost: "5 stamina",
                      onAttack: onAttack,
                    ),
                    SizedBox(height: 32.0),
                    BattleAttackActionWidget(
                      name: card.skillName!,
                      description: card.skillDescription!,
                      onAttack: card.isSkillActive
                          ? onDeactivateSkill
                          : onActivateSkill,
                      attackName:
                          card.isSkillActive ? 'Deactivate' : 'Activate',
                      cost: "${card.skillStaminaCostPerTurn} stamina per turn",
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
