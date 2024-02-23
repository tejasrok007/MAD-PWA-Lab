import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _costController = TextEditingController();
  TextEditingController _discountController = TextEditingController();

  String _imageUrl = '';
  bool _isUploading = false;

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Upload image to Firebase Storage
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('product_images')
            .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');

        await ref.putFile(File(pickedFile.path));

        // Get image download URL
        _imageUrl = await ref.getDownloadURL();
      }

      setState(() {
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      // Handle image upload error
      print('Failed to upload image: $e');
    }
  }

  Future<void> _addProductToDatabase() async {
    // Add product details to Firestore database
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        'cost': double.parse(_costController.text.trim()),
        'discount': double.parse(_discountController.text.trim()),
        'imageUrl': _imageUrl,
      });

      // Clear text fields after adding product
      _nameController.clear();
      _descriptionController.clear();
      _costController.clear();
      _discountController.clear();
      _imageUrl = '';

      // Show success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully')),
      );
    } catch (e) {
      // Handle error adding product to database
      print('Failed to add product: $e');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _uploadImage,
              child: Container(
                width: double.infinity,
                height: 150.0,
                color: Colors.grey[200],
                child: _isUploading
                    ? Center(child: CircularProgressIndicator())
                    : (_imageUrl.isNotEmpty
                    ? Image.network(_imageUrl, fit: BoxFit.cover)
                    : Center(child: Icon(Icons.add_a_photo))),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _costController,
              decoration: InputDecoration(labelText: 'Cost'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _discountController,
              decoration: InputDecoration(labelText: 'Discount Percentage'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addProductToDatabase,
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
