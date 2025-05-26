import 'package:flutter/material.dart';
import 'package:food_resturant/screens/customer/order_history_screen.dart';
import 'package:food_resturant/utils/Toast.dart';
import '../../services/data_service.dart';
import '../../models/order_item.dart';
import '../../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Regular',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade50,
              Colors.white,
            ],
          ),
        ),
        child: DataService.cart.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
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
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(24),
                      itemCount: DataService.cart.length,
                      itemBuilder: (context, index) {
                        final item = DataService.cart[index];
                        return CartItemCard(
                          item: item,
                          onQuantityChanged: (newQuantity) {
                            setState(() {
                              if (newQuantity == 0) {
                                DataService.removeFromCart(item.menuItemId);
                              } else {
                                DataService.addToCart(
                                  DataService.menuItems.firstWhere((menuItem) =>
                                      menuItem.id == item.menuItemId),
                                  newQuantity - item.quantity,
                                );
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              '₹${DataService.getCartTotal().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            DataService.placeOrder(
                              DataService.cart[0].menuItemId == '1' ||
                                      DataService.cart[0].menuItemId == '2' ||
                                      DataService.cart[0].menuItemId == '3'
                                  ? '1'
                                  : DataService.cart[0].menuItemId == '4' ||
                                          DataService.cart[0].menuItemId ==
                                              '5' ||
                                          DataService.cart[0].menuItemId == '6'
                                      ? '2'
                                      : '3',
                              'customer1',
                            );
                            setState(() {});
                            Toasts().showCustomToast(
                                context,
                                'Order placed successfully!',
                                Icons.check,
                                Colors.green);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderHistoryScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Place Order',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
