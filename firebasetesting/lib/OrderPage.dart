import 'package:firebasetesting/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:firebasetesting/Parallaxpage.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/card_image_2.jpeg',
              height: 400.0,
              width: 375.0,
              fit: BoxFit.cover,
            ),
            Text(
              'Card 1',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Super tasty and healthy food',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement action on button press
                // For example, you can navigate back to the previous page
                // Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              child: Text('Add Order'),
            ),
          ],
        ),
      ),
    );
  }
}
