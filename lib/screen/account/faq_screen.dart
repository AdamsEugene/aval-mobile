// lib/screens/account/faq_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/header_delegate.dart';

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

class FAQCategory {
  final String title;
  final List<FAQItem> items;

  FAQCategory({
    required this.title,
    required this.items,
  });
}

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<FAQCategory> _categories = [
    FAQCategory(
      title: 'Orders & Shipping',
      items: [
        FAQItem(
          question: 'How can I track my order?',
          answer:
              'You can track your order by going to "My Orders" in your account and clicking on the specific order. You\'ll find real-time tracking information there.',
        ),
        FAQItem(
          question: 'What shipping methods are available?',
          answer:
              'We offer Standard Shipping (5-7 business days), Express Shipping (2-3 business days), and Next Day Delivery for selected areas.',
        ),
        FAQItem(
          question: 'Can I change my shipping address?',
          answer:
              'You can change your shipping address before your order is processed. Once the order is processed, please contact customer support for assistance.',
        ),
      ],
    ),
    FAQCategory(
      title: 'Returns & Refunds',
      items: [
        FAQItem(
          question: 'What is your return policy?',
          answer:
              'We offer a 30-day return policy for most items. Products must be unused and in their original packaging with tags attached.',
        ),
        FAQItem(
          question: 'How do I initiate a return?',
          answer:
              'Go to "My Orders," select the order containing the item you want to return, and click "Return Item." Follow the instructions to print your return label.',
        ),
        FAQItem(
          question: 'When will I receive my refund?',
          answer:
              'Refunds are typically processed within 3-5 business days after we receive your return. The funds may take an additional 2-5 business days to appear in your account.',
        ),
      ],
    ),
    FAQCategory(
      title: 'Payment & Security',
      items: [
        FAQItem(
          question: 'What payment methods do you accept?',
          answer:
              'We accept all major credit cards (Visa, Mastercard, American Express), PayPal, and Apple Pay.',
        ),
        FAQItem(
          question: 'Is my payment information secure?',
          answer:
              'Yes, we use industry-standard encryption and security measures to protect your payment information. We never store your complete card details.',
        ),
      ],
    ),
    FAQCategory(
      title: 'Account Management',
      items: [
        FAQItem(
          question: 'How do I reset my password?',
          answer:
              'Click "Forgot Password" on the login screen and follow the instructions sent to your email to reset your password.',
        ),
        FAQItem(
          question: 'Can I change my email address?',
          answer:
              'Yes, you can change your email address in your account settings. You\'ll need to verify your new email address before the change takes effect.',
        ),
      ],
    ),
  ];

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const CupertinoTextField.borderless(
        placeholder: 'Search FAQs',
        prefix: Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(
            CupertinoIcons.search,
            color: Color(0xFF05001E),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(FAQItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            item.isExpanded = !item.isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: const TextStyle(
                        color: Color(0xFF05001E),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    item.isExpanded
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    color: const Color(0xFF05001E).withOpacity(0.3),
                    size: 20,
                  ),
                ],
              ),
              if (item.isExpanded) ...[
                const SizedBox(height: 12),
                Text(
                  item.answer,
                  style: TextStyle(
                    color: const Color(0xFF05001E).withOpacity(0.8),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(FAQCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            category.title,
            style: const TextStyle(
              color: Color(0xFF05001E),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...category.items.map((item) => _buildFAQItem(item)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderDelegate(
              title: 'FAQ',
              showBackButton: true,
              showProfile: false,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSearchBar(),
                ..._categories.map((category) => _buildCategory(category)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
