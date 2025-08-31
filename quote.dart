class Quote {
  final String text;
  final String author;
  final String category;
  int likes;

  Quote({
    required this.text,
    required this.author,
    required this.category,
    DateTime? createdAt,
    this.likes = 0,
  });
}