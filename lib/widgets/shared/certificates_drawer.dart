import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/base_drawer.dart';

class CertificateDetails {
  final String imagePath;
  final String title;
  final String description;
  final List<String> benefits;
  final List<String> requirements;
  final double? price;
  final bool canPurchase;

  const CertificateDetails({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.benefits,
    required this.requirements,
    this.price,
    this.canPurchase = false,
  });
}

class CertificatesDrawer extends StatefulWidget {
  static const List<CertificateDetails> certificates = [
    CertificateDetails(
      imagePath: 'assets/images/certs/aval-choice.png',
      title: 'Available Choice',
      description:
          'Flexible options for purchasing and delivery of your products.',
      benefits: [
        'Multiple payment methods',
        'Flexible delivery options',
        'Choice of warranty plans',
        'Customizable service packages',
        'Priority booking options'
      ],
      requirements: [
        'Valid shipping address',
        'Available in your region',
        'Account registration required',
        'Terms and conditions acceptance'
      ],
      price: 49.99,
      canPurchase: true,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/Payment-Plan.png',
      title: 'Payment Plan',
      description:
          'Make your purchases more affordable with our flexible payment plans.',
      benefits: [
        'Split payments into manageable installments',
        'No hidden fees or charges',
        'Flexible payment schedules (3, 6, or 12 months)',
        'Automatic payment processing',
        'Early payment options with no penalties'
      ],
      requirements: [
        'Minimum purchase value of \$500',
        'Valid credit card or bank account',
        'Good payment history',
        'Proof of income may be required for large purchases'
      ],
      canPurchase: false,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/certified-refurb.png',
      title: 'Certified Refurbished',
      description:
          'Factory-restored products that meet our highest quality standards.',
      benefits: [
        'Full factory restoration',
        '1-year warranty coverage',
        'Significant cost savings compared to new items',
        'Thoroughly tested and certified',
        'Original accessories included'
      ],
      requirements: [
        'Available only for select premium products',
        'Product must pass 50-point inspection',
        'Original manufacturer parts used in restoration'
      ],
      price: 149.99,
      canPurchase: true,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/certified-Pre-owned.png',
      title: 'Certified Pre-owned',
      description:
          'Premium pre-owned products that have undergone extensive quality checks and certification.',
      benefits: [
        '90-day warranty coverage',
        'Comprehensive quality inspection',
        'Verified product history',
        'Professional cleaning and maintenance',
        'Competitive pricing'
      ],
      requirements: [
        'Product age less than 2 years',
        'Complete functionality verification',
        'No major cosmetic damage',
        'Original documentation available'
      ],
      price: 99.99,
      canPurchase: true,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/Digi-Cert.png',
      title: 'Digital Certificate',
      description:
          'Digital authentication and verification system for product authenticity.',
      benefits: [
        'Blockchain-based verification',
        'Instant authentication',
        'Secure ownership transfer',
        'Digital warranty tracking',
        'Access to exclusive digital services'
      ],
      requirements: [
        'Compatible product model',
        'Smart device for verification',
        'Internet connection for activation',
        'Valid email address'
      ],
      price: 29.99,
      canPurchase: true,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/Pre-owned.png',
      title: 'Pre-owned',
      description:
          'Quality used products that offer great value for budget-conscious buyers.',
      benefits: [
        '30-day warranty',
        'Basic quality check completed',
        'Significant cost savings',
        'Environmental sustainability',
        'Quick availability'
      ],
      requirements: [
        'As-is condition acceptance',
        'Limited return window',
        'Self-inspection recommended',
        'Purchase from authorized sellers only'
      ],
      canPurchase: false,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/protect-cert.png',
      title: 'Protection Certificate',
      description: 'Comprehensive protection plan for your valuable purchases.',
      benefits: [
        'Extended warranty coverage',
        'Accidental damage protection',
        'Free repairs or replacement',
        '24/7 support service',
        'No deductibles on claims'
      ],
      requirements: [
        'Purchase within 30 days of product buy',
        'Product in working condition',
        'Original purchase receipt',
        'Registration of protection plan'
      ],
      price: 199.99,
      canPurchase: true,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/refurb.png',
      title: 'Refurbished',
      description:
          'Restored products offering a balance of quality and affordability.',
      benefits: [
        '60-day warranty',
        'Basic restoration completed',
        'Performance testing done',
        'Affordable pricing',
        'Environmentally responsible choice'
      ],
      requirements: [
        'Understanding of refurbished status',
        'Possible cosmetic imperfections',
        'Limited warranty period',
        'As-available basis only'
      ],
      canPurchase: false,
    ),
    CertificateDetails(
      imagePath: 'assets/images/certs/Trace-Cert.png',
      title: 'Trace Certificate',
      description: 'Complete product history and authenticity tracking system.',
      benefits: [
        'Full product lifecycle tracking',
        'Ownership history verification',
        'Maintenance record access',
        'Anti-counterfeit protection',
        'Transfer of ownership documentation'
      ],
      requirements: [
        'Product serial number verification',
        'Original purchase documentation',
        'Owner identity verification',
        'Regular system updates'
      ],
      price: 79.99,
      canPurchase: true,
    ),
  ];

  const CertificatesDrawer({super.key});

  static void show(BuildContext context) {
    BaseDrawer.show(
      context: context,
      height: MediaQuery.of(context).size.height * 0.85,
      child: const CertificatesDrawer(),
      leadingAction: DrawerAction(
        text: 'Close',
        onTap: () => Navigator.pop(context),
        textColor: CupertinoColors.systemBlue,
      ),
    );
  }

  @override
  State<CertificatesDrawer> createState() => _CertificatesDrawerState();
}

class _CertificatesDrawerState extends State<CertificatesDrawer> {
  final ScrollController _detailsScrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _detailsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cert = CertificatesDrawer.certificates[_selectedIndex];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 1.0,
            mainAxisExtent: 80,
          ),
          itemCount: CertificatesDrawer.certificates.length,
          itemBuilder: (context, index) => _buildGridItem(index),
        ),
        Container(
          height: 1,
          color: const Color.fromARGB(255, 206, 206, 207),
        ),
        Expanded(
          child: CupertinoScrollbar(
            controller: _detailsScrollController,
            child: SingleChildScrollView(
              controller: _detailsScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                bottom: cert.canPurchase
                    ? 100
                    : 16, // Add padding at bottom for purchase drawer
              ),
              child: _buildCertificateDetails(cert),
            ),
          ),
        ),
        if (cert.canPurchase)
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              border: const Border(
                top: BorderSide(
                  color: CupertinoColors.separator,
                  width: 0.5,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Certificate Price',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                      Text(
                        '\$${cert.price?.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CupertinoButton.filled(
                    onPressed: () {
                      // Implement purchase logic
                    },
                    child: const Text('Purchase Now'),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGridItem(int index) {
    final cert = CertificatesDrawer.certificates[index];
    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        margin: const EdgeInsets.all(2), // Use margin instead of extra padding
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? CupertinoColors.activeOrange
                : CupertinoColors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0), // Reduced padding
          child: Image.asset(
            cert.imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildCertificateDetails(CertificateDetails cert) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Certificate Header
          Row(
            children: [
              Image.asset(cert.imagePath, width: 60, height: 60),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cert.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cert.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Benefits Section
          const Text(
            'Benefits',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...cert.benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        benefit,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),

          // Requirements Section
          const Text(
            'Requirements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...cert.requirements.map((requirement) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        requirement,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
