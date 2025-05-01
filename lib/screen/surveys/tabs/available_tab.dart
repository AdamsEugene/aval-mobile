// lib/screens/surveys/tabs/available_tab.dart
import 'package:flutter/cupertino.dart';
import '../components/survey_card.dart';
import '../survey_detail_screen.dart';

class AvailableSurveysTab extends StatefulWidget {
  const AvailableSurveysTab({super.key});

  @override
  State<AvailableSurveysTab> createState() => _AvailableSurveysTabState();
}

class _AvailableSurveysTabState extends State<AvailableSurveysTab> {
  final List<Map<String, dynamic>> _surveys = [
    // Technology & Software
    {
      'title': 'Mobile User Experience Survey',
      'description': 'Help us improve our app\'s interface and navigation',
      'reward': '500',
      'duration': '15 min',
      'category': 'UX Research',
      'industry': 'Technology & Software',
      'sponsor': 'AVAL Research',
    },
    {
      'title': 'E-Commerce Checkout Process',
      'description': 'Evaluate our new checkout flow and payment options',
      'reward': '350',
      'duration': '10 min',
      'category': 'Product Research',
      'industry': 'Retail & E-commerce',
      'sponsor': 'Market Insights Group',
    },
    
    // Healthcare
    {
      'title': 'Telehealth Service Feedback',
      'description': 'Share your opinion on our new virtual medical consultation service',
      'reward': '600',
      'duration': '18 min',
      'category': 'Service Evaluation',
      'industry': 'Healthcare',
      'sponsor': 'HealthTech Solutions',
    },
    
    // Finance & Banking
    {
      'title': 'Mobile Banking Features',
      'description': 'Help us prioritize new features for our banking app',
      'reward': '450',
      'duration': '12 min',
      'category': 'Feature Prioritization',
      'industry': 'Finance & Banking',
      'sponsor': 'Digital Banking Initiative',
    },
    
    // Retail & E-commerce
    {
      'title': 'Online Shopping Experience',
      'description': 'Tell us about your recent shopping experiences on our platform',
      'reward': '400',
      'duration': '14 min',
      'category': 'User Behavior',
      'industry': 'Retail & E-commerce',
      'sponsor': 'Consumer Insights Team',
    },
    
    // Consumer Electronics
    {
      'title': 'Smart Home Device Usage',
      'description': 'Share feedback on how you use smart home devices',
      'reward': '550',
      'duration': '16 min',
      'category': 'Product Usage',
      'industry': 'Consumer Electronics',
      'sponsor': 'Connected Home Division',
    },
    
    // Food & Beverage
    {
      'title': 'Food Delivery App Satisfaction',
      'description': 'Rate your experiences with our food delivery service',
      'reward': '300',
      'duration': '8 min',
      'category': 'CSAT',
      'industry': 'Food & Beverage',
      'sponsor': 'Urban Eats Research',
    },
    
    // Media & Entertainment
    {
      'title': 'Streaming Service Preferences',
      'description': 'Tell us about your content preferences and viewing habits',
      'reward': '380',
      'duration': '10 min',
      'category': 'User Behavior',
      'industry': 'Media & Entertainment',
      'sponsor': 'StreamView Analytics',
    },
    
    // Automotive
    {
      'title': 'Electric Vehicle Interest Survey',
      'description': 'Share your thoughts on electric vehicles and charging infrastructure',
      'reward': '650',
      'duration': '20 min',
      'category': 'Market Research',
      'industry': 'Automotive',
      'sponsor': 'Future Mobility Lab',
    },
    
    // Education
    {
      'title': 'Online Learning Platform Feedback',
      'description': 'Help us improve our digital learning environment',
      'reward': '420',
      'duration': '15 min',
      'category': 'Educational Technology',
      'industry': 'Education',
      'sponsor': 'EduTech Innovations',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F8FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFADD8E6),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F2FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              CupertinoIcons.lightbulb_fill,
                              color: Color(0xFF0077CC),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Participation Incentives',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Complete surveys to earn points redeemable for discounts, gift cards, or exclusive access to new features.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF444444),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildIncentiveItem('Short', '5-10 min', '100-300'),
                          _buildIncentiveItem('Medium', '10-15 min', '300-500'),
                          _buildIncentiveItem('In-depth', '15+ min', '500+'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Available Research Surveys',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final survey = _surveys[index];
                return SurveyCard(
                  title: survey['title'],
                  description: survey['description'],
                  reward: survey['reward'],
                  duration: survey['duration'],
                  category: survey['category'],
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => SurveyDetailScreen(
                          title: survey['title'],
                          description: survey['description'],
                          reward: survey['reward'],
                          duration: survey['duration'],
                          category: survey['category'],
                          industry: survey['industry'],
                          sponsor: survey['sponsor'],
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: _surveys.length,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildIncentiveItem(String label, String time, String points) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0077CC),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.bitcoin,
                size: 12,
                color: CupertinoColors.activeOrange,
              ),
              const SizedBox(width: 2),
              Text(
                points,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.activeOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
