import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';

class AddPageElement extends StatelessWidget {
  const AddPageElement({
    super.key,
    required this.title,
    required this.placeholder,
    this.icon,
    this.iconify = false,
    this.iconifyWidget,
    this.maxLength,
    this.controller,
  });

  final String title;
  final IconData? icon;
  final String placeholder;
  final bool iconify;
  final Widget? iconifyWidget;
  final int? maxLength;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.labelWhite,
        ),
        kGap8,
        Stack(
          children: [
            CupertinoTextField(
              controller: controller,
              minLines: 1,
              maxLength: maxLength,
              maxLines: 6,
              decoration: BoxDecoration(
                color: AppColors.backgroundBlack,
                border: Border.all(
                  color: AppColors.primaryWhite.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.fromLTRB(32, 8, 8, 8), // Add left padding to avoid overlap with icon
              placeholder: placeholder,
              style: context.chatText,
              placeholderStyle: context.body.copyWith(
                color: context.chatText.color!.withOpacity(0.3),
              ),
            ),
            Positioned(
              top: 12,
              left: 8,
              child: iconify
                  ? iconifyWidget ?? const SizedBox()
                  : Icon(
                      icon,
                      size: 16,
                      color: AppColors.primaryWhite.withOpacity(0.3),
                    ),
            ),
          ],
        ),
        maxLength != null ? kGap4 : Container(),
        maxLength != null
            ? Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${controller!.text.length}/$maxLength",
                  style: context.tag,
                ),
              )
            : Container(),
      ],
    );
  }
}
