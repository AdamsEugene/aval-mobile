import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:e_commerce_app/screen/surveys/survey_questions_screen.dart';

class SurveyDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String reward;
  final String duration;
  final String category;
  final String industry;
  final String sponsor;

  const SurveyDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.reward,
    required this.duration,
    required this.category,
    this.industry = 'Technology & Software',
    this.sponsor = 'AVAL Research',
  });

  @override
  State<SurveyDetailScreen> createState() => _SurveyDetailScreenState();
}

class _SurveyDetailScreenState extends State<SurveyDetailScreen> {
  bool _isConsentChecked = false;
  bool _showSponsorInfo = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: CustomScrollView(
                slivers: [
                  MainHeader(
                    leading: Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      HeaderAction(
                        icon: CupertinoIcons.info_circle,
                        onPressed: () {
                          // Show info about this survey
                        },
                      ),
                      HeaderAction(
                        icon: CupertinoIcons.share,
                        onPressed: () {
                          // Share survey
                        },
                      ),
                    ],
                    withBack: true,
                  ),
                  SliverToBoxAdapter(
                    child: _buildSurveyHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildSponsorSection(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildResearchObjectives(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildSurveyMethodology(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildStakeholdersSection(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildParticipationTerms(),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildBottomBar(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveyHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEEAD1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  CupertinoIcons.doc_chart_fill,
                  color: CupertinoColors.activeOrange,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                CupertinoIcons.time,
                'Duration',
                widget.duration,
              ),
              _buildInfoItem(
                CupertinoIcons.tag,
                'Category',
                widget.category,
              ),
              _buildInfoItem(
                CupertinoIcons.bitcoin,
                'Reward',
                widget.reward,
                isReward: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.building_2_fill,
                  color: Color(0xFF444444),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  'Industry: ${widget.industry}',
                  style: const TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSponsorSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showSponsorInfo = !_showSponsorInfo;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: _showSponsorInfo 
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )
                    : BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      CupertinoIcons.person_2_fill,
                      color: Color(0xFF0077CC),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Survey Sponsor: ${widget.sponsor}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'The organization commissioning this survey',
                          style: TextStyle(
                            fontSize: 12,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _showSponsorInfo 
                        ? CupertinoIcons.chevron_up 
                        : CupertinoIcons.chevron_down,
                    size: 18,
                    color: CupertinoColors.systemGrey,
                  ),
                ],
              ),
            ),
          ),
          if (_showSponsorInfo)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF8F8F8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About the Sponsor:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF444444),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint('Sets objectives and provides funding for this research'),
                  _buildBulletPoint('Uses the results for business decision-making'),
                  _buildBulletPoint('Committed to improving products and services based on your feedback'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F6FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF0077CC), width: 1),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.shield_lefthalf_fill,
                              color: Color(0xFF0077CC),
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Verified Sponsor',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF0077CC),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: CupertinoColors.activeOrange,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '4.8/5.0',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF444444),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, {bool isReward = false}) {
    return Column(
      children: [
        Icon(
          icon,
          color: isReward ? CupertinoColors.activeOrange : CupertinoColors.systemGrey,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: CupertinoColors.systemGrey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isReward ? CupertinoColors.activeOrange : CupertinoColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildResearchObjectives() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                CupertinoIcons.scope,
                color: Color(0xFF05001E),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Research Objectives',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'This survey aims to gather insights to improve user experience and product development. Your feedback will directly influence future business decisions and product roadmaps.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Key business benefits of this research:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletPoint('Innovation and competitive advantage in the market'),
          _buildBulletPoint('Improved efficiency and potential cost reduction'),
          _buildBulletPoint('Enhanced customer satisfaction and experience'),
          _buildBulletPoint('Development of new products and revenue streams'),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF444444),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurveyMethodology() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                CupertinoIcons.chart_bar,
                color: Color(0xFF05001E),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Survey Methodology',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'This survey has been designed by professional researchers to collect accurate and valuable data. It includes:',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletPoint('Multiple choice questions for quantitative analysis'),
          _buildBulletPoint('Rating scales to measure satisfaction and preferences'),
          _buildBulletPoint('Open-ended questions for qualitative feedback'),
          _buildBulletPoint('Scenario-based questions to understand decision patterns'),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                CupertinoIcons.time,
                color: CupertinoColors.systemGrey,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Estimated completion time: ${widget.duration}',
                style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStakeholdersSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                CupertinoIcons.person_3_fill,
                color: Color(0xFF05001E),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Research Stakeholders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Your participation contributes to a research ecosystem involving several stakeholders:',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 8),
          _buildStakeholderItem(
            'Survey Sponsor', 
            'The organization funding this research to improve their offerings',
            CupertinoIcons.building_2_fill,
          ),
          _buildStakeholderItem(
            'Survey Agency',
            'Professional organization designing and administering the survey',
            CupertinoIcons.chart_pie_fill,
          ),
          _buildStakeholderItem(
            'Data Analysts',
            'Specialists who will analyze the collected data',
            CupertinoIcons.graph_circle_fill,
          ),
          _buildStakeholderItem(
            'You (Survey Respondent)',
            'Providing valuable feedback to shape future products and services',
            CupertinoIcons.person_fill,
          ),
        ],
      ),
    );
  }

  Widget _buildStakeholderItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: const Color(0xFF0077CC),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipationTerms() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                CupertinoIcons.doc_text,
                color: Color(0xFF05001E),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Participation Terms',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'By participating in this survey, you acknowledge that:',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletPoint('Your responses will be anonymized for research purposes'),
          _buildBulletPoint('Aggregate data will be used to improve products and services'),
          _buildBulletPoint('You can exit the survey at any time, but rewards are only issued upon completion'),
          _buildBulletPoint('Your participation is voluntary and greatly appreciated'),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              setState(() {
                _isConsentChecked = !_isConsentChecked;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _isConsentChecked ? const Color(0xFF0077CC) : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _isConsentChecked ? const Color(0xFF0077CC) : CupertinoColors.systemGrey,
                      width: 1.5,
                    ),
                  ),
                  child: _isConsentChecked
                      ? const Icon(
                          CupertinoIcons.check_mark,
                          size: 14,
                          color: CupertinoColors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'I agree to participate in this research study and understand how my data will be used to improve products and services.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF444444),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: CupertinoColors.white,
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reward upon completion',
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.bitcoin,
                    size: 16,
                    color: CupertinoColors.activeOrange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.reward,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.activeOrange,
                    ),
                  ),
                  const Text(
                    ' points',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: _isConsentChecked ? const Color(0xFF05001E) : CupertinoColors.systemGrey3,
            borderRadius: BorderRadius.circular(12),
            onPressed: _isConsentChecked
                ? () {
                    // Navigate to the survey questions screen
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => SurveyQuestionsScreen(
                          title: widget.title,
                          category: widget.category,
                          reward: widget.reward,
                        ),
                      ),
                    );
                  }
                : null,
            child: const Text(
              'Begin Survey',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 