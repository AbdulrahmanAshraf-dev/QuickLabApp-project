import 'package:flutter/material.dart';
import 'user_details_page.dart'; // Import the UserDetailsPage

void main() {
  runApp(UserManagementApp());
}

class UserManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6C5DD3),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: UserManagementPage(),
    );
  }
}

class UserManagementPage extends StatelessWidget {
  final List<User> users = [
    User("user1", "doc", 'assets/user1.png'),
    User("user2", "doc", 'assets/user2.png'),
    User("user3", "no doc", 'assets/user3.png'),
    User("user4", "doc", 'assets/user4.png'),
    User("user5", "doc", 'assets/user5.png'),
    User("user6", "doc", 'assets/user6.png'),
    User("user7", "doc", ''),
    User("user8", "doc", ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
        backgroundColor: const Color(0xFF6C5DD3),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the UserDetailsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsPage(user: users[index]),
                        ),
                      );
                    },
                    child: UserCard(user: users[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String role;
  final String avatar;

  User(this.name, this.role, this.avatar);
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: user.avatar.isNotEmpty
                  ? AssetImage(user.avatar)
                  : null,
              child: user.avatar.isEmpty
                  ? Text(
                user.name[0],
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
                  : null,
              backgroundColor: const Color(0xFF6C5DD3),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  user.role,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
