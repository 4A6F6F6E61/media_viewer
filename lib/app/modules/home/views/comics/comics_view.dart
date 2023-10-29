import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/data/api_types.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/data/themes.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';
import 'package:media_viewer/app/modules/home/views/comics/comic_overview.dart';
import 'package:media_viewer/app/modules/home/views/load_wrapper.dart';

class ComicsView extends GetView<HomeController> {
  const ComicsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComicsView'),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        int crossAxisCount = 2;
        if (constraints.maxWidth > 700) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 500) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 300) {
          crossAxisCount = 2;
        } else if (constraints.maxWidth > 200) {
          crossAxisCount = 1;
        }
        return Obx(
          () => LoadWrapper(
            onRefresh: controller.fetchComics,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              itemCount: controller.comics.length,
              itemBuilder: (context, index) {
                return comicTile(controller.comics[index]);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget comicTile(Comic comic) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ComicOverview(comic: comic),
          id: 1,
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: comic.cover,
              child: CachedNetworkImage(
                imageUrl: 'http://${serverUrl}${comic.cover}',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              comic.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
