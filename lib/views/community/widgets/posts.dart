import 'package:eol/Subjects/utils/app_assets.dart';
import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/core/localization/app_localization.dart';
import 'package:eol/models/post_model.dart';
import 'package:eol/models/user_model.dart';
import 'package:eol/utils/app_constants.dart';
import 'package:eol/utils/utils.dart';
import 'package:eol/views/community/providers/community_provider.dart';
import 'package:eol/views/community/views/comments_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profilepic.dart';

class MyPost extends StatelessWidget {
  final PostModel postModel;

  const MyPost({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel.fromJson(postModel.sender);
    return Consumer<CommunityProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: ProfilePic(
                            imageLink: userModel.image,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        userModel.name,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' • ${readTimestamp(postModel.timeStamp.millisecondsSinceEpoch)}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      if (postModel.sender['uid'] == provider.userModel?.uid)
                        IconButton(
                            onPressed: () {
                              showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            tr(AppConstants.confirmDeletePost)),
                                        IconButton(
                                            onPressed: () {
                                              provider.deletePost(postModel);
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Column(
                        children: [
                          Text(
                            postModel.text,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          if (postModel.image != null)
                            Image.network(
                              postModel.image!,
                              width: 300,
                              height: 200,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          provider.likePost(postModel);
                        },
                        child: Column(
                          children: [
                            FutureBuilder(
                                future: provider.isPostLiked(postModel),
                                builder: (context, snapShot) {
                                  return Image.asset(
                                    height: 32,
                                    width: 32,
                                    color:
                                        snapShot.data == null || !snapShot.data!
                                            ? Colors.grey[400]
                                            : AppColors.blue,
                                    Assets.like,
                                    fit: BoxFit.fill,
                                  );
                                }),
                            Text('${postModel.likesCount}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentsView(
                                        postModel: postModel,
                                      )));
                        },
                        child: Column(
                          children: [
                            Builder(builder: (context) {
                              return Image.asset(
                                height: 32,
                                width: 32,
                                Assets.comment,
                                fit: BoxFit.fill,
                              );
                            }),
                            Text('${postModel.commentsCount}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
