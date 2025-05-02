import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screen/delivery/registration/delivery_company_registration.dart';
import 'package:e_commerce_app/screen/delivery/location/beacon_location_screen.dart';
import 'package:e_commerce_app/screen/delivery/communication/agent_communication_screen.dart';
import 'package:e_commerce_app/screen/delivery/transport/ridesharing_screen.dart';

class DeliveryFeaturesScreen extends StatelessWidget {
  const DeliveryFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Delivery Features'),
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.8),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFeatureCard(
              context,
              title: 'Company Registration',
              description: 'Register your delivery company to offer services on our platform',
              icon: CupertinoIcons.building_2_fill,
              color: const Color(0xFF4CA1AF),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const DeliveryCompanyRegistrationScreen(),
                ),
              ),
            ),
            _buildFeatureCard(
              context,
              title: 'Beacon Location Technology',
              description: 'Detect and register unknown locations using our advanced beacon technology',
              icon: CupertinoIcons.location_fill,
              color: const Color(0xFF3498DB),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const BeaconLocationScreen(),
                ),
              ),
            ),
            _buildFeatureCard(
              context,
              title: 'Agent Communication',
              description: 'Communicate with other delivery agents via audio messages and report incidents',
              icon: CupertinoIcons.chat_bubble_fill,
              color: const Color(0xFF9B59B6),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const AgentCommunicationScreen(),
                ),
              ),
            ),
            _buildFeatureCard(
              context,
              title: 'Ridesharing',
              description: 'Offer rides in your private vehicle or find rides to your destination',
              icon: CupertinoIcons.car_fill,
              color: const Color(0xFFE74C3C),
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => const RidesharingScreen(),
                ),
              ),
            ),
            _buildFeatureCard(
              context,
              title: 'Drone Delivery',
              description: 'Our drone delivery service is coming soon - faster deliveries for smaller packages',
              icon: CupertinoIcons.airplane,
              color: const Color(0xFF34495E),
              isComingSoon: true,
              onTap: () => _showComingSoonDialog(context),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: CupertinoColors.systemGrey,
                  ),
                ],
              ),
            ),
            if (isComingSoon)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF39C12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void _showComingSoonDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Coming Soon'),
        content: const Text(
          'We are working on integrating drone delivery into our platform. This feature will be available in the next update.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Notify Me'),
            onPressed: () {
              Navigator.pop(context);
              _showNotificationConfirmation(context);
            },
          ),
        ],
      ),
    );
  }
  
  void _showNotificationConfirmation(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Notification Set'),
        content: const Text(
          'You will be notified when drone delivery becomes available.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
} 