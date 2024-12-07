import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/presentation/widgets/chat_element.dart';
import 'package:matchverse/presentation/widgets/user_card_elements/footer_tags.dart';
import 'package:swipe_cards/swipe_cards.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.user, this.profilePage = false});

  final UserModel user;
  final bool profilePage;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late MatchEngine match = MatchEngine(
      swipeItems: widget.user.liked!
          .map((e) => SwipeItem(
                content: e,
                likeAction: () {},
                nopeAction: () {},
              ))
          .toList());

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppColors.backgroundBlack,
        child: SafeArea(
            top: false,
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Image.asset(
                    widget.user.cardPhoto,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "${widget.user.name}, ${widget.user.age}",
                    style: context.title,
                  ),
                ),
                kGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FooterTags(longPress: false, tags: widget.user.tags),
                ),
                kGap16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "BIO",
                    style: context.labelWhite,
                  ),
                ),
                kGap8,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.user.bio,
                    style: context.body,
                  ),
                ),
                kGap24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Liked Users",
                    style: context.heading,
                  ),
                ),
                kGap16,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.user.liked!
                        .map((e) => ChatElement(
                              user: e,
                              onPressed: () {},
                            ))
                        .toList(),
                  ),
                ),
                widget.user.disLiked != null && widget.user.disLiked!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Disliked Users",
                          style: context.heading,
                        ),
                      )
                    : Container(),
                kGap16,
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.user.disLiked!
                        .map((e) => ChatElement(
                              user: e,
                              onPressed: () {},
                            ))
                        .toList(),
                  ),
                )
              ],
            )));
  }
}
