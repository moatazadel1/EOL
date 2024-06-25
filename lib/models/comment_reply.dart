import 'package:cloud_firestore/cloud_firestore.dart';

class CommentReplyModel {
  final String id;
  final String commentId;
  final dynamic sender;
  final String text;
  final Timestamp? timestamp;

  CommentReplyModel({
    required this.id,
    required this.commentId,
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  factory CommentReplyModel.fromJson(Map<String, dynamic> json) {
    return CommentReplyModel(
      id: json['id'],
      commentId: json['commentId'],
      sender: json['sender'],
      text: json['text'],
      timestamp: json['timestamp'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(json['timestamp'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commentId': commentId,
      'sender': sender,
      'text': text,
      'timestamp': timestamp?.millisecondsSinceEpoch,
    };
  }
}
