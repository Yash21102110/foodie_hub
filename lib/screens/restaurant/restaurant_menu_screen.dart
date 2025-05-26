import 'package:flutter/material.dart';
import 'package:food_resturant/utils/Toast.dart';
import '../../services/data_service.dart';
import '../../models/menu_item.dart';
import '../../widgets/menu_item_card.dart';

class RestaurantMenuScreen extends StatefulWidget {
  @override
  _RestaurantMenuScreenState createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  final String restaurantId = '1'; // Assuming Pizza Plaza for demo
  List<MenuItem> menuItems = [];

  @override
  void initState() {
    super.initState();
    menuItems = DataService.getMenuByRestaurant(restaurantId);
  }

  void _showAddMenuItemDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    bool isVeg = true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Menu Item',
            style: TextStyle(fontFamily: 'Poppins-Regular')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
              ),
              TextField(
                controller: priceController,
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins-Regular',
                    )),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
              ),
              TextField(
                controller: categoryController,
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                Text('Cancel', style: TextStyle(fontFamily: 'Poppins-Regular')),
          ),
          TextButton(
            onPressed: () {
              final newItem = MenuItem(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                restaurantId: restaurantId,
                name: nameController.text,
                price: double.parse(priceController.text),
                description: descriptionController.text,
                image: 'https://via.placeholder.com/150',
                category: categoryController.text,
                isVeg: isVeg,
              );
              setState(() {
                DataService.addMenuItem(newItem);
                menuItems = DataService.getMenuByRestaurant(restaurantId);
              });
              Navigator.pop(context);
              Toasts().showCustomToast(
                  context, 'Menu item added', Icons.check, Colors.green);
            },
            child: Text('Add', style: TextStyle(fontFamily: 'Poppins-Regular')),
          ),
        ],
      ),
    );
  }

  void _showEditMenuItemDialog(MenuItem item) {
    final nameController = TextEditingController(text: item.name);
    final priceController = TextEditingController(text: item.price.toString());
    final descriptionController = TextEditingController(text: item.description);
    final categoryController = TextEditingController(text: item.category);
    bool isVeg = item.isVeg;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Menu Item',
            style: TextStyle(fontFamily: 'Poppins-Regular')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
              ),
              TextField(
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                controller: priceController,
                decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
                keyboardType: TextInputType.number,
              ),
              TextField(
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                controller: descriptionController,
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
              ),
              TextField(
                controller: categoryController,
                style: TextStyle(fontFamily: 'Poppins-Regular'),
                decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(fontFamily: 'Poppins-Regular')),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                Text('Cancel', style: TextStyle(fontFamily: 'Poppins-Regular')),
          ),
          TextButton(
            onPressed: () {
              final updatedItem = MenuItem(
                id: item.id,
                restaurantId: item.restaurantId,
                name: nameController.text,
                price: double.parse(priceController.text),
                description: descriptionController.text,
                image: item.image,
                category: categoryController.text,
                isVeg: isVeg,
              );
              setState(() {
                DataService.updateMenuItem(updatedItem);
                menuItems = DataService.getMenuByRestaurant(restaurantId);
              });
              Navigator.pop(context);
              Toasts().showCustomToast(
                  context, 'Menu item updated', Icons.check, Colors.green);
            },
            child:
                Text('Update', style: TextStyle(fontFamily: 'Poppins-Regular')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          padding: EdgeInsets.all(24),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return MenuItemCard(
              item: item,
              onEdit: () => _showEditMenuItemDialog(item),
              onDelete: () {
                setState(() {
                  DataService.deleteMenuItem(item.id);
                  menuItems = DataService.getMenuByRestaurant(restaurantId);
                });
                Toasts().showCustomToast(
                    context, 'Menu item deleted', Icons.check, Colors.red);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMenuItemDialog,
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
