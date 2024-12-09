// lib/widgets/chat/chat_list_item.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar; // Add this import
import 'package:e_commerce_app/models/chat_models.dart';
import 'package:e_commerce_app/utils/date_formatter.dart';

class ChatListItem extends StatelessWidget {
  final ChatConversation conversation;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          // color: CupertinoColors.white,
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(conversation.avatar),
                ),
                if (conversation.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeGreen,
                        border: Border.all(
                          color: CupertinoColors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Chat details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conversation.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatChatTime(conversation.lastMessageTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: conversation.unreadCount > 0
                              ? const Color(0xFF05001E)
                              : CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: conversation.unreadCount > 0
                                ? const Color(0xFF05001E)
                                : CupertinoColors.systemGrey,
                            fontWeight: conversation.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.unreadCount > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF05001E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            conversation.unreadCount.toString(),
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      if (conversation.isMuted)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            CupertinoIcons.bell_slash_fill,
                            size: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
