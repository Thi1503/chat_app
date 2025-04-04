import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    // Yêu cầu quyền thông báo từ người dùng
    await fcm.requestPermission();

    // đăng ký thiết bị hiện tại để nhận các thông báo thuộc chủ đề (topic) có tên là 'chat'
    fcm.subscribeToTopic('chat');

    // Lấy token từ Firebase và cần await
    final token = await fcm.getToken(); // Thêm await ở đây

    print('Token của bạn: $token');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat App'),
        actions: [
          //xử lý việc đăng xuất
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(child: ChatMessages()),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
