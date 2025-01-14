import 'package:flutter/material.dart';
import 'package:squashbound/theme.dart';

class BattleAttackActionWidget extends StatelessWidget {
  const BattleAttackActionWidget(
      {super.key,
      this.onAttack,
      required this.name,
      required this.description,
      required this.attackName,
      this.cost});

  final String name;
  final String description;
  final String attackName;
  final String? cost;
  final Function()? onAttack;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: SquashboundTheme.textTheme.displaySmall,
        ),
        Text(
          description,
          style: SquashboundTheme.textTheme.bodySmall,
        ),
        if (cost != null) SizedBox(height: 8.0),
        if (cost != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: SquashboundTheme.tertiaryColor,
              borderRadius:
                  BorderRadius.circular(SquashboundTheme.borderRadiusSmall),
            ),
            child: Text(
              "Cost: $cost",
              style: SquashboundTheme.textTheme.bodySmall,
            ),
          ),
        SizedBox(height: 12.0),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(onPressed: onAttack, child: Text(attackName)),
        ),
      ],
    );
  }
}
