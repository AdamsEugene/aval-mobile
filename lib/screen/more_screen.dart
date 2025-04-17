// lib/screen/more_screen.dart
import 'package:e_commerce_app/screen/delivery/delivery_screen.dart';
import 'package:e_commerce_app/screen/games/games_screen.dart';
import 'package:e_commerce_app/screen/invest/invest_screen.dart';
import 'package:e_commerce_app/screen/referrals/referrals_screen.dart';
import 'package:e_commerce_app/screen/surveys/surveys_screen.dart';
import 'package:e_commerce_app/screen/watch_share/watch_share_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            'More',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.bell,
          onPressed: () {
            // Handle notifications
          },
        ),
        HeaderAction(
          icon: CupertinoIcons.settings,
          onPressed: () {
            // Handle settings
          },
        ),
      ],
    );
  }

  Widget _buildWalletSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        children: [
          _buildSectionHeader(
              'Wallet & Rewards', CupertinoIcons.money_dollar_circle),
          const Divider(height: 1),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildGridItem(
                  context, 'Bition', 'Loyalty Coins', CupertinoIcons.bitcoin),
              _buildGridItem(
                  context, 'Coupons', 'Special Offers', CupertinoIcons.tag),
              _buildGridItem(
                  context, 'BTN Wallet', 'Balance', CupertinoIcons.creditcard),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCertificatesSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        children: [
          _buildSectionHeader('Certificates', CupertinoIcons.doc_text_fill),
          const Divider(height: 1),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildGridItem(
                context,
                'TC',
                'Trace Certificate',
                CupertinoIcons.arrow_2_squarepath,
              ),
              _buildGridItem(
                context,
                'DG-C',
                'Digital Certificate',
                CupertinoIcons.doc_on_doc,
              ),
              _buildGridItem(
                context,
                'PT-C',
                'Protection Certificate',
                CupertinoIcons.shield_fill,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        children: [
          _buildSectionHeader('Earnings', CupertinoIcons.money_dollar),
          const Divider(height: 1),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildGridItem(context, 'Watch & Share', 'Ads Rewards',
                  CupertinoIcons.play_circle_fill),
              _buildGridItem(context, 'Referrals', 'Sales Rewards',
                  CupertinoIcons.person_2_fill),
              _buildGridItem(context, 'Surveys', 'Programs',
                  CupertinoIcons.doc_text_viewfinder),
              _buildGridItem(context, 'Games', 'Play & Earn',
                  CupertinoIcons.gamecontroller_fill),
              _buildGridItem(
                  context, 'Invest', 'Grow Wealth', CupertinoIcons.chart_bar),
              _buildGridItem(
                  context, 'Delivery', 'Logistics', CupertinoIcons.cart),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: CupertinoColors.activeOrange),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, String title, String subtitle, IconData icon) {
    return GestureDetector(
        onTap: () {
          switch (title) {
            case 'Watch & Share':
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const WatchShareScreen(),
                ),
              );
              break;
            case 'Referrals':
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const ReferralsScreen(),
                ),
              );
              break;
            case 'Surveys':
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const SurveysScreen(),
                ),
              );
              break;
            case 'Games':
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const GamesScreen(),
                ),
              );
              break;
            case 'Invest':
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const InvestScreen(),
                ),
              );
              break;
            case 'Delivery':
              // Navigate to Delivery screen - updated to use our new screen
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => const DeliveryScreen(),
                ),
              );
              break;
            default:
              // Handle other navigation or show under development message
              showCupertinoDialog(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Coming Soon'),
                  content: Text('$title feature is under development'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
          }
          ;
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFEEAD1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: CupertinoColors.activeOrange),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }

  Widget _buildListItem(String title, String label, IconData icon,
      {String? subtitle}) {
    return GestureDetector(
      onTap: () {
        // Handle item tap
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.activeOrange),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildWalletSection(context),
                  _buildCertificatesSection(context),
                  _buildEarningsSection(context),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
