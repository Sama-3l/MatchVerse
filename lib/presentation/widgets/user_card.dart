import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/presentation/widgets/user_card_elements/footer_tags.dart';
import 'package:matchverse/presentation/widgets/user_card_elements/matches_count_bar.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.currUser,
    required this.liked,
    required this.disliked,
    this.borderRadius = BorderRadius.zero,
    this.lastCard = false,
    this.itsAMatch = false,
  });

  final UserModel user;
  final UserModel currUser;
  final Function() liked;
  final Function() disliked;
  final BorderRadiusGeometry borderRadius;
  final bool lastCard;
  final bool itsAMatch;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.itsAMatch) {
        if (widget.currUser.matches == null) {
          widget.currUser.matches = [
            widget.user
          ];
        } else {
          widget.currUser.matches!.add(widget.user);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: widget.borderRadius,
        child: SizedBox(
          height: double.infinity,
          child: Image.asset(
            alignment: const Alignment(0.25, 0),
            widget.user.cardPhoto,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: cardGradient, borderRadius: widget.borderRadius),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.user.name}, ${widget.user.age}",
                      style: context.title,
                    ),
                    const Spacer(),
                    const Icon(
                      CupertinoIcons.paperplane,
                      size: 16,
                      color: AppColors.primaryWhite,
                    ),
                    kGap4,
                    Text(
                      "${widget.user.distance} away",
                      style: context.heading,
                    ),
                  ],
                ),
                kGap8,
                FooterTags(
                  longPress: false,
                  tags: widget.user.tags,
                ),
                kGap16,
                Text(
                  "BIO",
                  style: context.labelWhite,
                ),
                kGap8,
                Text(
                  widget.user.bio,
                  style: context.body,
                ),
                kGap16,
                widget.itsAMatch
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.actionOrange),
                        child: Center(
                          child: Text(
                            "It's a Match",
                            style: context.accName,
                          ),
                        ))
                    : Row(
                        children: [
                          Expanded(
                              child: CupertinoButton(
                            color: AppColors.primaryWhite.withOpacity(0.7),
                            onPressed: widget.disliked,
                            child: const Icon(CupertinoIcons.xmark),
                          )),
                          kGap8,
                          Expanded(
                              child: CupertinoButton(
                            color: AppColors.actionOrange,
                            onPressed: widget.liked,
                            child: const Icon(
                              CupertinoIcons.heart_fill,
                              color: AppColors.primaryWhite,
                            ),
                          )),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
      widget.lastCard
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: MatchesCountBar(
                      opacity: 1,
                    ),
                  ),
                  kGap4,
                  Expanded(
                    child: MatchesCountBar(),
                  ),
                  kGap4,
                  Expanded(
                    child: MatchesCountBar(),
                  ),
                  kGap4,
                  Expanded(
                    child: MatchesCountBar(),
                  )
                ],
              ),
            )
          : Container(),
    ]);
  }
}
