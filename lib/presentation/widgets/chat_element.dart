import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/presentation/widgets/avatar.dart';

class ChatElement extends StatefulWidget {
  const ChatElement({
    super.key,
    required this.user,
    this.noMessage = false,
    required this.onPressed,
  });

  final UserModel user;
  final bool noMessage;
  final Function() onPressed;

  @override
  State<ChatElement> createState() => _ChatElementState();
}

class _ChatElementState extends State<ChatElement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Row(
          children: [
            Avatar(
              size: 56,
              user: widget.user,
            ),
            kGap16,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.user.name}, ${widget.user.age}",
                  style: context.heading,
                ),
                !widget.noMessage
                    ? Text(
                        "Say Hello!",
                        style: context.labelWhite,
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
