import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/presentation/widgets/chat_element.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, required this.currUser});

  final UserModel currUser;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundBlack,
      child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text("Chats", style: context.title)),
                  kGap24,
                  CupertinoTextField(
                    minLines: 1,
                    maxLines: 6,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundBlack,
                      border: Border.all(
                        color: AppColors.primaryWhite.withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8), // Add left padding to avoid overlap with icon
                    placeholder: "Search",
                    style: context.chatText,
                    placeholderStyle: context.body.copyWith(
                      color: context.chatText.color!.withOpacity(0.3),
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        CupertinoIcons.search,
                        size: 16,
                        color: AppColors.primaryWhite,
                      ),
                    ),
                  ),
                  kGap16,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Matches", style: context.heading),
                  ),
                  kGap8,
                  widget.currUser.matches!.isEmpty
                      ? Expanded(
                          child: Center(
                              child: Text(
                          "NO MATCHES YET",
                          style: context.subHeading,
                        )))
                      : Expanded(
                          child: ListView(
                            children: widget.currUser.matches!
                                .map((e) => ChatElement(
                                      user: e,
                                      onPressed: () {
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: const Text('No Chat Page'),
                                              content: const Text('Chat Page hasn\'t need made yet. Sorry'),
                                              actions: <Widget>[
                                                CupertinoDialogAction(
                                                  child: const Text('Cancel'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                CupertinoDialogAction(
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    // Handle the OK button press
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ))
                                .toList(),
                          ),
                        )
                ],
              ))),
    );
  }
}
