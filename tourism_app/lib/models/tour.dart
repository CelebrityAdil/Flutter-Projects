class Tour {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final String shortDescription;
  final String description;
  final double rating;
  final double price;
  final int durationDays;

  Tour({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.shortDescription,
    required this.description,
    required this.rating,
    required this.price,
    required this.durationDays,
  });
}
