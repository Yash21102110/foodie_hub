import '../models/restaurant.dart';
import '../models/menu_item.dart';
import '../models/order_item.dart';
import '../models/order.dart';

class DataService {
  static List<Restaurant> restaurants = [
    Restaurant(
      id: '1',
      name: 'Pizza Plaza',
      address: '123 Main Street',
      image:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=300&h=200&fit=crop',
      rating: 4.5,
      deliveryTime: 30,
      categories: ['Italian', 'Pizza'],
    ),
    Restaurant(
      id: '2',
      name: 'Burger Barn',
      address: '456 Oak Avenue',
      image:
          'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300&h=200&fit=crop',
      rating: 4.2,
      deliveryTime: 25,
      categories: ['American', 'Burgers'],
    ),
    Restaurant(
      id: '3',
      name: 'Spice Garden',
      address: '789 Curry Lane',
      image:
          'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=300&h=200&fit=crop',
      rating: 4.7,
      deliveryTime: 35,
      categories: ['Indian', 'Curry'],
    ),
  ];

  static List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      restaurantId: '1',
      name: 'Margherita Pizza',
      price: 299,
      description: 'Fresh tomatoes, mozzarella, basil',
      image:
          'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=300&h=200&fit=crop',
      category: 'Pizza',
      isVeg: true,
    ),
    MenuItem(
      id: '2',
      restaurantId: '1',
      name: 'Pepperoni Pizza',
      price: 399,
      description: 'Pepperoni, mozzarella, tomato sauce',
      image:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=300&h=200&fit=crop',
      category: 'Pizza',
      isVeg: false,
    ),
    MenuItem(
      id: '3',
      restaurantId: '1',
      name: 'Garlic Bread',
      price: 149,
      description: 'Freshly baked bread with garlic butter',
      image:
          'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=300&h=200&fit=crop',
      category: 'Appetizers',
      isVeg: true,
    ),
    MenuItem(
      id: '4',
      restaurantId: '2',
      name: 'Classic Burger',
      price: 249,
      description: 'Beef patty, lettuce, tomato, onion',
      image:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=200&fit=crop',
      category: 'Burgers',
      isVeg: false,
    ),
    MenuItem(
      id: '5',
      restaurantId: '2',
      name: 'Chicken Deluxe',
      price: 299,
      description: 'Grilled chicken, special sauce, cheese',
      image:
          'https://images.unsplash.com/photo-1606755962773-d324e9a13086?w=300&h=200&fit=crop',
      category: 'Burgers',
      isVeg: false,
    ),
    MenuItem(
      id: '6',
      restaurantId: '2',
      name: 'French Fries',
      price: 99,
      description: 'Crispy golden fries',
      image:
          'https://images.unsplash.com/photo-1576107232684-1279f390859f?w=300&h=200&fit=crop',
      category: 'Sides',
      isVeg: true,
    ),
    MenuItem(
      id: '7',
      restaurantId: '3',
      name: 'Chicken Tikka Masala',
      price: 349,
      description: 'Tender chicken in creamy tomato curry',
      image:
          'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=300&h=200&fit=crop',
      category: 'Main Course',
      isVeg: false,
    ),
    MenuItem(
      id: '8',
      restaurantId: '3',
      name: 'Paneer Butter Masala',
      price: 299,
      description: 'Cottage cheese in rich butter curry',
      image:
          'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=300&h=200&fit=crop',
      category: 'Main Course',
      isVeg: true,
    ),
    MenuItem(
      id: '9',
      restaurantId: '3',
      name: 'Basmati Rice',
      price: 149,
      description: 'Fragrant long-grain basmati rice',
      image:
          'https://images.unsplash.com/photo-1596560548464-f010549b84d7?w=300&h=200&fit=crop',
      category: 'Rice',
      isVeg: true,
    ),
  ];

  static List<Order> orders = [
    Order(
      id: '1',
      restaurantId: '1',
      restaurantName: 'Pizza Plaza',
      customerId: 'customer1',
      items: [
        OrderItem(
          menuItemId: '1',
          name: 'Margherita Pizza',
          price: 299,
          quantity: 2,
          image:
              'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=300&h=200&fit=crop',
        ),
      ],
      status: 'preparing',
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      totalAmount: 598,
    ),
    Order(
      id: '2',
      restaurantId: '2',
      restaurantName: 'Burger Barn',
      customerId: 'customer1',
      items: [
        OrderItem(
          menuItemId: '4',
          name: 'Classic Burger',
          price: 249,
          quantity: 1,
          image:
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=200&fit=crop',
        ),
        OrderItem(
          menuItemId: '6',
          name: 'French Fries',
          price: 99,
          quantity: 1,
          image:
              'https://images.unsplash.com/photo-1576107232684-1279f390859f?w=300&h=200&fit=crop',
        ),
      ],
      status: 'ready',
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      totalAmount: 348,
    ),
  ];

  static List<OrderItem> cart = [];

  static void addToCart(MenuItem item, int quantity) {
    final existingIndex =
        cart.indexWhere((cartItem) => cartItem.menuItemId == item.id);
    if (existingIndex >= 0) {
      cart[existingIndex] = OrderItem(
        menuItemId: item.id,
        name: item.name,
        price: item.price,
        quantity: cart[existingIndex].quantity + quantity,
        image: item.image,
      );
    } else {
      cart.add(OrderItem(
        menuItemId: item.id,
        name: item.name,
        price: item.price,
        quantity: quantity,
        image: item.image,
      ));
    }
  }

  static void removeFromCart(String menuItemId) {
    cart.removeWhere((item) => item.menuItemId == menuItemId);
  }

  static void clearCart() {
    cart.clear();
  }

  static double getCartTotal() {
    return cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  static List<MenuItem> getMenuByRestaurant(String restaurantId) {
    return menuItems
        .where((item) => item.restaurantId == restaurantId)
        .toList();
  }

  static List<Order> getOrdersByCustomer(String customerId) {
    return orders.where((order) => order.customerId == customerId).toList();
  }

  static List<Order> getOrdersByRestaurant(String restaurantId) {
    return orders.where((order) => order.restaurantId == restaurantId).toList();
  }

  static void updateOrderStatus(String orderId, String status) {
    final orderIndex = orders.indexWhere((order) => order.id == orderId);
    if (orderIndex >= 0) {
      orders[orderIndex] = Order(
        id: orders[orderIndex].id,
        restaurantId: orders[orderIndex].restaurantId,
        restaurantName: orders[orderIndex].restaurantName,
        customerId: orders[orderIndex].customerId,
        items: orders[orderIndex].items,
        status: status,
        timestamp: orders[orderIndex].timestamp,
        totalAmount: orders[orderIndex].totalAmount,
      );
    }
  }

  static void placeOrder(String restaurantId, String customerId) {
    if (cart.isEmpty) return;

    final restaurant = restaurants.firstWhere((r) => r.id == restaurantId);
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      restaurantId: restaurantId,
      restaurantName: restaurant.name,
      customerId: customerId,
      items: List.from(cart),
      status: 'pending',
      timestamp: DateTime.now(),
      totalAmount: getCartTotal(),
    );

    orders.add(order);
    clearCart();
  }

  static void addMenuItem(MenuItem item) {
    menuItems.add(item);
  }

  static void updateMenuItem(MenuItem updatedItem) {
    final index = menuItems.indexWhere((item) => item.id == updatedItem.id);
    if (index >= 0) {
      menuItems[index] = updatedItem;
    }
  }

  static void deleteMenuItem(String menuItemId) {
    menuItems.removeWhere((item) => item.id == menuItemId);
  }
}
