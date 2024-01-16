class Topic {
  final String id;
  final String courseId;
  final int? orderCourse;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final String? videoUrl;
  final String? type;
  final String? numberOfPages;
  final String? beforeTheClassNotes;
  final String? afterTheClassNotes;
  final String? nameFile;

  const Topic({
    required this.id,
    required this.courseId,
    this.orderCourse,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.videoUrl,
    this.type,
    this.numberOfPages,
    this.beforeTheClassNotes,
    this.afterTheClassNotes,
    this.nameFile,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      courseId: json['courseId'],
      orderCourse: json['orderCourse'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      videoUrl: json['videoUrl'],
      type: json['type'],
      numberOfPages: json['numberOfPages'],
      beforeTheClassNotes: json['beforeTheClassNotes'],
      afterTheClassNotes: json['afterTheClassNotes'],
      nameFile: json['nameFile'],
    );
  }
}
