import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart'; // Add this import

class ManufacturerChat extends StatefulWidget {
  const ManufacturerChat({super.key});

  @override
  State<ManufacturerChat> createState() => _ManufacturerChatState();
}

class _ManufacturerChatState extends State<ManufacturerChat> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isChatExpanded = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          message: _messageController.text,
          isUser: true,
          timestamp: DateTime.now(),
        ));
        // Simulate manufacturer response
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _messages.add(ChatMessage(
                message:
                    "Thank you for your message. Our team will review your request and respond shortly.",
                isUser: false,
                timestamp: DateTime.now(),
              ));
            });
          }
        });
      });
      _messageController.clear();
    }
  }

  void _showFullscreenChat(BuildContext context) {
    BaseDrawer.show(
      context: context,
      height: MediaQuery.of(context).size.height * 0.9,
      leadingAction: DrawerAction(
        icon: const Icon(CupertinoIcons.xmark),
        onTap: () => Navigator.pop(context),
      ),
      child: Column(
        children: [
          const Text(
            'Chat with Manufacturer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: message.isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? const Color(0xFF05001E)
                                : const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            message.message,
                            style: TextStyle(
                              color: message.isUser
                                  ? CupertinoColors.white
                                  : const Color(0xFF05001E),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              border: Border(
                top: BorderSide(color: CupertinoColors.systemGrey5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: _messageController,
                    placeholder: 'Type your message...',
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF05001E),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.arrow_up,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with maximize button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () =>
                      setState(() => _isChatExpanded = !_isChatExpanded),
                  child: Row(
                    children: [
                      const Text(
                        'Chat with Manufacturer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF05001E),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        _isChatExpanded
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        color: const Color(0xFF05001E),
                      ),
                    ],
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.fullscreen,
                  color: Color(0xFF05001E),
                ),
                onPressed: () => _showFullscreenChat(context),
              ),
            ],
          ),

          // Expandable chat content
          if (_isChatExpanded) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: message.isUser
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.6,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: message.isUser
                                        ? const Color(0xFF05001E)
                                        : const Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    message.message,
                                    style: TextStyle(
                                      color: message.isUser
                                          ? CupertinoColors.white
                                          : const Color(0xFF05001E),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CupertinoTextField(
                            controller: _messageController,
                            placeholder: 'Type your message...',
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: null,
                          ),
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          onPressed: _sendMessage,
                          child: const Icon(
                            CupertinoIcons.arrow_up_circle_fill,
                            color: Color(0xFF05001E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });
}
