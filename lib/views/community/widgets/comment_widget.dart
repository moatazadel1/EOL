import 'package:eol/Subjects/utils/app_assets.dart';
import 'package:eol/core/localization/app_localization.dart';
import 'package:eol/models/comment_reply.dart';
import 'package:eol/models/comments_model.dart';
import 'package:eol/utils/app_constants.dart';
import 'package:eol/views/community/providers/comments_provider.dart';
import 'package:eol/views/community/widgets/comment_reply_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatelessWidget {
  final CommentsModel commentsModel;
  final Function likePressed;
  final Function replyPressed;
  final Function? deletePressed;
  final bool isMyPost;

  const CommentWidget(
      {super.key,
      required this.commentsModel,
      required this.likePressed,
      required this.replyPressed,
      this.deletePressed,
      required this.isMyPost});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentsProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                commentsModel.sender['image'] == null
                    ? Image.asset(
                        Assets.imageProfile,
                        width: 40,
                        height: 40,
                      )
                    : Image.network(
                        commentsModel.sender['image'],
                        width: 40,
                        height: 40,
                      ),
                Text(
                  commentsModel.sender['name'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ],
            ),
            Text(commentsModel.text),
            const SizedBox(
              height: 6,
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    likePressed.call();
                  },
                  child: Row(
                    children: [
                      Text(commentsModel.likeCount.toString()),
                      Text(tr(AppConstants.like)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      replyPressed.call();
                    },
                    child: Text(tr(AppConstants.reply))),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                    onTap: () {
                      deletePressed?.call();
                    },
                    child: Text(tr(AppConstants.delete)))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            if (commentsModel.commentReply != null)
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        (commentsModel.commentReply as List<CommentReplyModel>)
                            .map((e) {
                      return CommentReplyWidget(commentReplyModel: e);
                    }).toList(),
                  ))
          ],
        ),
      );
    });
  }
}
