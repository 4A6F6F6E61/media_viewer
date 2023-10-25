import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/data/api_types.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';
import 'package:media_viewer/app/modules/home/views/load_wrapper.dart';

class VideosView extends GetView<HomeController> {
  const VideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: controller.searchController.value,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: UnderlineInputBorder(),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            // controller.searchVideos(value);
          },
        ),
      ),
      body: LoadWrapper(
        onRefresh: () async {
          await controller.fetchVideos();
        },
        child: ListView.builder(
          itemCount: controller.allVideos.length,
          itemBuilder: (context, index) {
            return videoTile(controller.allVideos[index]);
          },
        ),
      ),
    );
  }

  Widget videoTile(Video video) {
    log("http://$serverUrl${video.url}");
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          // Get.toNamed('/video_player', arguments: video);
        },
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.url.split("/").last,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            video.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
