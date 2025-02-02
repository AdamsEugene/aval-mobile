import 'package:flutter/cupertino.dart';
import 'dart:async';

class ServiceFeatures extends StatefulWidget {
  const ServiceFeatures({super.key});

  @override
  State<ServiceFeatures> createState() => _ServiceFeaturesState();
}

class _ServiceFeaturesState extends State<ServiceFeatures> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  static const List<String> imagePaths = [
    'assets/images/certs/Payment-Plan.png',
    'assets/images/certs/certified-refurb.png',
    'assets/images/certs/certified-Pre-owned.png',
    'assets/images/certs/Digi-Cert.png',
    'assets/images/certs/Pre-owned.png',
    'assets/images/certs/protect-cert.png',
    'assets/images/certs/refurb.png',
    'assets/images/certs/Trace-Cert.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        final currentPosition = _scrollController.offset;
        final maxScrollExtent = _scrollController.position.maxScrollExtent;

        if (currentPosition >= maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentPosition + 2, // Increased increment for faster scroll
            duration: const Duration(milliseconds: 30),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 170,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: 1000,
          itemBuilder: (context, index) {
            final imageIndex = index % imagePaths.length;
            return FeatureItem(imagePath: imagePaths[imageIndex]);
          },
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String imagePath;

  const FeatureItem({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
