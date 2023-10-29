import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:media_viewer/app/data/themes.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: lightMode,
      darkTheme: darkMode,
    ),
  );
}
