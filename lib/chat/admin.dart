import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quicklab/chat/chat_service.dart';
import 'admin_chat.dart';

class AdminChatRoomsScreen extends StatefulWidget {
  const AdminChatRoomsScreen({super.key});

  @override
  State<AdminChatRoomsScreen> createState() => _AdminChatRoomsScreenState();
}

class _AdminChatRoomsScreenState extends State<AdminChatRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat Rooms",
          style: TextStyle(
              fontSize: 24.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ChatService().getChats(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading chat rooms"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(
              height: 100,
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            ));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No chat rooms available"));
          }

          var chatRooms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              var chatRoom = chatRooms[index];
              var name = chatRoom.get("name");
              var id = chatRoom.id;

              return Card(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      '$name',
                      style: TextStyle(fontSize: 24.sp, color: Colors.black),
                    ),
                    subtitle: const Text('Tap to view conversation'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminChat(
                            name: name,
                            id: id,
                          ),
                        ),
                      );
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}
