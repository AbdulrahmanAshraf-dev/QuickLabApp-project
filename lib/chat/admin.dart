import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicklab/chat/chat_service.dart';
import 'admin_chat.dart';

class AdminChatRoomsScreen extends StatefulWidget {
  const AdminChatRoomsScreen({super.key});

  @override
  State<AdminChatRoomsScreen> createState() => _AdminChatRoomsScreenState();
}

class _AdminChatRoomsScreenState extends State<AdminChatRoomsScreen> {
  Map<String, bool> unreadMessages = {}; // خريطة لتتبع الرسائل غير المقروءة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Rooms"),
        backgroundColor: Colors.cyan,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ChatService().getChats(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading chat rooms"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

              return ListTile(
                title: Text('$name'),
                subtitle: const Text('Tap to view conversation'),
                trailing: unreadMessages[id] == true
                    ? const Icon(Icons.circle, color: Colors.green, size: 12) // علامة للرسائل غير المقروءة
                    : null,
                onTap: () {
                  setState(() {
                    unreadMessages[id] = false; // تعيينها كـ مقروء عند فتح المحادثة
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminChat(
                        name: name,
                        id: id,
                        onMessageReceived: () {
                          setState(() {
                            unreadMessages[id] = true; // تعيينها كـ غير مقروء عند استلام رسالة جديدة
                          });
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

