class Lesson {
  String id;
  String courseId;
  String title;
  String description;
  String videoUrl;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      courseId: json['courseId'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
    };
  }
}
