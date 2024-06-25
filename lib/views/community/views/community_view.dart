import 'package:eol/models/post_model.dart';
import 'package:eol/services/dependency_injection_service.dart';
import 'package:eol/views/community/providers/community_provider.dart';
import 'package:eol/views/community/widgets/new_post.dart';
import 'package:eol/views/community/widgets/posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommunityProvider>(
      create: (context) => sl(),
      builder: (context, child) {
        return SafeArea(
          top: false,
          child: Consumer<CommunityProvider>(
            builder: (context, provider, child) {
              return Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: provider.getPosts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text('Error: ${snapshot.error.toString()}'),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text('No posts available.'),
                            );
                          }
                          return ListView(
                            children: snapshot.data!.docs.map((e) {
                              var postModel = PostModel.fromJson(
                                  e.data() as Map<String, dynamic>);
                              return MyPost(
                                postModel: postModel,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: const NewPost(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
