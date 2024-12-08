// lib/screens/chat_screen.dart
import 'package:e_commerce_app/screen/chat/chat_details_screen.dart';
import 'package:e_commerce_app/widgets/chat/chat_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/models/chat_models.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  // Sample data - replace with your actual data source
  static final List<ChatConversation> _conversations = [
    ChatConversation(
      id: '1',
      name: 'Support Team',
      lastMessage: 'How can we help you today?',
      lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
      avatar: 'assets/images/c.jpg',
      isOnline: true,
      unreadCount: 1,
    ),
    ChatConversation(
      id: '2',
      name: 'Order Updates',
      lastMessage: 'Your order #1234 has been shipped!',
      lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      avatar: 'assets/images/d.jpg',
      unreadCount: 2,
    ),
    ChatConversation(
      id: '3',
      name: 'Sales Team',
      lastMessage: 'Thank you for your interest in our products',
      lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
      avatar: 'assets/images/a.jpg',
      isOnline: true,
    ),
  ];

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CupertinoSearchTextField(
        placeholder: 'Search chats',
        onChanged: (value) {
          // Handle search
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            'Chats',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.pencil_circle,
          onPressed: () {
            // Handle new chat
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverToBoxAdapter(
              child: _buildSearchBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final conversation = _conversations[index];
                  return ChatListItem(
                    conversation: conversation,
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(
                          builder: (context) => ChatDetailsScreen(
                            conversation: conversation,
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: _conversations.length,
              ),
            ),
            if (_conversations.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.chat_bubble_2,
                        size: 64,
                        color: CupertinoColors.systemGrey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No conversations yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start a new chat to get help',
                        style: TextStyle(
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
