import 'package:eol/core/localization/app_localization.dart';
import 'package:eol/core/widgets/custom_text_field.dart';
import 'package:eol/models/comments_model.dart';
import 'package:eol/models/post_model.dart';
import 'package:eol/services/dependency_injection_service.dart';
import 'package:eol/utils/app_constants.dart';
import 'package:eol/views/community/providers/comments_provider.dart';
import 'package:eol/views/community/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentsView extends StatelessWidget {
  final PostModel postModel;

  const CommentsView({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentsProvider>(
        create: (context) => sl(),
        builder: (context, child) {
          return Consumer<CommentsProvider>(
              builder: (context, provider, child) {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                      StreamBuilder(
                        stream: provider.getComments(postModel),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error ${snapshot.error.toString()}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs.map((e) {
                                var commentModel = CommentsModel.fromJson(
                                    e.data() as Map<String, dynamic>);
                                return CommentWidget(
                                    commentsModel: commentModel,
                                    likePressed: () {
                                      provider.likeComment(commentModel);
                                    },
                                    replyPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.all(12),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Expanded(
                                                  child: CustomTextField(
                                                      controller: provider
                                                          .replyController,
                                                      hintText: tr(AppConstants
                                                          .typeReply),
                                                      obsecureText: false),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      provider.replyComment(
                                                          commentModel);
                                                      Navigator.pop(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.reply))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    deletePressed: provider.isMyPost(postModel)
                                        ? () {
                                            showBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  padding: EdgeInsets.all(12),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(tr(AppConstants
                                                          .confirmDeletePost)),
                                                      IconButton(
                                                          onPressed: () {
                                                            provider
                                                                .deleteComment(
                                                                    commentModel,
                                                                    postModel);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.delete))
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        : null,
                                    isMyPost: provider.isMyPost(postModel));
                              }).toList(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 45,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                  controller: provider.commentController,
                                  hintText: tr(AppConstants.typeComment),
                                  obsecureText: false),
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.sendComment(postModel);
                                },
                                icon: provider.isSendingComment
                                    ? CircularProgressIndicator()
                                    : const Icon(Icons.send))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
