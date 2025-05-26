import 'package:flutter/material.dart';
import 'package:food_resturant/utils/Toast.dart';
import '../../services/data_service.dart';
import '../../models/order.dart';
import '../../widgets/order_card.dart';

class RestaurantOrdersScreen extends StatefulWidget {
  @override
  _RestaurantOrdersScreenState createState() => _RestaurantOrdersScreenState();
}

class _RestaurantOrdersScreenState extends State<RestaurantOrdersScreen> {
  final String restaurantId = '1'; // Assuming Pizza Plaza for demo

  @override
  Widget build(BuildContext context) {
    final orders = DataService.getOrdersByRestaurant(restaurantId);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
          ),
        ),
        child: orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No orders yet',
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 20,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(24),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderCard(
                    order: order,
                    isRestaurantView: true,
                    onStatusChanged: (newStatus) {
                      if (newStatus != null) {
                        setState(() {
                          DataService.updateOrderStatus(order.id, newStatus);
                        });
                        Toasts().showCustomToast(
                            context,
                            'Order status updated to $newStatus',
                            Icons.check,
                            Colors.green);
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}
