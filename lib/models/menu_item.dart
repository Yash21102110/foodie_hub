class MenuItem {
  final String id;
  final String restaurantId;
  final String name;
  final double price;
  final String description;
  final String image;
  final String category;
  final bool isVeg;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    this.isVeg = true,
  });
}