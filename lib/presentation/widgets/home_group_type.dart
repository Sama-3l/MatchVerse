import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';

class HomeGroupType extends StatelessWidget {
  const HomeGroupType({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: context.body.copyWith(color: context.body.color!.withOpacity(0.5)),
            ),
            kGap4,
            const Icon(
              CupertinoIcons.chevron_down,
              size: 12,
              color: AppColors.primaryWhite,
            )
          ],
        ),
        kGap16,
        ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: children,
        )
      ],
    );
  }
}
