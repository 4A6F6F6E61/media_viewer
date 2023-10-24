import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:media_viewer/app/data/api_types.dart';
import 'package:media_viewer/app/data/constants.dart';
import 'package:media_viewer/app/modules/home/views/comics_view.dart';
import 'package:media_viewer/app/modules/home/views/pictures_view.dart';
import 'package:media_viewer/app/modules/home/views/videos_view.dart';
import 'package:media_viewer/app/modules/settings/views/settings_view.dart';

class HomeController extends GetxController {
  RxInt navIndex = 0.obs;
  RxList<MediaFolder> pictureFolders = <MediaFolder>[].obs;
  RxList<MediaFolder> videoFolders = <MediaFolder>[].obs;
  RxList<Comic> comics = <Comic>[].obs;

  void changePage(int index) {
    navIndex.value = index;
    switch (index) {
      case 0:
        Get.offAll(() => const PicturesView(), transition: Transition.fadeIn, id: 1);
        break;
      case 1:
        Get.offAll(() => const VideosView(), transition: Transition.fadeIn, id: 1);
        break;
      case 2:
        Get.offAll(() => const ComicsView(), transition: Transition.fadeIn, id: 1);
        break;
      case 3:
        Get.offAll(() => const SettingsView(), transition: Transition.fadeIn, id: 1);
        break;
      default:
        Get.offAllNamed('/home', id: 1);
    }
  }

  @override
  void onInit() async {
    await fetchPictures();
    await fetchVideos();
    await fetchComics();
    super.onInit();
  }

  Future<void> fetchPictures() async {
    var url = Uri.http(serverUrl, 'api/pictures');
    var response = await http.get(url);

    pictureFolders.value = jsonDecode(response.body)
        .map((element) {
          log(element['Name'] ?? 'null');
          return MediaFolder.fromJson(element);
        })
        .whereType<MediaFolder>()
        .toList();
    log(pictureFolders[0].name);
  }

  Future<void> fetchVideos() async {
    var url = Uri.http(serverUrl, 'api/videos');
    var response = await http.get(url);

    videoFolders.value = jsonDecode(response.body)
        .map((element) {
          log(element['Name'] ?? 'null');
          return MediaFolder.fromJson(element);
        })
        .whereType<MediaFolder>()
        .toList();
    log(videoFolders[0].name);
  }

  Future<void> fetchComics() async {
    var url = Uri.http(serverUrl, 'api/comics');
    var response = await http.get(url);

    comics.value = jsonDecode(response.body)
        .map((element) {
          log(element['Name'] ?? 'null');
          return Comic.fromJson(element);
        })
        .whereType<Comic>()
        .toList();
    log(comics[0].name);
  }
}
