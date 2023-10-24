import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';

class VideosView extends GetView<HomeController> {
  const VideosView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Videos',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
