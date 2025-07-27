class PostModel {
  String title;
  String content;
  String? image;

  PostModel({required this.title, required this.content, this.image});

  factory PostModel.fromJson(Map json) {
    return PostModel(
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}
