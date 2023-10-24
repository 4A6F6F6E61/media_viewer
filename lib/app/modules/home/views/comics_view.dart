import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_viewer/app/modules/home/controllers/home_controller.dart';

class ComicsView extends GetView<HomeController> {
  const ComicsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ComicsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ComicsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
