
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _userId; // Add user ID variable

  String _userName = ""; // Default name
  String _userBirthdate = ""; // Default birthdate
  String _userAddress = ""; // Default address
  String _userPhoneNumber = ""; // Default phone number
  String _userEmail = ""; // Default email address

  bool _isEditing = false;

  // Controllers for text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data from Firestore
    _fetchUserData();
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _birthdateController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    // Get current user ID
    _userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Fetch user document from Firestore
      DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(_userId).get();

      // Extract user data
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        _userName = userData['name'] ?? ""; // Get name
        _userBirthdate = userData['birthdate'] ?? ""; // Get birthdate
        _userAddress = userData['address'] ?? ""; // Get address
        _userPhoneNumber = userData['phoneNumber'] ?? ""; // Get phone number
        _userEmail = userData['email'] ?? ""; // Get email address
        // Update controllers with fetched data
        _nameController.text = _userName;
        _birthdateController.text = _userBirthdate;
        _addressController.text = _userAddress;
        _phoneNumberController.text = _userPhoneNumber;
        _emailController.text = _userEmail;
      });
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing; // Toggle editing mode
              });
            },
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
                // Replace 'assets/profile_image.jpg' with the actual path to the user's profile photo
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            _isEditing
                ? TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
                : Text(_userName),
            SizedBox(height: 20),
            Text(
              'Birthdate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            _isEditing
                ? TextField(
              controller: _birthdateController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
                : Text(_userBirthdate),
            SizedBox(height: 20),
            Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            _isEditing
                ? TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
                : Text(_userAddress),
            SizedBox(height: 20),
            Text(
              'Phone Number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            _isEditing
                ? TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
                : Text(_userPhoneNumber),
            SizedBox(height: 20),
            Text(
              'Email Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5),
            _isEditing
                ? TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            )
                : Text(_userEmail),
          ],
        ),
      ),
    );
  }
}
