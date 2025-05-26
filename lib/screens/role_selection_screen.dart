import 'package:flutter/material.dart';
import 'customer/customer_home_screen.dart';
import 'restaurant/restaurant_dashboard.dart';
import '../widgets/role_card.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to FoodieHub',
                  style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Choose your role to continue',
                  style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
                RoleCard(
                  title: 'Customer',
                  subtitle: 'Browse restaurants and place orders',
                  icon: Icons.person,
                  color: Colors.blue,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerHomeScreen()),
                  ),
                ),
                SizedBox(height: 24),
                RoleCard(
                  title: 'Restaurant',
                  subtitle: 'Manage your menu and orders',
                  icon: Icons.restaurant_menu,
                  color: Colors.green,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestaurantDashboard()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
