import 'package:flutter/cupertino.dart';

class RewardsProgressScreen extends StatelessWidget {
  final String totalEarned;
  final String videosWatched;
  final String daysStreak;

  const RewardsProgressScreen({
    super.key,
    required this.totalEarned,
    required this.videosWatched,
    required this.daysStreak,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Your Rewards Journey'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rewards Summary Card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF9966),
                      Color(0xFFFF5E62),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5E62).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Rewards',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.flame_fill,
                                color: CupertinoColors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$daysStreak Day Streak',
                                style: const TextStyle(
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildRewardStat(
                      icon: CupertinoIcons.bitcoin,
                      title: 'Total Earned',
                      value: totalEarned,
                    ),
                    const SizedBox(height: 16),
                    _buildRewardStat(
                      icon: CupertinoIcons.play_circle_fill,
                      title: 'Videos Watched',
                      value: videosWatched,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Keep watching to earn more rewards!',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Daily Progress
              _buildSection(
                title: 'Daily Progress',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        for (int i = 0; i < 7; i++)
                          Expanded(
                            child: _buildDayProgressItem(
                              day: _getDayName(i),
                              isCompleted: i < 5,
                              isCurrent: i == 4,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemYellow.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CupertinoColors.systemYellow.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.lightbulb_fill,
                          color: CupertinoColors.systemYellow,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Maintain your streak for 7 days to earn a bonus reward of 500 coins!',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Upcoming Milestones
              _buildSection(
                title: 'Upcoming Milestones',
                children: [
                  SizedBox(
                    height: 180,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildMilestoneCard(
                          title: 'Watch 10 More Videos',
                          reward: '+200',
                          progress: 0.7,
                          progressText: '7/10 completed',
                          icon: CupertinoIcons.play_rectangle_fill,
                          color: CupertinoColors.activeBlue,
                        ),
                        _buildMilestoneCard(
                          title: '30 Day Streak',
                          reward: '+1,000',
                          progress: 0.17,
                          progressText: '5/30 days',
                          icon: CupertinoIcons.calendar,
                          color: CupertinoColors.systemPurple,
                        ),
                        _buildMilestoneCard(
                          title: 'Share 5 Videos',
                          reward: '+150',
                          progress: 0.4,
                          progressText: '2/5 shared',
                          icon: CupertinoIcons.share,
                          color: CupertinoColors.systemGreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Reward History
              _buildSection(
                title: 'Recent Rewards',
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildRewardHistoryItem(
                          title: 'Daily Watch Bonus',
                          time: 'Today',
                          points: '+100',
                        ),
                        Container(height: 1, color: CupertinoColors.systemGrey5),
                        _buildRewardHistoryItem(
                          title: 'Video Completion',
                          time: 'Yesterday',
                          points: '+50',
                        ),
                        Container(height: 1, color: CupertinoColors.systemGrey5),
                        _buildRewardHistoryItem(
                          title: 'Shared a Video',
                          time: '2 days ago',
                          points: '+75',
                        ),
                        Container(height: 1, color: CupertinoColors.systemGrey5),
                        _buildRewardHistoryItem(
                          title: '5 Day Streak Bonus',
                          time: '3 days ago',
                          points: '+250',
                          isHighlighted: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text(
                        'View Full History',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        // Navigate to full history
                      },
                    ),
                  ),
                ],
              ),

              // Tips for Earning
              _buildSection(
                title: 'Tips for Earning More',
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildTipItem(
                          'Watch at least 1 video daily to maintain your streak',
                          CupertinoIcons.time,
                        ),
                        const SizedBox(height: 16),
                        _buildTipItem(
                          'Share videos with friends to earn sharing bonuses',
                          CupertinoIcons.share,
                        ),
                        const SizedBox(height: 16),
                        _buildTipItem(
                          'Complete your profile to get a one-time bonus',
                          CupertinoIcons.person_fill,
                        ),
                        const SizedBox(height: 16),
                        _buildTipItem(
                          'Watch videos on Featured topics for bonus points',
                          CupertinoIcons.star_fill,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardStat({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: CupertinoColors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            icon,
            color: CupertinoColors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: CupertinoColors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildDayProgressItem({
    required String day,
    required bool isCompleted,
    required bool isCurrent,
  }) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? CupertinoColors.activeGreen
                : CupertinoColors.systemGrey5,
            border: isCurrent
                ? Border.all(
                    color: CupertinoColors.activeOrange,
                    width: 2,
                  )
                : null,
          ),
          child: Center(
            child: isCompleted
                ? const Icon(
                    CupertinoIcons.checkmark,
                    color: CupertinoColors.white,
                    size: 20,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: TextStyle(
            color: isCurrent
                ? CupertinoColors.activeOrange
                : CupertinoColors.systemGrey,
            fontSize: 12,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _getDayName(int index) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[index];
  }

  Widget _buildMilestoneCard({
    required String title,
    required String reward,
    required double progress,
    required String progressText,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.bitcoin,
                            color: color,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            reward,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reward',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  progressText,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardHistoryItem({
    required String title,
    required String time,
    required String points,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isHighlighted ? const Color(0xFFFFF8E1) : null,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isHighlighted
                  ? CupertinoColors.systemYellow.withOpacity(0.2)
                  : CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              isHighlighted
                  ? CupertinoIcons.star_fill
                  : CupertinoIcons.bitcoin,
              color: isHighlighted
                  ? CupertinoColors.systemYellow
                  : CupertinoColors.activeOrange,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight:
                        isHighlighted ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            points,
            style: TextStyle(
              color: isHighlighted
                  ? CupertinoColors.systemYellow
                  : CupertinoColors.activeOrange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: CupertinoColors.activeBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: CupertinoColors.activeBlue,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
} 