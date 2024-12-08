// lib/models/chat_message.dart
class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;
  final MessageStatus status;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
    this.status = MessageStatus.sent,
  });
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}
