import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin người dùng hiện tại từ Firebase Authentication
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      // Lấy dữ liệu tin nhắn từ Firestore và sắp xếp theo thời gian tạo (mới nhất trước)
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        // Hiển thị vòng tròn tải nếu dữ liệu đang được tải từ Firestore
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Kiểm tra nếu không có dữ liệu hoặc bộ sưu tập rỗng
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found. '),
          );
        }

        // Xử lý lỗi trong quá trình lấy dữ liệu từ Firestore
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        // Lưu tất cả các tin nhắn đã lấy từ Firestore
        final loadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse:
              true, // Đảo ngược danh sách để hiển thị tin nhắn mới nhất ở trên cùng
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            // Lấy dữ liệu của tin nhắn hiện tại
            final chatMessage = loadedMessages[index].data();

            // Lấy dữ liệu của tin nhắn tiếp theo (nếu có) để kiểm tra xem nó có cùng người gửi hay không
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;

            // Lấy ID của người gửi tin nhắn hiện tại
            final currentMessageUserId = chatMessage['userId'];

            // Lấy ID của người gửi tin nhắn tiếp theo (nếu tồn tại)
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;

            // Kiểm tra xem tin nhắn hiện tại và tiếp theo có phải của cùng một người không
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            if (nextUserIsSame) {
              // Nếu người gửi giống nhau, hiển thị dưới dạng tiếp nối (MessageBubble.next)
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            } else {
              // Nếu người gửi khác nhau, hiển thị với thông tin người dùng (MessageBubble.first)
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
