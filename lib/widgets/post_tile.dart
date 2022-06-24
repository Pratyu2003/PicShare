import 'package:flutter/material.dart';
import 'package:pic_share/widgets/custom_image.dart';
import 'package:pic_share/widgets/post.dart';

import '../pages/post_screen.dart';

class PostTile extends StatelessWidget {
  @override
  final Post post;

  const PostTile(this.post);

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          postId: post.postId,
          userId: post.ownerId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
