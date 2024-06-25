import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eol/models/comments_model.dart';
import 'package:eol/models/post_model.dart';
import 'package:eol/models/user_model.dart';
import 'package:eol/services/community_services.dart';
import 'package:flutter/material.dart';

class CommentsProvider extends ChangeNotifier {
  CommunityServices communityServices;

  CommentsProvider({required this.communityServices}) {
    initializeUser();
  }

  initializeUser() async {
    userModel = await communityServices.getPostSender('sWxCBqD7tpcAlwPQZFm1');
    log('comment user ${userModel?.toJson()}');
  }

  UserModel? userModel;
  bool isSendingComment = false;
  bool isReplyingComment = false;

  TextEditingController postController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  Stream<QuerySnapshot> getComments(PostModel postModel) {
    initializeUser();
    return communityServices.getComments(postModel, userModel?.uid);
  }

  void sendComment(PostModel postModel) async {
    isSendingComment = true;
    await communityServices.sendComment(
        text: commentController.text, postModel: postModel);
    commentController.clear();

    isSendingComment = false;
    notifyListeners();
  }

  Future<void> likeComment(CommentsModel commentModel) async {
    await communityServices.likeComment(commentModel);
  }

  Future<void> replyComment(CommentsModel commentModel) async {
    log('oops user is replying');
    await communityServices.replyComment(commentModel, replyController.text);
    replyController.clear();
  }

  bool isMyPost(PostModel postModel) {
    return userModel == null
        ? false
        : postModel.sender['uid'] == userModel!.uid;
  }

  void deleteComment(CommentsModel commentModel, PostModel postModel) async {
    await communityServices.deleteComment(commentModel, postModel);
  }

  Stream<QuerySnapshot> getCommentReply(CommentsModel commentsModel) {
    return communityServices.getCommentReply(commentsModel);
  }
}
