class Category {
  final String id;
  final String title;
  final String key;
  final String? displayOrder;
  final String? createdAt;
  final String? updatedAt;

  const Category({
    required this.id,
    required this.title,
    required this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      key: json['key'],
      displayOrder: json['displayOrder'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
