import 'package:flutter/material.dart';
import '../../models/order_item.dart';
import '../../services/data_service.dart';

class CartItemCard extends StatelessWidget {
  final OrderItem item;
  final Function(int) onQuantityChanged;

  CartItemCard({required this.item, required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade200, Colors.orange.shade300],
                ),
              ),
              child: Icon(
                Icons.fastfood,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '₹${item.price.toStringAsFixed(2)} x ${item.quantity}',
                  style: TextStyle(
                    fontFamily: 'Poppins-Regular',
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => onQuantityChanged(item.quantity - 1),
                icon: Icon(Icons.remove_circle, color: Colors.red),
              ),
              Text(
                '${item.quantity}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              IconButton(
                onPressed: () => onQuantityChanged(item.quantity + 1),
                icon: Icon(Icons.add_circle, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
