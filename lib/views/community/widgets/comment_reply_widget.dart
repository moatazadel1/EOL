import 'package:eol/models/comment_reply.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';

class CommentReplyWidget extends StatelessWidget {
  final CommentReplyModel commentReplyModel;

  const CommentReplyWidget({super.key, required this.commentReplyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
      decoration: BoxDecoration(
        // color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              commentReplyModel.sender['image'] == null
                  ? Image.asset(
                      Assets.imageProfile,
                      width: 25,
                      height: 25,
                    )
                  : Image.network(
                      commentReplyModel.sender['image'],
                      width: 25,
                      height: 25,
                    ),
              Text(
                commentReplyModel.sender['name'],
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(commentReplyModel.text),
        ],
      ),
    );
  }
}
