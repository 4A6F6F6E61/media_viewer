import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
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
  RxList<PictureFolder> pictureFolders = <PictureFolder>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Video> allVideos = <Video>[].obs;
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
    await refreshData();
    super.onInit();
  }

  Future<void> refreshData() async {
    await fetchPictures();
    await fetchVideos();
    await fetchComics();
  }

  Future<void> fetchPictures() async {
    var url = Uri.http(serverUrl, 'api/pictures');
    var response = await http.get(url);

    pictureFolders.value =
        jsonDecode(response.body).map(PictureFolder.fromJson).whereType<PictureFolder>().toList();
  }

  Future<void> fetchVideos() async {
    var url = Uri.http(serverUrl, 'api/videos');
    var response = await http.get(url);

    allVideos.value = jsonDecode(response.body).map(Video.fromJson).whereType<Video>().toList();
  }

  Future<void> fetchComics() async {
    var url = Uri.http(serverUrl, 'api/comics');
    var response = await http.get(url);

    comics.value = jsonDecode(response.body).map(Comic.fromJson).whereType<Comic>().toList();
  }
}
