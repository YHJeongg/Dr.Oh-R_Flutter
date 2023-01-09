class NewsModel {
  late String title;
  late String description;

  NewsModel({
    required this.title,
    required this.description,
  });

  NewsModel.fromMap(Map<String, dynamic>? map) {
    title = map?['title'] ?? '';
    description = map?['description'] ?? '';
  }
}
