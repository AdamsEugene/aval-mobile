// lib/utils/date_formatter.dart
String formatChatTime(DateTime time) {
  final now = DateTime.now();
  final difference = now.difference(time);

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inHours < 1) {
    return '${difference.inMinutes}m';
  } else if (difference.inDays < 1) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}d';
  } else {
    return '${time.month}/${time.day}/${time.year}';
  }
}
