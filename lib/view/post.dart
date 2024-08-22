import 'dart:io';

import 'package:cumins36/model/post_model.dart';
import 'package:cumins36/utils/constants/description_text.dart';
import 'package:cumins36/utils/constants/image_urls.dart';
import 'package:cumins36/utils/constants/title_text.dart';
import 'package:cumins36/view/feedback.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ValueNotifier<List<PostModel>> postListNotifier =
      ValueNotifier<List<PostModel>>([
    PostModel(
      image: ImageUrls.audi,
      title: Titles.audi,
      description: Descriptions.audi,
    ),
    PostModel(
      image: ImageUrls.datsun,
      title: Titles.datsun,
      description: Descriptions.datsun,
    ),
    PostModel(
      image: ImageUrls.bmwe30,
      title: Titles.bmwe30,
      description: Descriptions.bmwe30,
    ),
    PostModel(
      image: ImageUrls.rangerRover,
      title: Titles.rangerRover,
      description: Descriptions.rangerRover,
    ),
    PostModel(
      image: ImageUrls.datsunBlue,
      title: Titles.datsunBlue,
      description: Descriptions.datsun,
    ),
    PostModel(
      image: ImageUrls.bmw,
      title: Titles.bmw,
      description: Descriptions.bmw,
    ),
    PostModel(
      image: ImageUrls.mustang,
      title: Titles.mustang,
      description: Descriptions.mustang,
    )
  ]);

  void addNewPost(PostModel newPost) {
    postListNotifier.value = [...postListNotifier.value, newPost];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(onSubmit: addNewPost),
                ),
              ),
              child: const Icon(Icons.add, size: 34),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder<List<PostModel>>(
        valueListenable: postListNotifier,
        builder: (context, postList, _) {
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              List<PostModel> list = postList.reversed.toList();
              PostModel post = list[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          post.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    post.isFile
                        ? Image.file(
                            File(post.image),
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width,
                            height: 230,
                          )
                        : Image.asset(
                            post.image,
                            fit: BoxFit.cover,
                            width: MediaQuery.sizeOf(context).width,
                            height: 230,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(post.description),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              post.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: post.isLiked ? Colors.red : Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                post.isLiked = !post.isLiked;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.comment),
                          const SizedBox(width: 10),
                          const Icon(Icons.share),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
