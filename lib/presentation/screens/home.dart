import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/colors.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/data/repo/users.dart';
import 'package:matchverse/presentation/widgets/user_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.currUser});

  final UserModel currUser;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MatchEngine _matchEngine = MatchEngine(
      swipeItems: users
          .map((e) => SwipeItem(
                content: e,
                likeAction: () {
                  setState(() {
                    widget.currUser.liked!.add(e);
                  });
                },
                nopeAction: () {
                  setState(() {
                    widget.currUser.disLiked!.add(e);
                  });
                },
              ))
          .toList());

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: AppColors.backgroundBlack,
        child: SafeArea(
            top: false,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                return UserCard(
                  currUser: widget.currUser,
                  user: users[index],
                  liked: () {
                    _matchEngine.currentItem!.like();
                  },
                  disliked: () {
                    _matchEngine.currentItem!.nope();
                  },
                );
              },
              onStackFinished: () {
                setState(() {
                  _matchEngine = MatchEngine(
                      swipeItems: users
                          .map((e) => SwipeItem(
                                content: e,
                                likeAction: () {
                                  setState(() {
                                    widget.currUser.liked!.add(e);
                                  });
                                },
                                nopeAction: () {
                                  setState(() {
                                    widget.currUser.disLiked!.add(e);
                                  });
                                },
                              ))
                          .toList());
                });
              },
              itemChanged: (SwipeItem item, int index) {},
              upSwipeAllowed: false,
              fillSpace: true,
            )));
  }
}
