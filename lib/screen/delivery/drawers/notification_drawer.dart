// lib/screen/delivery/drawers/notification_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.8,
      // title: 'Notifications',
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Mark All Read',
        textColor: CupertinoColors.activeBlue,
        onTap: () {},
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildNotificationGroup('Today'),
                _buildNotificationItem(
                  title: 'Package Out for Delivery',
                  message: 'Your package AVL1234567 is out for delivery.',
                  time: '10:30 AM',
                  icon: CupertinoIcons.cube_box,
                  iconColor: CupertinoColors.activeOrange,
                  isUnread: true,
                ),
                _buildNotificationItem(
                  title: 'Delivery Successfully Completed',
                  message: 'Your package AVL8765432 has been delivered.',
                  time: '08:15 AM',
                  icon: CupertinoIcons.checkmark_circle,
                  iconColor: CupertinoColors.activeGreen,
                  isUnread: true,
                ),
                _buildNotificationGroup('Yesterday'),
                _buildNotificationItem(
                  title: 'Package In Transit',
                  message: 'Your package AVL1234567 is now in transit.',
                  time: '03:45 PM',
                  icon: CupertinoIcons.arrow_2_circlepath,
                  iconColor: CupertinoColors.systemBlue,
                  isUnread: false,
                ),
                _buildNotificationItem(
                  title: 'Order Confirmation',
                  message: 'Your order AVL1234567 has been confirmed.',
                  time: '11:20 AM',
                  icon: CupertinoIcons.doc_checkmark,
                  iconColor: CupertinoColors.systemGreen,
                  isUnread: false,
                ),
                _buildNotificationGroup('Older'),
                _buildNotificationItem(
                  title: 'Special Offer',
                  message: 'Get 20% off on your next delivery!',
                  time: 'Apr 14',
                  icon: CupertinoIcons.tag,
                  iconColor: CupertinoColors.systemRed,
                  isUnread: false,
                ),
                _buildNotificationItem(
                  title: 'Welcome to Aval Delivery',
                  message:
                      'Thank you for using our service. Send your first package now!',
                  time: 'Apr 12',
                  icon: CupertinoIcons.hand_thumbsup,
                  iconColor: CupertinoColors.activeBlue,
                  isUnread: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationGroup(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
    required IconData icon,
    required Color iconColor,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      decoration: BoxDecoration(
        color: isUnread ? CupertinoColors.systemGrey6 : CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: CupertinoColors.systemGrey5,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                isUnread ? FontWeight.w600 : FontWeight.w500,
                            color: const Color(0xFF05001E),
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: isUnread
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
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
