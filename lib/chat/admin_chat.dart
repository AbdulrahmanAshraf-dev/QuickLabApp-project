import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quicklab/chat/chat_bubble.dart';
import 'package:quicklab/chat/chat_service.dart';

class AdminChat extends StatefulWidget {
  const AdminChat({super.key, required this.id, this.name});

  final String id;
  final String? name;

  @override
  State<AdminChat> createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat> {
  final TextEditingController messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();


  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.id, messageController.text, "Iel99WLRjIQ9PIqHTdtM");
      messageController.clear();
      _scrollToBottom();
    }
  }

  Future<void> sendImage(File image) async {
    String imageUrl = await _chatService.uploadImage(image);
    await _chatService.sendMessage(widget.id, imageUrl, "Iel99WLRjIQ9PIqHTdtM");
    _scrollToBottom();
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera),
                  title: const Text("Camera"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    XFile? image = await pickImage(ImageSource.camera);
                    if (image != null) {
                      sendImage(File(image.path));
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Gallery"),
                  onTap: () async {
                    Navigator.of(context).pop();
                    XFile? image = await pickImage(ImageSource.gallery);
                    if (image != null) {
                      sendImage(File(image.path));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.grey, width: 3)),
          child: Text(
            widget.name ?? "Chat",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessage("Iel99WLRjIQ9PIqHTdtM", widget.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(child: SizedBox(
        width: 30.w,  // Set the width
        height: 30.h,  // Set the height
        child: const CircularProgressIndicator(
        color: Colors.cyan,
        ),
        ),
        );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == "Iel99WLRjIQ9PIqHTdtM";
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (data['message'].toString().startsWith('http'))
            Image.network(data['message'], width: 200, height: 200),
          if (!data['message'].toString().startsWith('http'))
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: messageController,
              decoration: const InputDecoration(
                fillColor: Color(0xFFE0E0E0),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                hintText: "Type a message",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
            child: IconButton(
              onPressed: () {
                showImageSourceDialog(context);
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<XFile?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);
    return image;
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    }
  }
}
