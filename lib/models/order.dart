import 'package:food_resturant/models/order_item.dart';

class Order {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String customerId;
  final List<OrderItem> items;
  final String status;
  final DateTime timestamp;
  final double totalAmount;

  Order({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.customerId,
    required this.items,
    required this.status,
    required this.timestamp,
    required this.totalAmount,
  });
}
