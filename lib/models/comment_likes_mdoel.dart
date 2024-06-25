import 'package:cloud_firestore/cloud_firestore.dart';

class CommentLikesMdoel {
  final String id;
  final String uid;
  final String commentId;
  final Timestamp timestamp;

  CommentLikesMdoel(
      {required this.id,
      required this.uid,
      required this.commentId,
      required this.timestamp});

  factory CommentLikesMdoel.fromJson(Map<String, dynamic> json) {
    return CommentLikesMdoel(
        id: json['id'],
        uid: json['uid'],
        commentId: json['commentId'],
        timestamp: json['timestamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'commentId': commentId,
      'timestamp': timestamp,
    };
  }
}
