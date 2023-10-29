import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_viewer/app/data/api_types.dart';
import 'package:media_viewer/app/data/constants.dart';

class ChapterView extends StatefulWidget {
  const ChapterView({super.key, required this.comic, required this.startChapter});

  final Comic comic;
  final int startChapter;

  @override
  State<ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  int currentChapterIndex = 0;

  final scrollController = ScrollController();

  @override
  void initState() {
    currentChapterIndex = widget.startChapter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentChapter = widget.comic.chapters[currentChapterIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(currentChapter.name),
        centerTitle: true,
      ),
      body: ListView(
        controller: scrollController,
        children: [
          buttons(),
          for (final image in currentChapter.images)
            Container(
              constraints: const BoxConstraints(maxHeight: 700, minHeight: 200),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CachedNetworkImage(
                imageUrl: "http://$serverUrl$image",
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Theme.of(context).colorScheme.primary),
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              ),
            ),
          buttons(),
        ],
      ),
    );
  }

  Widget buttons() {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            textColor: currentChapterIndex == 0
                ? Theme.of(context).disabledColor
                : Theme.of(context).colorScheme.secondary,
            onPressed: () {
              if (currentChapterIndex == 0) {
                return;
              }
              setState(() {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                currentChapterIndex--;
              });
            },
            child: const Text('Previous'),
          ),
        ),
        Expanded(
          child: MaterialButton(
            textColor: currentChapterIndex == widget.comic.chapters.length - 1
                ? Theme.of(context).disabledColor
                : Theme.of(context).colorScheme.secondary,
            onPressed: () {
              if (currentChapterIndex == widget.comic.chapters.length - 1) {
                return;
              }
              setState(() {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.easeInOut,
                );
                currentChapterIndex++;
              });
            },
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}
