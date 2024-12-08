// lib/models/chat_models.dart
class ChatConversation {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String avatar;
  final bool isOnline;
  final int unreadCount;
  final bool isMuted;

  const ChatConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.avatar,
    this.isOnline = false,
    this.unreadCount = 0,
    this.isMuted = false,
  });
}
