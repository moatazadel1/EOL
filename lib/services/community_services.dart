import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eol/models/comment_likes_mdoel.dart';
import 'package:eol/models/comment_reply.dart';
import 'package:eol/models/comments_model.dart';
import 'package:eol/models/post_likes_model.dart';
import 'package:eol/models/post_model.dart';
import 'package:eol/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommunityServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getComments(PostModel postModel, String? uid) {
    return _firestore
        .collection('comments')
        .where('postId', isEqualTo: postModel.id)
        .snapshots();
  }

  Future<void> sendPost({required String text, File? image}) async {
    /// TODO: remove this line when merge and get user uid from firebase auth
    /// sWxCBqD7tpcAlwPQZFm1
    /// sWxCBqD7tpcAlwPQZFm1
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    String? imagePath;
    if (image != null) {
      imagePath = await uploadFile(image, userModel!.uid);
    }
    CollectionReference ref = FirebaseFirestore.instance.collection('posts');
    String id = ref.doc().id;
    PostModel postModel = PostModel(
      id: id,
      sender: userModel!.toJson(),
      text: text,
      image: imagePath,
      likesCount: 0,
      commentsCount: 0,
      timeStamp: Timestamp.now(),
    );

    ref.doc(id).set(postModel.toJson());
  }

  Future<String> uploadFile(File image, String uid) async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('$uid${DateTime.now().millisecond}.jpeg');
    UploadTask uploadTask = storageReference.putFile(image);
    await Future.value(uploadTask);

    return await storageReference.getDownloadURL();
  }

  Future<UserModel?> getPostSender(String uid) async {
    var user = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromJson(user.data() as Map<String, dynamic>);
  }

  Future<void> likeDisLikePost(PostModel postModel) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    bool isLiked = await isUserLikedPost(postModel.id);
    if (isLiked) {
      _firestore
          .collection('posts')
          .doc(postModel.id)
          .update({'likesCount': postModel.likesCount - 1});
      var da = await _firestore
          .collection('likes')
          .where('uid', isEqualTo: userModel!.uid)
          .where('postId', isEqualTo: postModel.id)
          .get();
      for (var element in da.docs) {
        element.reference.delete();
      }
    } else {
      CollectionReference ref = _firestore.collection('likes');
      String id = ref.doc().id;
      _firestore
          .collection('posts')
          .doc(postModel.id)
          .update({'likesCount': postModel.likesCount + 1});
      PostLikesModel postLikesModel = PostLikesModel(
          id: id,
          uid: userModel!.uid,
          postId: postModel.id,
          timestamp: Timestamp.now());
      ref.doc(id).set(postLikesModel.toJson());
    }
  }

  Future<bool> isUserLikedPost(String postId) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    var query = await _firestore
        .collection('likes')
        .where('uid', isEqualTo: userModel!.uid)
        .where('postId', isEqualTo: postId)
        .get();
    return query.size > 0;
  }

  Future<int> getCommentCount(String postId) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    var query = await _firestore
        .collection('comments')
        .where('uid', isEqualTo: userModel!.uid)
        .where('postId', isEqualTo: postId)
        .get();
    return query.size;
  }

  Future<void> sendComment(
      {required String text, required PostModel postModel}) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    _firestore
        .collection('posts')
        .doc(postModel.id)
        .update({'commentsCount': postModel.commentsCount + 1});

    CollectionReference ref = FirebaseFirestore.instance.collection('comments');
    String id = ref.doc().id;
    CommentsModel commentsModel = CommentsModel(
        id: id,
        postId: postModel.id,
        sender: userModel!.toJson(),
        text: text,
        likeCount: 0,
        timestamp: Timestamp.now());
    ref.doc(id).set(commentsModel.toJson());
  }

  Future<void> likeComment(CommentsModel commentsModel) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    bool isLiked = await isUserLikedComment(commentsModel);
    if (isLiked) {
      _firestore
          .collection('comments')
          .doc(commentsModel.id)
          .update({'likeCount': commentsModel.likeCount - 1});
      var da = await _firestore
          .collection('commentLikes')
          .where('uid', isEqualTo: userModel!.uid)
          .where('commentId', isEqualTo: commentsModel.id)
          .get();
      for (var element in da.docs) {
        element.reference.delete();
      }
    } else {
      CollectionReference ref = _firestore.collection('commentLikes');
      String id = ref.doc().id;
      _firestore
          .collection('comments')
          .doc(commentsModel.id)
          .update({'likeCount': commentsModel.likeCount + 1});
      CommentLikesMdoel commentLikesMdoel = CommentLikesMdoel(
          id: id,
          uid: userModel!.uid,
          commentId: commentsModel.id,
          timestamp: Timestamp.now());
      ref.doc(id).set(commentLikesMdoel.toJson());
    }
  }

  Future<bool> isUserLikedComment(CommentsModel commentsModel) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    var query = await _firestore
        .collection('commentLikes')
        .where('uid', isEqualTo: userModel!.uid)
        .where('commentId', isEqualTo: commentsModel.id)
        .get();
    return query.size > 0;
  }

  Future<void> replyComment(CommentsModel commentModel, String text) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');

    List<CommentReplyModel> oldReply = commentModel.commentReply == null
        ? []
        : List<CommentReplyModel>.from(commentModel.commentReply.map((e) => e));
    print(oldReply);
    CommentReplyModel newReply = CommentReplyModel(
        id: '',
        commentId: commentModel.id,
        sender: userModel!.toJson(),
        text: text,
        timestamp: Timestamp.now());
    oldReply.add(newReply);

    await _firestore
        .collection('comments')
        .doc(commentModel.id)
        .update({'commentReply': json.encode(oldReply)});
  }

  Stream<QuerySnapshot> getCommentReply(CommentsModel commentsModel) {
    return _firestore
        .collection('commentsReply')
        .where('commentId', isEqualTo: commentsModel.id)
        .snapshots();
  }

  Future<void> deleteComment(
      CommentsModel commentModel, PostModel postModel) async {
    _firestore
        .collection('posts')
        .doc(commentModel.postId)
        .update({'commentsCount': postModel.commentsCount - 1});
    await _firestore.collection('comments').doc(commentModel.id).delete();
  }

  deletePost(PostModel postModel) async {
    UserModel? userModel = await getPostSender('sWxCBqD7tpcAlwPQZFm1');
    if (postModel.sender['uid'] == userModel?.uid) {
      _firestore.collection('posts').doc(postModel.id).delete();
    }
  }
}
