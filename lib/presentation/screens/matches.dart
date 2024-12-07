import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:matchverse/algorithms/methods.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/sizes.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/presentation/widgets/user_card.dart';
import 'package:matchverse/presentation/widgets/user_card_elements/matches_count_bar.dart';
import 'package:swipe_cards/swipe_cards.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key, required this.currUser, required this.likedUsers});

  final UserModel currUser;
  final List<List<UserModel>> likedUsers;

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  late List<int> indices = List.filled(widget.likedUsers.length, 0);
  late List<bool> completed = List.filled(widget.likedUsers.length, false);
  late List<MatchEngine> matches = widget.likedUsers
      .map((e) => MatchEngine(
          swipeItems: (e..shuffle())
              .sublist(0, 4)
              .map((e) => SwipeItem(
                    content: e,
                    likeAction: () {},
                    nopeAction: () {},
                  ))
              .toList()))
      .toList();
  final Methods func = Methods();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppColors.backgroundBlack,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Matches",
                      style: context.navTitle,
                    )),
                kGap24,
                Expanded(
                    child: ListView.builder(
                        itemCount: matches.length,
                        itemBuilder: (context, idx) => Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: !completed[idx]
                                  ? Container(
                                      height: MediaQuery.of(context).size.height * 0.7,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                      child: Stack(
                                        children: [
                                          SwipeCards(
                                              itemChanged: (SwipeItem item, int index) {
                                                setState(() {
                                                  indices[idx] = index;
                                                });
                                              },
                                              upSwipeAllowed: false,
                                              fillSpace: true,
                                              matchEngine: matches[idx],
                                              onStackFinished: () {
                                                setState(() {
                                                  completed[idx] = true;
                                                });
                                              },
                                              itemBuilder: (context, index) => UserCard(
                                                    currUser: widget.currUser,
                                                    borderRadius: BorderRadius.circular(16),
                                                    user: widget.likedUsers[idx][index],
                                                    lastCard: index == 3,
                                                    liked: () {
                                                      matches[idx].currentItem!.like();
                                                    },
                                                    disliked: () {
                                                      matches[idx].currentItem!.nope();
                                                    },
                                                  )),
                                          indices[idx] < 3
                                              ? Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                                  child: Row(
                                                    children: [
                                                      const Expanded(
                                                        child: MatchesCountBar(
                                                          opacity: 1,
                                                        ),
                                                      ),
                                                      kGap4,
                                                      Expanded(
                                                        child: MatchesCountBar(
                                                          opacity: indices[idx] > 0 ? 1 : 0.4,
                                                        ),
                                                      ),
                                                      kGap4,
                                                      Expanded(
                                                        child: MatchesCountBar(
                                                          opacity: indices[idx] > 1 ? 1 : 0.4,
                                                        ),
                                                      ),
                                                      kGap4,
                                                      Expanded(
                                                        child: MatchesCountBar(
                                                          opacity: indices[idx] > 2 ? 1 : 0.4,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ))
                                  : indices[idx] != widget.likedUsers[0].length + 1
                                      ? FutureBuilder<bool>(
                                          future: func.matchFound(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              // Show container while the future is running
                                              return Container(
                                                height: MediaQuery.of(context).size.height * 0.7,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
                                                child: UserCard(
                                                  currUser: widget.currUser,
                                                  borderRadius: BorderRadius.circular(16),
                                                  user: widget.likedUsers[idx][Random().nextInt(4)],
                                                  itsAMatch: true,
                                                  liked: () {
                                                    matches[idx].currentItem!.like();
                                                  },
                                                  disliked: () {
                                                    matches[idx].currentItem!.nope();
                                                  },
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              // Show a placeholder after 2 seconds
                                              indices[idx] = widget.likedUsers[0].length + 1;
                                              return Container();
                                            } else {
                                              // Handle errors if any
                                              return Container();
                                            }
                                          },
                                        )
                                      : Container(),
                            )))
              ],
            ),
          ),
        ));
  }
}
