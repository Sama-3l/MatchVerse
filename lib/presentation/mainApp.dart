import 'package:flutter/cupertino.dart';
import 'package:matchverse/constants/extensions.dart';
import 'package:matchverse/constants/theme.dart';
import 'package:matchverse/data/models/user.dart';
import 'package:matchverse/data/repo/users.dart';
import 'package:matchverse/presentation/screens/account.dart';
import 'package:matchverse/presentation/screens/chats.dart';
import 'package:matchverse/presentation/screens/matches.dart';
import 'package:matchverse/presentation/screens/home.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CupertinoTabController controller = CupertinoTabController();
  final UserModel user = UserModel(
      id: "100",
      name: "Samael",
      age: 21,
      tags: [
        "Business",
        "Friendly",
        "Beach"
      ],
      bio: "Hello there I am doing some work",
      cardPhoto: "lib/assets/people_images/Bob Smith.jpg",
      liked: [],
      disLiked: [],
      matches: []);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        home: CupertinoTabScaffold(
          controller: controller,
          tabBar: CupertinoTabBar(height: 56, items: [
            CupertinoIcons.home.toNavBarItem('Home'),
            CupertinoIcons.heart.toNavBarItem('Matches'),
            CupertinoIcons.chat_bubble_2.toNavBarItem('Chats'),
            CupertinoIcons.person_circle.toNavBarItem('Account'),
          ]),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) => HomeScreen(
                    currUser: user,
                  ),
                );
              case 1:
                return CupertinoTabView(
                  builder: (context) => MatchesScreen(
                    currUser: user,
                    likedUsers: List.generate(4, (index) => (users..shuffle()).sublist(0, 4)),
                  ),
                );
              case 2:
                return CupertinoTabView(
                  builder: (context) => ChatsScreen(
                    currUser: user,
                  ),
                );
              case 3:
                return CupertinoTabView(
                  builder: (context) => AccountScreen(
                    user: user,
                  ),
                );
              default:
                return CupertinoTabView(
                  builder: (context) => HomeScreen(
                    currUser: user,
                  ),
                );
            }
          },
        ));
  }
}
