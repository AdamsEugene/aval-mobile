// lib/screen/delivery/drawers/help_support_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';
import 'package:flutter/material.dart';

class HelpSupportDrawer extends StatefulWidget {
  const HelpSupportDrawer({super.key});

  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => const HelpSupportDrawer(),
    );
  }

  @override
  State<HelpSupportDrawer> createState() => _HelpSupportDrawerState();
}

class _HelpSupportDrawerState extends State<HelpSupportDrawer> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  // List of FAQs for the delivery feature
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'How do I track my package?',
      answer:
          'You can track your package by using the tracking ID provided in your order confirmation. Enter this ID in the tracking section of the app to see real-time updates on your package location.',
    ),
    FAQItem(
      question: 'What are the delivery time frames?',
      answer:
          'Local delivery typically takes 1-2 business days. Cross-region delivery takes 2-5 business days. Express delivery options are available at checkout for faster delivery times.',
    ),
    FAQItem(
      question: 'Can I change the delivery address after placing an order?',
      answer:
          'Yes, you can change the delivery address before the package is dispatched. Go to your order details and select "Change Address". Once the package is in transit, contact customer support for assistance.',
    ),
    FAQItem(
      question: 'What if I\'m not available to receive my package?',
      answer:
          'If you\'re not available, the courier will attempt delivery according to your preferences. You can choose to leave the package at a safe place, have it delivered to a neighbor, or reschedule delivery for another day.',
    ),
    FAQItem(
      question: 'How is the delivery cost calculated?',
      answer:
          'Delivery costs are calculated based on package weight, dimensions, distance, delivery speed, and any additional services selected (such as insurance or signature confirmation).',
    ),
    FAQItem(
      question: 'Is my package insured during transit?',
      answer:
          'Basic insurance is included for all packages up to a value of \$100. You can purchase additional insurance at checkout for higher-value items, covering up to \$1000.',
    ),
    FAQItem(
      question: 'What should I do if my package is damaged?',
      answer:
          'If your package arrives damaged, take photos of the packaging and the damaged items. Contact our support team within 48 hours of delivery, and we\'ll process a claim for you.',
    ),
  ];

  List<FAQItem> get filteredFAQs {
    if (_searchController.text.isEmpty) {
      return _faqItems;
    }

    final query = _searchController.text.toLowerCase();
    return _faqItems.where((item) {
      return item.question.toLowerCase().contains(query) ||
          item.answer.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      height: MediaQuery.of(context).size.height * 0.85,
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.of(context).pop(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Help & Support',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CupertinoSearchTextField(
              controller: _searchController,
              placeholder: 'Search FAQs',
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
              },
              onSubmitted: (value) {
                // Handle search submission
              },
            ),
          ),
          const Divider(height: 1),

          // FAQ list
          Expanded(
            child: filteredFAQs.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredFAQs.length,
                    itemBuilder: (context, index) {
                      return _buildFAQItem(filteredFAQs[index]);
                    },
                  ),
          ),

          // Contact support section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FA),
              border: Border(
                top: BorderSide(
                  color: CupertinoColors.systemGrey5,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need more help?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: const Color(0xFF05001E),
                        onPressed: () {
                          // Handle chat support
                        },
                        child: const Text('Chat with Support'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        color: CupertinoColors.activeOrange,
                        onPressed: () {
                          // Handle call support
                        },
                        child: const Text('Call Support'),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.search,
            size: 64,
            color: CupertinoColors.systemGrey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No results found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search term',
            style: TextStyle(
              color: CupertinoColors.systemGrey.darkColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(FAQItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isExpanded = !item.isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CupertinoColors.systemGrey5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      CupertinoIcons.question,
                      color: CupertinoColors.activeOrange,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    item.isExpanded
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    color: const Color(0xFF05001E).withOpacity(0.5),
                    size: 20,
                  ),
                ],
              ),
              if (item.isExpanded) ...[
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    item.answer,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF05001E).withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
// 