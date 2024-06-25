import 'package:cloud_firestore/cloud_firestore.dart';

class PostLikesModel {
  final String id;
  final String uid;
  final String postId;
  final Timestamp timestamp;

  PostLikesModel(
      {required this.id,
      required this.uid,
      required this.postId,
      required this.timestamp});

  factory PostLikesModel.fromJson(Map<String, dynamic> json) {
    return PostLikesModel(
        id: json['id'],
        uid: json['uid'],
        postId: json['postId'],
        timestamp: json['timestamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'postId': postId,
      'timestamp': timestamp,
    };
  }
}
