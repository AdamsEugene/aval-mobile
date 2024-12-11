// lib/screens/notification_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      type: NotificationType.order,
      title: 'Order Shipped',
      message: 'Your order #1234 has been shipped and will arrive in 2-3 days.',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.promo,
      title: 'Flash Sale!',
      message: 'Don\'t miss out on our 24-hour flash sale. Up to 70% off!',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.system,
      title: 'Account Security',
      message: 'We noticed a new login to your account from a new device.',
      time: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
  ];

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
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
          Text(
            'Notifications',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.checkmark_circle,
          onPressed: () {
            // Mark all as read
          },
        ),
      ],
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return CupertinoIcons.cube_box_fill;
      case NotificationType.promo:
        return CupertinoIcons.tag_fill;
      case NotificationType.system:
        return CupertinoIcons.info_circle_fill;
    }
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return const Color(0xFF05001E);
      case NotificationType.promo:
        return const Color(0xFFF08D00);
      case NotificationType.system:
        return CupertinoColors.systemBlue;
    }
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Container(
      color:
          notification.isRead ? CupertinoColors.white : const Color(0xFFF8F9FA),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Handle notification tap
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      _getNotificationColor(notification.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getNotificationIcon(notification.type),
                  color: _getNotificationColor(notification.type),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF05001E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey.darkColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getTimeAgo(notification.time),
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    if (index == 0) const SizedBox(height: 8),
                    _buildNotificationItem(_notifications[index]),
                    if (index < _notifications.length - 1)
                      const Divider(height: 1),
                  ],
                ),
                childCount: _notifications.length,
              ),
            ),
            if (_notifications.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.bell_slash,
                        size: 48,
                        color: CupertinoColors.systemGrey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No notifications yet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Check back later for updates',
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

enum NotificationType {
  order,
  promo,
  system,
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final String message;
  final DateTime time;
  bool isRead;

  NotificationItem({
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}
