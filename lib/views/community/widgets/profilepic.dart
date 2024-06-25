import 'package:eol/Subjects/utils/app_assets.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String? imageLink;

  const ProfilePic({super.key, required this.imageLink});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: imageLink == null
            ? Image.asset(Assets.imageProfile)
            : Image.network(imageLink!),
      ),
    );
  }
}
