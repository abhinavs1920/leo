import 'package:flutter/material.dart';
import 'package:leo/models/posts.model.dart';
import 'package:leo/services/posts.service.dart';
import 'package:leo/utils/constants.dart';
import 'package:leo/widgets/posts_card.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostsModel>>(
      future: PostService().getAllUserRoleFilteredPosts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PostsModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final events = snapshot.data;
          return events!.isEmpty
              ? const Center(
                  child: Text(
                    'No posts available',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(defaultPadding),
                  children: (events)
                      .map(
                        (event) => PostsCard(
                          images: event.images,
                          postTitle: event.postTitle,
                          postDescription: event.postDescription,
                        ),
                      )
                      .toList(),
                );
        }
      },
    );
  }
}
