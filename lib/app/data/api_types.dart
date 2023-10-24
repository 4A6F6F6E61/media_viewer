class Comic {
  String name;
  String cover;
  List<Chapter> chapters;

  Comic({required this.name, required this.cover, required this.chapters});

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      name: json['Name'] as String,
      cover: json['Cover'] as String,
      chapters: (json['Chapters'] as List?)
              ?.map((e) => e == null ? null : Chapter.fromJson(e as Map<String, dynamic>))
              .whereType<Chapter>()
              .toList() ??
          [],
    );
  }
}

class Chapter {
  String name;
  List<String> images;

  Chapter({required this.name, required this.images});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      name: json['Name'] as String,
      images: (json['Images'] as List?)?.map((e) => e as String).toList() ?? [],
    );
  }
}

class MediaFolder {
  String name;
  List<String> files;

  MediaFolder({required this.name, required this.files});

  factory MediaFolder.fromJson(Map<String, dynamic> json) {
    return MediaFolder(
      name: json['Name'] as String,
      files: (json['Files'] as List?)?.map((e) => e as String).toList() ?? [],
    );
  }
}
