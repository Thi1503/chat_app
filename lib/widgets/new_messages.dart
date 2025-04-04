import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});
  @override
  State<NewMessages> createState() {
    return _NewMessagesState();
  }
}

class _NewMessagesState extends State<NewMessages> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Lắng nghe sự thay đổi trong text field để cập nhật màu icon
    _messageController.addListener(() {
      setState(() {});
    });
  }

  // Xử lý việc gửi tin nhắn
  void _submitMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    //send to Firebase
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 2, top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              minLines: 1,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                labelText: 'Send a massage...',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          IconButton(
            // Xử lý việc gửi tin nhắn
            onPressed: _submitMessage,
            icon: Icon(
              Icons.send,
              color:
                  _messageController.text.isEmpty ? Colors.grey : Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
