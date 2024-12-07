import 'package:flutter/cupertino.dart';
import 'package:matchverse/data/models/user.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.size,
    this.padding = const EdgeInsets.all(4.0),
    required this.user,
  });

  final double size;
  final EdgeInsets padding;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: Image.asset(
          user.cardPhoto,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
