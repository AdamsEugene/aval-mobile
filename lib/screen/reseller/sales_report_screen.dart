// lib/screens/sales_report_screen.dart
import 'package:e_commerce_app/widgets/sales/sales_chart.dart';
import 'package:e_commerce_app/widgets/shared/custom_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

enum SalesPeriod { daily, weekly, monthly, yearly }

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  SalesPeriod _selectedPeriod = SalesPeriod.monthly;

  final List<Map<String, dynamic>> _salesData = [
    {'name': 'Mon', 'sales': 2400},
    {'name': 'Tue', 'sales': 1398},
    {'name': 'Wed', 'sales': 9800},
    {'name': 'Thu', 'sales': 3908},
    {'name': 'Fri', 'sales': 4800},
    {'name': 'Sat', 'sales': 3800},
    {'name': 'Sun', 'sales': 4300},
  ];

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Sales Report',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.share,
          onPressed: () {
            // Share report functionality
          },
        ),
      ],
    );
  }

  Widget _buildSalesChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sales Trend',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SalesChart(data: _salesData),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String change) {
    final isPositive = change.startsWith('+');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: CupertinoColors.systemGrey.darkColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                isPositive
                    ? CupertinoIcons.arrow_up_right
                    : CupertinoIcons.arrow_down_right,
                size: 14,
                color: isPositive
                    ? CupertinoColors.activeGreen
                    : CupertinoColors.destructiveRed,
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  color: isPositive
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.destructiveRed,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopProducts() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/a.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Premium T-Shirt',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '148 Sales',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey.darkColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '\$4,440',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF05001E),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
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
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: SizedBox(
                      height: 48, // Fixed height
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CustomSegmentedControl<SalesPeriod>(
                          groupValue: _selectedPeriod,
                          onValueChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedPeriod = value);
                            }
                          },
                          children: const {
                            SalesPeriod.daily: SegmentItem(
                              text: 'Daily',
                              icon: CupertinoIcons.clock,
                            ),
                            SalesPeriod.weekly: SegmentItem(
                              text: 'Weekly',
                              icon: CupertinoIcons.calendar,
                            ),
                            SalesPeriod.monthly: SegmentItem(
                              text: 'Monthly',
                              icon: CupertinoIcons.calendar_badge_plus,
                            ),
                            // SalesPeriod.yearly: SegmentItem(
                            //   text: 'Yearly',
                            //   icon: CupertinoIcons.calendar_circle,
                            // ),
                          },
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  _buildSalesChart(),
                  // const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildMetricCard(
                            'Total Sales',
                            '\$12,845',
                            '+15.3%',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMetricCard(
                            'Orders',
                            '384',
                            '+8.2%',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTopProducts(),
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
