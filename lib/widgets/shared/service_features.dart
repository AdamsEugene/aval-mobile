import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'certificates_drawer.dart';

class ServiceFeatures extends StatefulWidget {
  const ServiceFeatures({super.key});

  @override
  State<ServiceFeatures> createState() => _ServiceFeaturesState();
}

class _ServiceFeaturesState extends State<ServiceFeatures> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

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
            currentPosition + 2,
            duration: const Duration(milliseconds: 30),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  void _showCertificatesDetails(BuildContext context) {
    CertificatesDrawer.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _showCertificatesDetails(context),
                  child: const Text(
                    'About Our Certificates',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 1000,
              itemBuilder: (context, index) {
                final imageIndex =
                    index % CertificatesDrawer.certificates.length;
                return FeatureItem(
                  imagePath:
                      CertificatesDrawer.certificates[imageIndex].imagePath,
                );
              },
            ),
          ),
        ],
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
      width: 70,
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
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
