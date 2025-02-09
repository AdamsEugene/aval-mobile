// lib/screens/surveys/tabs/available_tab.dart
import 'package:flutter/cupertino.dart';
import '../components/survey_card.dart';

class AvailableSurveysTab extends StatelessWidget {
  const AvailableSurveysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SurveyCard(
                title: 'Product Feedback Survey ${index + 1}',
                description: 'Share your opinion about our products',
                reward: '${(index + 1) * 100}',
                duration: '${5 + index} min',
                category: index % 2 == 0 ? 'Product' : 'Service',
                onTap: () {
                  // Handle survey tap
                },
              ),
              childCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}
