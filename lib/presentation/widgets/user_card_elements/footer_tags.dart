import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/sizes.dart';
import 'package:matchverse/presentation/widgets/group_card_tag.dart';

class FooterTags extends StatelessWidget {
  const FooterTags({super.key, required this.longPress, required this.tags});

  final bool longPress;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < tags.length; i++) ...[
          GroupCardTag(text: tags[i]),
          if (i < tags.length - 1) kGap4
        ],
      ],
    );
  }
}
