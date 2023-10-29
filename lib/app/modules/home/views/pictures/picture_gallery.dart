import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';
import 'package:media_viewer/app/modules/home/views/load_wrapper.dart';
import 'package:media_viewer/app/modules/home/views/pictures/picture_viewer.dart';

class PictureGallery extends GetView<HomeController> {
  const PictureGallery({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final pictures =
            controller.pictureFolders.firstWhere((element) => element.name == name).files;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Gallery'),
            centerTitle: true,
          ),
          body: LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth > 700) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 500) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 300) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 200) {
              crossAxisCount = 2;
            }
            return LoadWrapper(
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
                itemCount: pictures.length,
                itemBuilder: (context, index) {
                  if (index == 1) {
                    log(pictures[index]);
                  }
                  return Stack(
                    children: <Widget>[
                      Positioned.fill(
                        bottom: 0.0,
                        child: GridTile(
                          child: Hero(
                            tag: pictures[index],
                            child: CachedNetworkImage(
                              imageUrl: "http://$serverUrl/${pictures[index]}",
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
                                () => PictureViewer(
                                  galleryItems: pictures,
                                  initialIndex: index,
                                ),
                                transition: Transition.cupertino,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        );
      },
    );
  }
}
