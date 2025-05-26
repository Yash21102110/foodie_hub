import 'package:flutter/material.dart';
import 'package:food_resturant/screens/customer/cart_screen.dart';
import 'package:food_resturant/utils/Toast.dart';
import '../../models/restaurant.dart';
import '../../models/menu_item.dart';
import '../../services/data_service.dart';
import '../../widgets/menu_item_card.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;

  RestaurantDetailScreen({required this.restaurant});

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  List<MenuItem> menuItems = [];
  Map<String, List<MenuItem>> categorizedMenu = {};

  @override
  void initState() {
    super.initState();
    loadMenu();
  }

  void loadMenu() {
    menuItems = DataService.getMenuByRestaurant(widget.restaurant.id);
    categorizedMenu = {};
    for (var item in menuItems) {
      if (!categorizedMenu.containsKey(item.category)) {
        categorizedMenu[item.category] = [];
      }
      categorizedMenu[item.category]!.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.orange,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade300,
                      Colors.deepOrange.shade400
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant,
                      size: 80,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.restaurant.name,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.restaurant.address,
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins-Regular',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 16),
                  ...categorizedMenu.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 12),
                        ...entry.value.map((item) => MenuItemCard(
                              item: item,
                              onAdd: () {
                                setState(() {
                                  DataService.addToCart(item, 1);
                                });
                                Toasts().showCustomToast(
                                    context,
                                    '${item.name} added to cart',
                                    Icons.check,
                                    Colors.green);
                              },
                            )),
                        SizedBox(height: 24),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: DataService.cart.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              label: Text('View Cart (${DataService.cart.length})',
                  style: TextStyle(fontFamily: 'Poppins-Regular')),
              icon: Icon(Icons.shopping_cart),
              backgroundColor: Colors.orange,
            )
          : null,
    );
  }
}
