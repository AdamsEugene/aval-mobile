import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/cupertino.dart';

class SubscriptionInfoDrawer extends StatefulWidget {
  const SubscriptionInfoDrawer({super.key});

  @override
  State<SubscriptionInfoDrawer> createState() => _SubscriptionInfoDrawerState();
}

class _SubscriptionInfoDrawerState extends State<SubscriptionInfoDrawer> {
  String? _selectedPlan;
  int _customDays = 3;

  void _showIntervalPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('Confirm'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.0,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: _customDays - 1,
                  ),
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _customDays = selectedItem + 1;
                    });
                  },
                  children: List<Widget>.generate(30, (int index) {
                    return Center(
                      child: Text(
                        'Every ${index + 1} ${(index + 1) == 1 ? 'day' : 'days'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlan({
    required String title,
    required String price,
    required String interval,
    required String savings,
    bool isPopular = false,
    bool isCustom = false,
  }) {
    final bool isSelected = _selectedPlan == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = isSelected ? null : title;
          if (isCustom) {
            _showIntervalPicker();
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF4E5) : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? CupertinoColors.activeOrange
                : const Color(0xFFEEEEEE),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isCustom ? 'Custom Plan' : title,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEEAD1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Most Popular',
                      style: TextStyle(
                        color: CupertinoColors.activeOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  isCustom
                      ? 'USD ${(_customDays * 5.99).toStringAsFixed(2)}'
                      : price,
                  style: const TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isCustom ? 'every $_customDays days' : interval,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                if (isCustom) ...[
                  const Spacer(),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 16,
                    color: Color(0xFF05001E),
                  ),
                ],
              ],
            ),
            if (!isCustom) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.tag_fill,
                    color: CupertinoColors.activeOrange,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    savings,
                    style: const TextStyle(
                      color: CupertinoColors.activeOrange,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.checkmark_alt,
            color: CupertinoColors.activeOrange,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF05001E).withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      leadingAction: DrawerAction(
        text: 'Cancel',
        onTap: () => Navigator.of(context).pop(),
      ),
      trailingAction: DrawerAction(
        text: 'Save',
        // textColor: CupertinoColors.activeBlue,
        fontWeight: FontWeight.w600,
        onTap: () => (),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Subscription Plans',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubscriptionPlan(
                    title: 'Weekly Plan',
                    price: 'USD 39.99',
                    interval: '/week',
                    savings: 'Save 15%',
                    isPopular: true,
                  ),
                  _buildSubscriptionPlan(
                    title: 'Monthly Plan',
                    price: 'USD 149.99',
                    interval: '/month',
                    savings: 'Save 25%',
                  ),
                  _buildSubscriptionPlan(
                    title: 'Quarterly Plan',
                    price: 'USD 399.99',
                    interval: '/quarter',
                    savings: 'Save 30%',
                  ),
                  _buildSubscriptionPlan(
                    title: 'Custom Plan',
                    price: 'USD ${(_customDays * 5.99).toStringAsFixed(2)}',
                    interval: 'every $_customDays days',
                    savings: '',
                    isCustom: true,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Subscription Benefits',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF05001E),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeature('Regular deliveries without reordering'),
                  _buildFeature('Priority shipping on all orders'),
                  _buildFeature('Exclusive subscriber discounts'),
                  _buildFeature('Flexible delivery schedule'),
                  _buildFeature('Cancel or pause anytime'),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4E5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.info_circle_fill,
                              color: CupertinoColors.activeOrange,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Subscription Terms',
                              style: TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '• Automatic billing on selected interval\n'
                          '• Cancel subscription anytime\n'
                          '• 30-day satisfaction guarantee\n'
                          '• Modify delivery schedule as needed',
                          style: TextStyle(
                            color: const Color(0xFF05001E).withOpacity(0.6),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
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
}
