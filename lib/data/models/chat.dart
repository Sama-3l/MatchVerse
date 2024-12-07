import 'package:matchverse/data/models/user.dart';

class ChatModel {
  final String id;
  final String message;
  final bool attachment;
  final UserModel sender;
  final DateTime timestamp;

  ChatModel({
    required this.id,
    required this.message,
    required this.attachment,
    required this.sender,
    required this.timestamp,
  });
}
