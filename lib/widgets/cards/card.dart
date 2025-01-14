import 'package:flutter/material.dart';
import 'package:squashbound/model/battle_card.dart';
import 'package:squashbound/theme.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.card,
    this.onSelected,
    this.selected = false,
    this.selectionColor,
    this.constraints,
  });

  final BattleCard card;
  final bool selected;
  final Function(BattleCard)? onSelected;
  final Color? selectionColor;
  final BoxConstraints? constraints;

  Color get _selectionColor => selectionColor ?? SquashboundTheme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      constraints: constraints ??
          const BoxConstraints(
            maxWidth: 300,
            maxHeight: 300,
            minHeight: 280,
          ),
      decoration: BoxDecoration(
        color: SquashboundTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.fromBorderSide(
          SquashboundTheme.roundedRectangleBorder(radius: 10).side.copyWith(
                color: selected
                    ? _selectionColor
                    : SquashboundTheme.foregroundColor,
              ),
        ),
        gradient: card.isSkillActive
            ? LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
                colors: [
                  SquashboundTheme.tertiaryColor,
                  SquashboundTheme.cardColor,
                ],
                stops: const [0.0, 0.3],
              )
            : null,
      ),
      child: AspectRatio(
        aspectRatio: 64 / 89,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => onSelected?.call(card),
          child: Stack(
            children: [
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 3.55 / 3,
                    child: Container(
                      color: selectionColor ?? Colors.white,
                      child: Image.network(
                        card.artwork,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    card.name,
                    style: SquashboundTheme.textTheme.bodyMedium,
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stamina",
                            style: SquashboundTheme.textTheme.bodySmall,
                          ),
                          Text(
                            card.stats["stamina"].toString(),
                            style:
                                SquashboundTheme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Power",
                            style: SquashboundTheme.textTheme.bodySmall,
                          ),
                          Text(
                            card.stats["power"].toString(),
                            style:
                                SquashboundTheme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Speed",
                            style: SquashboundTheme.textTheme.bodySmall,
                          ),
                          Text(
                            card.stats["speed"].toString(),
                            style:
                                SquashboundTheme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (card.modifications.isNotEmpty)
                        Tooltip(
                          message: card.modifications
                              .reduce((value, element) => "$element\r\n$value"),
                          child: Icon(
                            Icons.trending_up_rounded,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Text("Skill: ${card.skillName}",
                          style: SquashboundTheme.textTheme.bodySmall),
                      Tooltip(
                        message: card.skillDescription,
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              if (selected)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: _selectionColor,
                    size: 28,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
