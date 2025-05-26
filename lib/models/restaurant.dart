class Restaurant {
  final String id;
  final String name;
  final String address;
  final String image;
  final double rating;
  final int deliveryTime;
  final List<String> categories;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.categories,
  });
}