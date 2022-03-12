import 'dart:convert';

class Video {
  final String id;
  final String title;
  final String thumb;
  final String chanel;

  Video({
    required this.id,
    required this.title,
    required this.thumb,
    required this.chanel,
  });

  Video copyWith({
    String? id,
    String? title,
    String? thumb,
    String? chanel,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
      chanel: chanel ?? this.chanel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumb': thumb,
      'chanel': chanel,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      thumb: map['thumb'] ?? '',
      chanel: map['chanel'] ?? '',
    );
  }

  factory Video.fromMapYoutube(Map<String, dynamic> map) {
    return Video(
      id: map['id']['videoId'] ?? '',
      title: map['snippet']['title'] ?? '',
      thumb: map['snippet']['thumbnails']['high']['url'] ?? '',
      chanel: map['snippet']['channelTitle'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Video(id: $id, title: $title, thumb: $thumb, chanel: $chanel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Video && other.id == id && other.title == title && other.thumb == thumb && other.chanel == chanel;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ thumb.hashCode ^ chanel.hashCode;
  }
}
