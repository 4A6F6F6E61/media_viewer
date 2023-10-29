import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PictureViewer extends StatelessWidget {
  const PictureViewer({Key? key, required this.galleryItems, required this.initialIndex})
      : super(key: key);

  final List<String> galleryItems;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      pageController: PageController(initialPage: initialIndex),
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            "http://$serverUrl/${galleryItems[index]}",
          ),
          initialScale: PhotoViewComputedScale.contained,
          heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index]),
        );
      },
      customSize: MediaQuery.of(context).size,
      itemCount: galleryItems.length,
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value:
                event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
          ),
        ),
      ),
    );
  }
}
