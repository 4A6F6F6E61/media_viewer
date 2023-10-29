import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';
import 'package:media_viewer/app/modules/home/views/load_wrapper.dart';
import 'package:media_viewer/app/modules/home/views/pictures/picture_gallery.dart';

class PicturesView extends GetView<HomeController> {
  const PicturesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PicturesView'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
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
              onRefresh: () async {
                await controller.fetchPictures();
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: controller.pictureFolders.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      Positioned.fill(
                        bottom: 0.0,
                        child: GridTile(
                          footer: GridTileBar(
                            title: Text(controller.pictureFolders[index].name),
                            subtitle:
                                Text('${controller.pictureFolders[index].files.length} Images'),
                            backgroundColor: Colors.black45,
                          ),
                          child: Hero(
                            tag: Key(controller.pictureFolders[index].files[0]),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "http://$serverUrl/${controller.pictureFolders[index].files[0]}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => PictureGallery(name: controller.pictureFolders[index].name),
                                transition: Transition.cupertino,
                                id: 1,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
