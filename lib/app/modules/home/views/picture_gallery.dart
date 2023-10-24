import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';

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
          body: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: pictures.length,
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Positioned.fill(
                    bottom: 0.0,
                    child: GridTile(
                      child: CachedNetworkImage(
                        imageUrl: "http://$serverUrl/${pictures[index]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
