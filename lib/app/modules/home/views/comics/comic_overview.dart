import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:media_viewer/app/data/api_types.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/modules/home/views/comics/chapter_view.dart';

class ComicOverview extends StatelessWidget {
  const ComicOverview({super.key, required this.comic});

  final Comic comic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.name),
      ),
      body: ListView(
        children: [
          Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: comic.cover,
                  child: CachedNetworkImage(
                    height: 300,
                    imageUrl: 'http://$serverUrl${comic.cover}',
                  ),
                ),
                Column(
                  children: [
                    Text(comic.name, style: Theme.of(context).textTheme.headlineMedium),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Chapters', style: Theme.of(context).textTheme.headlineMedium),
          ),
          for (final chapter in comic.chapters)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Text(chapter.name),
              onTap: () {
                Get.to(
                  () => ChapterView(
                    comic: comic,
                    startChapter: comic.chapters.indexOf(chapter),
                  ),
                  transition: Transition.cupertino,
                  id: 1,
                );
              },
            ),
        ],
      ),
    );
  }
}
