class TutorCourse {
  final String userId;
  final String courseId;
  final String createdAt;
  final String updatedAt;

  const TutorCourse({
    required this.userId,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TutorCourse.fromJson(Map<String, dynamic> json) {
    return TutorCourse(
      userId: json['UserId'],
      courseId: json['CourseId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
