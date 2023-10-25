class Comic {
  String name;
  String cover;
  List<Chapter> chapters;

  Comic({required this.name, required this.cover, required this.chapters});

  // I use dynamic here because the compiler complains when I use it in a map function
  factory Comic.fromJson(dynamic json) {
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

class PictureFolder {
  String name;
  List<String> files;

  PictureFolder({required this.name, required this.files});

  factory PictureFolder.fromJson(dynamic json) {
    return PictureFolder(
      name: json['Name'] as String,
      files: (json['Files'] as List?)?.map((e) => e as String).toList() ?? [],
    );
  }
}

class Video {
  String name;
  String url;
  String category;
  String thumbnail = "";
  int views = 0;

  Video({required this.name, required this.url, required this.category});

  factory Video.fromJson(dynamic json) {
    return Video(
      name: json['Name'] as String,
      url: json['Url'] as String,
      category: json['Category'] as String,
    );
  }
}
