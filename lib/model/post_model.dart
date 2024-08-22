class PostModel {
  final String image;
  final String title;
  final String description;
  bool isLiked;
  bool isFile;

  PostModel({
    required this.image,
    required this.title,
    required this.description,
    this.isLiked = false,
    this.isFile = false,
  });
}
