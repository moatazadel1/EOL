import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eol/models/post_model.dart';
import 'package:eol/models/user_model.dart';
import 'package:eol/services/community_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommunityProvider extends ChangeNotifier {
  CommunityServices communityServices;

  CommunityProvider({required this.communityServices}) {
    initializeUser();
  }

  initializeUser() async {
    userModel = await communityServices.getPostSender('sWxCBqD7tpcAlwPQZFm1');
  }

  UserModel? userModel;
  bool isSendingPost = false;
  bool isSendingComment = false;
  XFile? image;
  TextEditingController postController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  Stream<QuerySnapshot> getPosts() {
    return communityServices.getPosts();
  }

  void sendPost() async {
    isSendingPost = true;
    await communityServices.sendPost(
        text: postController.text,
        image: image == null ? null : File(image!.path));
    postController.clear();
    image = null;
    isSendingPost = false;
    notifyListeners();
  }

  void handleImageSelection() async {
    image = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    notifyListeners();
  }

  Future<bool> isPostLiked(PostModel postModel) async {
    return await communityServices.isUserLikedPost(postModel.id);
  }

  void likePost(PostModel postModel) async {
    log('liking post');
    await communityServices.likeDisLikePost(postModel);
  }

  void deletePost(PostModel postModel) async {
    await communityServices.deletePost(postModel);
  }
}
