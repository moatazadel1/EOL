import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eol/models/comment_reply.dart';

class CommentsModel {
  final String id;
  final String postId;
  final dynamic sender;
  final String text;
  final int likeCount;
  final Timestamp timestamp;
  dynamic commentReply;

  CommentsModel(
      {required this.id,
      required this.postId,
      required this.sender,
      required this.text,
      required this.likeCount,
      required this.timestamp,
      this.commentReply});

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
        id: json['id'],
        postId: json['postId'],
        sender: json['sender'],
        text: json['text'],
        likeCount: json['likeCount'],
        timestamp: json['timestamp'],
        commentReply: json['commentReply'] == null
            ? null
            : List<CommentReplyModel>.from((jsonDecode(json['commentReply']))
                .map((e) => CommentReplyModel.fromJson(e))));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'sender': sender,
      'text': text,
      'likeCount': likeCount,
      'timestamp': timestamp,
      'commentReply': commentReply
    };
  }

  set setCommentReply(List<CommentReplyModel> commentReplyMode) =>
      commentReply = commentReplyMode;
}
