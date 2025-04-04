import 'package:flutter/material.dart';

// Một MessageBubble để hiển thị một tin nhắn duy nhất trên ChatScreen.
class MessageBubble extends StatelessWidget {
  // Tạo một tin nhắn dạng bong bóng được coi là đầu tiên trong chuỗi tin nhắn.
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // Tạo một tin nhắn dạng bong bóng tiếp nối chuỗi tin nhắn.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  // Xác định xem tin nhắn này có phải là tin nhắn đầu tiên trong chuỗi tin nhắn
  // từ cùng một người dùng hay không.
  // Thay đổi một chút về giao diện của bong bóng tin nhắn cho các trường hợp khác nhau -
  // chỉ hiển thị hình ảnh người dùng cho tin nhắn đầu tiên từ cùng một người,
  // và thay đổi hình dạng của bong bóng cho các tin nhắn sau đó.
  final bool isFirstInSequence;

  // Hình ảnh của người dùng được hiển thị bên cạnh bong bóng tin nhắn.
  // Không bắt buộc nếu tin nhắn không phải là tin đầu tiên trong chuỗi.
  final String? userImage;

  // Tên người dùng.
  // Không bắt buộc nếu tin nhắn không phải là tin đầu tiên trong chuỗi.
  final String? username;
  final String message;

  // Điều khiển cách MessageBubble sẽ được căn chỉnh.
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            // Căn hình ảnh người dùng sang phải nếu tin nhắn là của tôi.
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage!,
              ),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          // Thêm một khoảng cách (margin) vào các cạnh của tin nhắn để tạo không gian cho
          // hình ảnh người dùng.
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            // Xác định bên của màn hình chat mà tin nhắn sẽ hiển thị.
            mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Tin nhắn đầu tiên trong chuỗi sẽ cung cấp một khoảng trống đệm ở trên.
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  // Hộp thoại bao quanh tin nhắn.
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : theme.colorScheme.secondary.withAlpha(200),
                      // Chỉ hiển thị cạnh "nói" của bong bóng tin nhắn nếu là tin đầu tiên
                      // trong chuỗi.
                      // Việc cạnh "nói" này nằm bên trái hay bên phải phụ thuộc vào việc
                      // tin nhắn là của người dùng hiện tại hay không.
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    // Đặt một số giới hạn hợp lý cho chiều rộng của bong bóng tin nhắn
                    // để nó có thể điều chỉnh dựa trên lượng văn bản cần hiển thị.
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    // Khoảng cách xung quanh bong bóng tin nhắn.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        // Thêm một chút khoảng cách giữa các dòng để văn bản trông đẹp hơn
                        // khi hiển thị nhiều dòng.
                        height: 1.3,
                        color: isMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
