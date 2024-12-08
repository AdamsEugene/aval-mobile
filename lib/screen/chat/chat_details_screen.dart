// lib/screens/chat_details_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show CircleAvatar, kBottomNavigationBarHeight;
import 'package:e_commerce_app/models/chat_models.dart';
import 'package:e_commerce_app/models/chat_message.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class ChatDetailsScreen extends StatefulWidget {
  final ChatConversation conversation;

  const ChatDetailsScreen({
    super.key,
    required this.conversation,
  });

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messages.addAll([
      ChatMessage(
        id: '1',
        message: 'Hello! How can I help you today?',
        isUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: '2',
        message: 'I have a question about my order',
        isUser: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        status: MessageStatus.read,
      ),
      ChatMessage(
        id: '3',
        message:
            'Sure, I\'d be happy to help. Could you please provide your order number?',
        isUser: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 24)),
        status: MessageStatus.read,
      ),
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          id: DateTime.now().toString(),
          message: message,
          isUser: true,
          timestamp: DateTime.now(),
          status: MessageStatus.sending,
        ));
      });
      _messageController.clear();

      // Simulate response
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _messages.last = ChatMessage(
              id: _messages.last.id,
              message: _messages.last.message,
              isUser: true,
              timestamp: _messages.last.timestamp,
              status: MessageStatus.delivered,
            );
          });
        }
      });
    }
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(widget.conversation.avatar),
          ),
          const SizedBox(width: 8),
          Text(
            widget.conversation.name,
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
          ),
          if (widget.conversation.isOnline)
            Container(
              margin: const EdgeInsets.only(left: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: CupertinoColors.activeGreen,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.phone,
          onPressed: () {},
        ),
        HeaderAction(
          icon: CupertinoIcons.ellipsis_vertical,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser && _messages.indexOf(message) == 0) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(widget.conversation.avatar),
            ),
            const SizedBox(width: 8),
          ],
          if (!message.isUser && _messages.indexOf(message) != 0)
            const SizedBox(width: 40),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: message.isUser
                    ? const Color(0xFF05001E)
                    : CupertinoColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  color: message.isUser
                      ? CupertinoColors.white
                      : const Color(0xFF05001E),
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 4),
            Icon(
              message.status == MessageStatus.sending
                  ? CupertinoIcons.clock
                  : message.status == MessageStatus.sent
                      ? CupertinoIcons.checkmark
                      : message.status == MessageStatus.delivered
                          ? CupertinoIcons.checkmark_alt
                          : CupertinoIcons.checkmark_alt_circle_fill,
              size: 16,
              color: CupertinoColors.systemGrey,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        // Add padding for bottom nav bar
        bottom: MediaQuery.of(context).padding.bottom - 16,
      ),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey6,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // Handle attachment
              },
              child: const Icon(
                CupertinoIcons.plus_circle_fill,
                color: Color(0xFF05001E),
                size: 30,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CupertinoTextField(
                controller: _messageController,
                placeholder: 'Message',
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _sendMessage,
              child: const Icon(
                CupertinoIcons.arrow_up_circle_fill,
                color: Color(0xFF05001E),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        bottom: false, // Don't apply SafeArea to bottom
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildHeader(context),
                SliverPadding(
                  padding: EdgeInsets.only(
                    top: 16,
                    bottom: 16 +
                        bottomPadding +
                        keyboardPadding +
                        kBottomNavigationBarHeight +
                        80, // Add padding for input box and bottom nav
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildMessage(_messages[index]),
                      childCount: _messages.length,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildMessageInput(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildHeader(BuildContext context) {
  //   return SliverPersistentHeader(
  //     pinned: true,
  //     delegate: SliverAppBarDelegate(
  //       minHeight: 60.0,
  //       maxHeight: 60.0,
  //       child: Container(
  //         color: const Color(0xFFEEEFF1),
  //         padding: EdgeInsets.only(
  //           top: MediaQuery.of(context).padding.top,
  //         ),
  //         child: Row(
  //           children: [
  //             CupertinoButton(
  //               padding: EdgeInsets.zero,
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: const Icon(
  //                 CupertinoIcons.back,
  //                 color: Color(0xFF05001E),
  //               ),
  //             ),
  //             CircleAvatar(
  //               radius: 16,
  //               backgroundImage: AssetImage(widget.conversation.avatar),
  //             ),
  //             const SizedBox(width: 8),
  //             Expanded(
  //               child: Text(
  //                 widget.conversation.name,
  //                 style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
  //               ),
  //             ),
  //             if (widget.conversation.isOnline)
  //               Container(
  //                 margin: const EdgeInsets.only(right: 8),
  //                 width: 8,
  //                 height: 8,
  //                 decoration: BoxDecoration(
  //                   color: CupertinoColors.activeGreen,
  //                   borderRadius: BorderRadius.circular(4),
  //                 ),
  //               ),
  //             CupertinoButton(
  //               padding: EdgeInsets.zero,
  //               onPressed: () {},
  //               child: const Icon(
  //                 CupertinoIcons.phone,
  //                 color: Color(0xFF05001E),
  //               ),
  //             ),
  //             CupertinoButton(
  //               padding: EdgeInsets.zero,
  //               onPressed: () {},
  //               child: const Icon(
  //                 CupertinoIcons.ellipsis_vertical,
  //                 color: Color(0xFF05001E),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
