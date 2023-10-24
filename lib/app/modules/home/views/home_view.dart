import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:media_viewer/app/modules/home/views/pictures_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.navIndex.value,
          onTap: controller.changePage,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              label: 'Pictures',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection),
              label: 'Videos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new_rounded),
              label: 'Comics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.back(id: 1);
            return false;
          },
          child: Navigator(
            key: Get.nestedKey(1),
            onGenerateRoute: (settings) => GetPageRoute<void>(
              settings: settings,
              page: () => const PicturesView(),
            ),
          ),
        ),
      );
    });
  }
}
