import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quicklab/chat/chat_model.dart';

class ChatService {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> sendMessage(String receiverId, var message,String senderId) async {
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    ChatModel chatModel = ChatModel(
      senderId: senderId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .doc()
        .set(chatModel.toMap());
  }

  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child("chat_images/$fileName");
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Stream<QuerySnapshot> getMessage(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }


  Stream<QuerySnapshot> getChat(String id) {
    List<String> ids = ["Iel99WLRjIQ9PIqHTdtM",id ];
    ids.sort();
    String chatRoomId = ids.join('_');
    return fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
  Stream<QuerySnapshot> getChats() {
    return fireStore
        .collection("users").snapshots();
  }
}
