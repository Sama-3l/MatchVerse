import 'package:flutter/material.dart';
import 'package:matchverse/constants/colors.dart';

class MatchesCountBar extends StatelessWidget {
  const MatchesCountBar({super.key, this.opacity});

  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: opacity != null ? AppColors.secondaryWhite.withOpacity(opacity!) : AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
