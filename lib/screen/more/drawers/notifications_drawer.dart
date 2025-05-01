import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  bool isRead;
  final String? actionText;
  final VoidCallback? onAction;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
    this.actionText,
    this.onAction,
  });

  Color get typeColor {
    switch (type) {
      case NotificationType.order:
        return const Color(0xFFFF9800);
      case NotificationType.payment:
        return const Color(0xFF4CAF50);
      case NotificationType.promo:
        return const Color(0xFFE91E63);
      case NotificationType.delivery:
        return const Color(0xFF3F51B5);
      case NotificationType.system:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData get typeIcon {
    switch (type) {
      case NotificationType.order:
        return CupertinoIcons.cube_box_fill;
      case NotificationType.payment:
        return CupertinoIcons.money_dollar_circle_fill;
      case NotificationType.promo:
        return CupertinoIcons.tag_fill;
      case NotificationType.delivery:
        return CupertinoIcons.cart_fill;
      case NotificationType.system:
        return CupertinoIcons.bell_fill;
    }
  }
}

enum NotificationType {
  order,
  payment,
  promo,
  delivery,
  system,
}

class NotificationsDrawer extends StatefulWidget {
  const NotificationsDrawer({super.key});

  @override
  State<NotificationsDrawer> createState() => _NotificationsDrawerState();
}

class _NotificationsDrawerState extends State<NotificationsDrawer> {
  // Sample notifications
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Order Shipped',
      message: 'Your order #BD7452 has been shipped and is on its way!',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.order,
      actionText: 'Track',
      onAction: () {},
    ),
    NotificationModel(
      id: '2',
      title: 'Payment Received',
      message: 'We have received your payment of \$124.99 for order #BD7452.',
      time: DateTime.now().subtract(const Duration(hours: 5)),
      type: NotificationType.payment,
      isRead: true,
    ),
    NotificationModel(
      id: '3',
      title: 'Weekend Sale!',
      message: 'Enjoy 25% off on all products this weekend. Use code WEEKEND25.',
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.promo,
      actionText: 'Shop Now',
      onAction: () {},
    ),
    NotificationModel(
      id: '4',
      title: 'Delivery Attempted',
      message: 'Delivery of your order #BD7452 was attempted but nobody was available. We will try again tomorrow.',
      time: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.delivery,
      actionText: 'Reschedule',
      onAction: () {},
    ),
    NotificationModel(
      id: '5',
      title: 'App Update Available',
      message: 'A new version of the app is available with exciting new features.',
      time: DateTime.now().subtract(const Duration(days: 3)),
      type: NotificationType.system,
      isRead: true,
      actionText: 'Update',
      onAction: () {},
    ),
  ];

  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
  }

  int get _unreadCount => _notifications.where((notification) => !notification.isRead).length;

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      leadingAction: DrawerAction(
        text: 'Close',
        textColor: const Color(0xFF3F51B5),
        fontWeight: FontWeight.w600,
        fontSize: 16,
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: _unreadCount > 0
          ? DrawerAction(
              text: 'Mark all read',
              textColor: const Color(0xFF3F51B5),
              fontWeight: FontWeight.w600,
              onTap: _markAllAsRead,
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF05001E),
                  ),
                ),
                if (_unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F51B5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_unreadCount new',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _notifications.isEmpty
                ? const Center(
                    child: Text(
                      'No notifications yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _notifications.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return GestureDetector(
      onTap: () {
        if (!notification.isRead) {
          setState(() {
            notification.isRead = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead
              ? CupertinoColors.white
              : notification.typeColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead
                ? CupertinoColors.systemGrey5
                : notification.typeColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: notification.typeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        notification.typeIcon,
                        color: notification.typeColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Title and message
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  notification.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: notification.isRead
                                        ? FontWeight.w500
                                        : FontWeight.w700,
                                    color: const Color(0xFF05001E),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                _formatTimeAgo(notification.time),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: CupertinoColors.systemGrey.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.message,
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF05001E).withOpacity(0.7),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Action button if available
                if (notification.actionText != null && notification.onAction != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 40),
                    child: GestureDetector(
                      onTap: notification.onAction,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: notification.typeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          notification.actionText!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: notification.typeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            
            // Unread indicator
            if (!notification.isRead)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: notification.typeColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
