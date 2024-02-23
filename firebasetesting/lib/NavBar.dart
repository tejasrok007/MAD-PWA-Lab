import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: const Text('Tejas Rokade'),
              accountEmail: const Text('tejasrok007@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(child: Image.asset(''))
              ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(image: AssetImage(''),fit: BoxFit.cover)
            ),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Upload shot'),
            onTap: () => print('upload tapped'),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Profile'),
            onTap: () => print('upload tapped'),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Placed Orders'),
            onTap: () => print('upload tapped'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Track order'),
            onTap: () => print('upload tapped'),
          ),
          ListTile(
            leading: Icon(Icons.file_upload),
            title: Text('Logout'),
            onTap: () => print('upload tapped'),
          ),

        ],
      ),
    );
  }
}
