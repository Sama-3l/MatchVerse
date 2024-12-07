// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final int age;
  final List<String> tags;
  final String bio;
  final String cardPhoto;
  final String? distance;
  List<UserModel>? matches;
  List<UserModel>? liked;
  List<UserModel>? disLiked;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.tags,
    required this.bio,
    required this.cardPhoto,
    this.distance,
    this.matches,
    this.liked,
    this.disLiked,
  });
}
