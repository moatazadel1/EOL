import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final dynamic sender;
  final String text;
  final String? image;
  int likesCount;
  int commentsCount;
  final Timestamp timeStamp;

  PostModel(
      {required this.id,
      required this.sender,
      required this.text,
      this.image,
      required this.likesCount,
      required this.commentsCount,
      required this.timeStamp});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'],
        sender: json['sender'],
        text: json['text'],
        image: json['image'],
        likesCount: json['likesCount'],
        commentsCount: json['commentsCount'],
        timeStamp: json['timeStamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'text': text,
      'image': image,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'timeStamp': timeStamp,
    };
  }
}
