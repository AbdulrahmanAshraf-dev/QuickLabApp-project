import 'package:flutter/material.dart';
import 'users.dart'; // Import the main file for the User class

class UserDetailsPage extends StatelessWidget {
  final User user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} Details'),
        backgroundColor: const Color(0xFF6C5DD3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: user.avatar.isNotEmpty
                    ? AssetImage(user.avatar)
                    : null,
                child: user.avatar.isEmpty
                    ? Text(
                  user.name[0],
                  style: TextStyle(fontSize: 50, color: Colors.white),
                )
                    : null,
                backgroundColor: const Color(0xFF6C5DD3),
              ),
            ),
            SizedBox(height: 20),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6C5DD3),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            // User details with icons
            _buildDetailRow(Icons.phone, 'Phone:', '+123456789'), // Replace with real data
            _buildDetailRow(Icons.calendar_today, 'Age:', '29'), // Replace with real data
            _buildXrayRequests(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C5DD3), size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXrayRequests() {
    // Example X-ray requests. You can replace this with real data.
    final List<String> xrayRequests = [
      'Chest X-ray',
      'Abdominal X-ray',
      'Knee X-ray',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.medical_services, color: const Color(0xFF6C5DD3), size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'X-rays Requested:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 5),
                ...xrayRequests.map((xray) => Text(
                  xray,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
