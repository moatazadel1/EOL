import 'dart:io';

import 'package:eol/Subjects/utils/app_colors.dart';
import 'package:eol/core/localization/app_localization.dart';
import 'package:eol/utils/app_constants.dart';
import 'package:eol/views/community/providers/community_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPost extends StatelessWidget {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CommunityProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: AppColors.blue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: IconButton(
                        onPressed: () {
                          provider.handleImageSelection();
                        },
                        icon: const Icon(
                          Icons.attach_file,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              child: TextField(
                                controller: provider.postController,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (text) {
                                  // do something
                                },
                                decoration: InputDecoration(
                                    hintText: tr(AppConstants.whatsInYourMind),
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(20),
                                    filled: true),
                              ),
                            ),
                          ),
                          if (provider.image != null)
                            Image.file(File(provider.image!.path))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: provider.isSendingPost
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () async {
                                provider.sendPost();
                              },
                              icon: const Icon(
                                Icons.arrow_circle_up,
                                size: 35,
                              ),
                            ),
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
