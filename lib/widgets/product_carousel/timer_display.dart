import 'package:flutter/cupertino.dart';

class TimerDisplay extends StatelessWidget {
  final int secondsRemaining;

  const TimerDisplay({super.key, required this.secondsRemaining});

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1939),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(8),
        ),
      ),
      child: Text(
        _formatTime(secondsRemaining),
        style: const TextStyle(
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
