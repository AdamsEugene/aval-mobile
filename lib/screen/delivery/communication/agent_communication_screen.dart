 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class AgentCommunicationScreen extends StatefulWidget {
  const AgentCommunicationScreen({super.key});

  @override
  State<AgentCommunicationScreen> createState() => _AgentCommunicationScreenState();
}

class _AgentCommunicationScreenState extends State<AgentCommunicationScreen> with TickerProviderStateMixin {
  final List<Message> _messages = [];
  bool _isRecording = false;
  int _recordingDuration = 0;
  Timer? _recordingTimer;
  
  // Animation controllers
  late AnimationController _micAnimation;
  late AnimationController _waveAnimation;
  
  final List<String> _agents = [
    'John (ID: DL-1234)',
    'Sarah (ID: DL-5678)',
    'Michael (ID: DL-9012)',
    'Emma (ID: DL-3456)',
    'David (ID: DL-7890)',
  ];
  
  final List<String> _incidentTypes = [
    'Suspicious Package',
    'Criminal Activity',
    'Dangerous Road Condition',
    'Traffic Incident',
    'Natural Disaster',
    'Health Emergency',
    'Other',
  ];
  
  String? _selectedIncidentType;
  final TextEditingController _incidentDescriptionController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    
    // Load sample messages
    _loadSampleMessages();
    
    // Initialize animations
    _micAnimation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _waveAnimation = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _recordingTimer?.cancel();
    _micAnimation.dispose();
    _waveAnimation.dispose();
    _incidentDescriptionController.dispose();
    super.dispose();
  }
  
  void _loadSampleMessages() {
    final rng = math.Random();
    final now = DateTime.now();
    
    _messages.addAll([
      Message(
        sender: 'John (ID: DL-1234)',
        content: 'Audio message (0:32)',
        isAudio: true,
        timestamp: now.subtract(const Duration(hours: 2, minutes: 15)),
      ),
      Message(
        sender: 'Sarah (ID: DL-5678)',
        content: 'Be careful on Madina Road, there\'s a lot of traffic due to construction.',
        isAudio: false,
        timestamp: now.subtract(const Duration(hours: 1, minutes: 45)),
      ),
      Message(
        sender: 'System',
        content: 'ALERT: Suspicious package reported at Accra Mall. Avoid area if possible.',
        isAlert: true,
        timestamp: now.subtract(const Duration(hours: 1, minutes: 20)),
      ),
      Message(
        sender: 'Michael (ID: DL-9012)',
        content: 'Audio message (0:15)',
        isAudio: true,
        timestamp: now.subtract(const Duration(minutes: 45)),
      ),
      Message(
        sender: 'Emma (ID: DL-3456)',
        content: 'I\'ve completed 5 deliveries today. Anyone near Osu who can take an extra order?',
        isAudio: false,
        timestamp: now.subtract(const Duration(minutes: 30)),
      ),
    ]);
  }
  
  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordingDuration = 0;
    });
    
    _micAnimation.forward();
    
    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }
  
  void _stopRecording() {
    _recordingTimer?.cancel();
    _micAnimation.reverse();
    
    setState(() {
      _isRecording = false;
      
      // Add the new audio message
      final message = Message(
        sender: 'You (ID: DL-2468)',
        content: 'Audio message (${_formatDuration(_recordingDuration)})',
        isAudio: true,
        timestamp: DateTime.now(),
        isFromMe: true,
      );
      
      _messages.insert(0, message);
    });
  }
  
  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  
  void _showIncidentReportSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    CupertinoIcons.xmark,
                    size: 24,
                  ),
                ),
                const Text(
                  'Report Incident',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_selectedIncidentType != null && 
                        _incidentDescriptionController.text.isNotEmpty) {
                      final newMessage = Message(
                        sender: 'You (ID: DL-2468)',
                        content: 'INCIDENT: $_selectedIncidentType - ${_incidentDescriptionController.text}',
                        isAlert: true,
                        timestamp: DateTime.now(),
                        isFromMe: true,
                      );
                      
                      setState(() {
                        _messages.insert(0, newMessage);
                      });
                      
                      // Reset and close
                      _selectedIncidentType = null;
                      _incidentDescriptionController.clear();
                      Navigator.pop(context);
                      
                      // Show confirmation
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Incident Reported'),
                          content: const Text('Your incident report has been submitted and broadcast to all nearby agents.'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Incomplete Report'),
                          content: const Text('Please select an incident type and provide a description.'),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Incident type selection
            const Text(
              'Incident Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedIncidentType = _incidentTypes[index];
                  });
                },
                children: _incidentTypes.map((type) => Center(
                  child: Text(type),
                )).toList(),
              ),
            ),
            const SizedBox(height: 24),
            
            // Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: CupertinoTextField(
                controller: _incidentDescriptionController,
                placeholder: 'Describe the incident in detail...',
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                  ),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 24),
            
            // Location
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    CupertinoIcons.location_fill,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Location',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Accra, Ghana (Auto-detected)',
                        style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Change'),
                  onPressed: () {},
                ),
              ],
            ),
            
            // Note about privacy
            const SizedBox(height: 16),
            const Text(
              'Note: Incident reports are visible to all agents in your area and relevant authorities.',
              style: TextStyle(
                fontSize: 12,
                color: CupertinoColors.systemGrey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMessageItem(Message message) {
    final isFromMe = message.isFromMe;
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isFromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (!isFromMe)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 4),
              child: Text(
                message.sender,
                style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: message.isAlert
                  ? CupertinoColors.systemRed
                  : (isFromMe
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.systemGrey6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: message.isAudio
                ? _buildAudioMessage(message, isFromMe)
                : Text(
                    message.content,
                    style: TextStyle(
                      color: message.isAlert || isFromMe
                          ? CupertinoColors.white
                          : CupertinoColors.label,
                      fontSize: message.isAlert ? 14 : 16,
                      fontWeight: message.isAlert ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 4),
            child: Text(
              _formatMessageTime(message.timestamp),
              style: const TextStyle(
                fontSize: 10,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAudioMessage(Message message, bool isFromMe) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          CupertinoIcons.play_fill,
          color: isFromMe ? CupertinoColors.white : CupertinoColors.activeBlue,
          size: 16,
        ),
        const SizedBox(width: 8),
        CustomPaint(
          size: const Size(60, 20),
          painter: AudioWavePainter(
            color: isFromMe ? CupertinoColors.white : CupertinoColors.activeBlue,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          message.content.split('(')[1].replaceAll(')', ''),
          style: TextStyle(
            color: isFromMe ? CupertinoColors.white : CupertinoColors.label,
          ),
        ),
      ],
    );
  }
  
  String _formatMessageTime(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.day}/${timestamp.month} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Agent Communication'),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(CupertinoIcons.exclamationmark_triangle),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: _showIncidentReportSheet,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Agent switcher
            Container(
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _agents.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: index == 0
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        _agents[index],
                        style: TextStyle(
                          color: index == 0
                              ? CupertinoColors.white
                              : CupertinoColors.label,
                          fontSize: 14,
                          fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Message list
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageItem(_messages[index]);
                },
              ),
            ),
            
            // Recording UI
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.systemGrey4.withOpacity(0.3),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: _isRecording
                        ? Row(
                            children: [
                              AnimatedBuilder(
                                animation: _waveAnimation,
                                builder: (context, child) {
                                  return CustomPaint(
                                    size: const Size(100, 40),
                                    painter: AudioWavePainter(
                                      color: CupertinoColors.systemRed,
                                      animation: _waveAnimation,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _formatDuration(_recordingDuration),
                                style: const TextStyle(
                                  color: CupertinoColors.systemRed,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'Tap and hold the microphone to record',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 14,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onLongPressStart: (_) => _startRecording(),
                    onLongPressEnd: (_) => _stopRecording(),
                    child: AnimatedBuilder(
                      animation: _micAnimation,
                      builder: (context, child) {
                        final color = ColorTween(
                          begin: CupertinoColors.activeBlue,
                          end: CupertinoColors.systemRed,
                        ).evaluate(_micAnimation);
                        
                        final scale = Tween<double>(
                          begin: 1.0,
                          end: 1.2,
                        ).evaluate(_micAnimation);
                        
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.mic_fill,
                              color: CupertinoColors.white,
                            ),
                          ),
                        );
                      },
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

class AudioWavePainter extends CustomPainter {
  final Color color;
  final Animation<double>? animation;
  
  AudioWavePainter({
    required this.color,
    this.animation,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final animationValue = animation?.value ?? 0;
    
    // Draw audio wave bars
    for (int i = 0; i < 10; i++) {
      final x = size.width / 11 * (i + 1);
      
      double normalHeight;
      
      if (animation != null) {
        // Animated wave for recording
        final seed = i * 100 + (animationValue * 1000).toInt();
        final random = math.Random(seed);
        normalHeight = 0.3 + random.nextDouble() * 0.7;
      } else {
        // Static wave for messages
        final random = math.Random(i);
        normalHeight = 0.3 + random.nextDouble() * 0.7;
      }
      
      final height = size.height * normalHeight;
      final y1 = (size.height - height) / 2;
      final y2 = y1 + height;
      
      canvas.drawLine(
        Offset(x, y1),
        Offset(x, y2),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(covariant AudioWavePainter oldDelegate) {
    return oldDelegate.color != color || animation?.value != oldDelegate.animation?.value;
  }
}

class Message {
  final String sender;
  final String content;
  final DateTime timestamp;
  final bool isAudio;
  final bool isAlert;
  final bool isFromMe;
  
  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
    this.isAudio = false,
    this.isAlert = false,
    this.isFromMe = false,
  });
}