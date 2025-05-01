// lib/screens/surveys/surveys_screen.dart
import 'package:e_commerce_app/screen/surveys/tabs/available_tab.dart';
import 'package:e_commerce_app/screen/surveys/tabs/completed_tab.dart';
import 'package:e_commerce_app/screen/surveys/tabs/rewards_tab.dart';
import 'package:e_commerce_app/screen/surveys/tabs/incomplete_tab.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';
import 'package:flutter/material.dart';

class SurveysScreen extends StatefulWidget {
  const SurveysScreen({super.key});

  @override
  State<SurveysScreen> createState() => _SurveysScreenState();
}

class _SurveysScreenState extends State<SurveysScreen> {
  int _selectedTabIndex = 0;
  int _selectedNavIndex = 1;
  bool _showWelcomeInfo = true;
  String _selectedCategory = 'All';
  String _selectedIndustry = 'All Industries';
  
  final List<String> _categories = [
    'All',
    'Product Research',
    'UX Research',
    'Market Research',
    'User Behavior',
    'Feature Prioritization',
    'Service Evaluation',
    'CSAT',
    'Educational Technology',
    'Product Usage',
  ];
  
  final List<String> _industries = [
    'All Industries',
    'Technology & Software',
    'Healthcare',
    'Finance & Banking',
    'Retail & E-commerce',
    'Media & Entertainment',
    'Consumer Electronics',
    'Food & Beverage',
    'Automotive',
    'Education',
    'Telecommunications',
    'Pharmaceuticals',
    'Energy',
  ];

  final List<CustomTabItem<String>> _bottomNavItems = [
    CustomTabItem(
      icon: CupertinoIcons.chevron_left,
      label: 'Back',
      data: 'back',
    ),
    CustomTabItem(
      icon: CupertinoIcons.doc_text,
      label: 'Available',
      data: 'available',
    ),
    CustomTabItem(
      icon: CupertinoIcons.time,
      label: 'Incomplete',
      data: 'incomplete',
    ),
    CustomTabItem(
      icon: CupertinoIcons.checkmark_circle,
      label: 'Completed',
      data: 'completed',
    ),
    CustomTabItem(
      icon: CupertinoIcons.gift,
      label: 'Rewards',
      data: 'rewards',
    ),
  ];

  String _getHeaderTitle() {
    switch (_selectedTabIndex) {
      case 0:
        return 'R&D Surveys';
      case 1:
        return 'Incomplete Surveys';
      case 2:
        return 'Completed Research';
      case 3:
        return 'Research Rewards';
      default:
        return 'R&D Program';
    }
  }

  List<HeaderAction> _getHeaderActions() {
    switch (_selectedTabIndex) {
      case 0:
        return [
          HeaderAction(
            icon: CupertinoIcons.slider_horizontal_3,
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.info_circle,
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ];
      case 1:
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Switch to incomplete tab and let it handle search internally
              setState(() {
                _selectedTabIndex = 1;
                _selectedNavIndex = 2;  // Index for the incomplete tab in bottom nav
              });
              // The IncompleteSurveysTab now has its own search buttons
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.info_circle,
            onPressed: () {
              _showIncompleteInfoDialog(context);
            },
          ),
        ];
      case 2:
        return [
          HeaderAction(
            icon: CupertinoIcons.search,
            onPressed: () {
              // Switch to completed tab and let it handle search internally
              setState(() {
                _selectedTabIndex = 2;
                _selectedNavIndex = 3;  // Index for the completed tab in bottom nav
              });
              // The CompletedSurveysTab will handle the search
            },
          ),
          HeaderAction(
            icon: CupertinoIcons.calendar,
            onPressed: () {
              // Handle date filter
            },
          ),
        ];
      case 3:
        return [
          HeaderAction(
            icon: CupertinoIcons.info_circle,
            onPressed: () {
              _showRewardsInfoDialog(context);
            },
          ),
        ];
      default:
        return [];
    }
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getHeaderTitle(),
              style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: _getHeaderActions(),
    );
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
      if (_bottomNavItems[index].data == 'available') {
        _selectedTabIndex = 0;
      } else if (_bottomNavItems[index].data == 'incomplete') {
        _selectedTabIndex = 1;
      } else if (_bottomNavItems[index].data == 'completed') {
        _selectedTabIndex = 2;
      } else if (_bottomNavItems[index].data == 'rewards') {
        _selectedTabIndex = 3;
      }
    });

    if (_bottomNavItems[index].data == 'back') {
      Navigator.of(context).pop();
    }
  }
  
  void _showFilterDialog(BuildContext context) {
    // Create temporary variables to hold selections until applied
    String tempCategory = _selectedCategory;
    String tempIndustry = _selectedIndustry;
    
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter Surveys',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          CupertinoIcons.xmark,
                          size: 16,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Filter sections container
                Expanded(
                  child: CupertinoScrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Industry section
                          _buildFilterSectionHeader('Industry', 'Select the industry you\'re interested in'),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _industries.length,
                              separatorBuilder: (context, index) => const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              itemBuilder: (context, index) {
                                final industry = _industries[index];
                                return CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setModalState(() {
                                      tempIndustry = industry;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            industry,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: tempIndustry == industry 
                                                ? const Color(0xFF0077CC) 
                                                : CupertinoColors.black,
                                              fontWeight: tempIndustry == industry 
                                                ? FontWeight.w600 
                                                : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (tempIndustry == industry)
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0077CC),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              CupertinoIcons.checkmark,
                                              color: CupertinoColors.white,
                                              size: 16,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Survey Type section
                          _buildFilterSectionHeader('Survey Type', 'Choose the type of surveys to view'),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _categories.length,
                              separatorBuilder: (context, index) => const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                return CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setModalState(() {
                                      tempCategory = category;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            category,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: tempCategory == category 
                                                ? const Color(0xFF0077CC) 
                                                : CupertinoColors.black,
                                              fontWeight: tempCategory == category 
                                                ? FontWeight.w600 
                                                : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        if (tempCategory == category)
                                          Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0077CC),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              CupertinoIcons.checkmark,
                                              color: CupertinoColors.white,
                                              size: 16,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        onPressed: () {
                          setState(() {
                            _selectedCategory = 'All';
                            _selectedIndustry = 'All Industries';
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Reset Filters',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: const Color(0xFF05001E),
                        borderRadius: BorderRadius.circular(12),
                        onPressed: () {
                          setState(() {
                            _selectedCategory = tempCategory;
                            _selectedIndustry = tempIndustry;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
  
  Widget _buildFilterSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
  
  void _showInfoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('About R&D Surveys'),
        content: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Our Research & Development surveys help businesses improve their products and services through direct customer feedback. '
            '\n\nAs outlined in our R&D project, these surveys provide benefits such as:'
            '\n• Innovation and competitive advantage'
            '\n• Improved efficiency and cost reduction'
            '\n• Enhanced customer satisfaction'
            '\n• Market expansion opportunities'
            '\n• Revenue growth through new product development'
            '\n\nBy participating, you earn rewards while directly influencing future products and services.'
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              setState(() {
                _showWelcomeInfo = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Don\'t Show Again'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: const Text('Got It'),
          ),
        ],
      ),
    );
  }
  
  void _showRewardsInfoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Research Rewards Program'),
        content: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Earn points by completing R&D surveys:\n\n'
            '• Short surveys (5-10 min): 100-300 points\n'
            '• Medium surveys (10-15 min): 300-500 points\n'
            '• In-depth studies (15+ min): 500+ points\n\n'
            'Points can be redeemed for:'
            '\n• Store discounts and coupons'
            '\n• Gift cards to popular retailers'
            '\n• Early access to new products'
            '\n• Premium service upgrades'
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: const Text('Got It'),
          ),
        ],
      ),
    );
  }

  void _showIncompleteInfoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Incomplete Surveys'),
        content: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'These are surveys you\'ve started but haven\'t completed yet. You can continue where you left off and complete them to earn rewards.\n\n'
            'Benefits of completing your surveys:\n'
            '• Earn full reward points\n'
            '• Contribute valuable feedback\n'
            '• Unlock higher-tier survey opportunities\n'
            '• Maintain your survey completion rate'
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            child: const Text('Got It'),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    if (!_showWelcomeInfo) return const SizedBox.shrink();
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F6FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF0077CC), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Help Shape Our Future Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF0077CC),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showWelcomeInfo = false;
                  });
                },
                child: const Icon(
                  CupertinoIcons.clear_circled_solid,
                  color: Color(0xFF0077CC),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Your feedback through our R&D surveys directly influences business decisions and product development. Complete surveys to earn rewards and contribute to innovation.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF444444),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoButton(
                'Learn More',
                CupertinoIcons.info_circle,
                const Color(0xFF0077CC),
                () => _showInfoDialog(context),
              ),
              const SizedBox(width: 8),
              _buildInfoButton(
                'View Rewards',
                CupertinoIcons.gift_fill,
                const Color(0xFFFF9500),
                () => _showRewardsInfoDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoButton(String label, IconData icon, Color color, VoidCallback onPressed) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      minSize: 0,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFilters() {
    if (_selectedCategory == 'All' && _selectedIndustry == 'All Industries') {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (_selectedCategory != 'All')
            _buildFilterChip(
              _selectedCategory, 
              CupertinoIcons.tag_fill,
              () {
                setState(() {
                  _selectedCategory = 'All';
                });
              },
            ),
          if (_selectedIndustry != 'All Industries')
            _buildFilterChip(
              _selectedIndustry, 
              CupertinoIcons.building_2_fill,
              () {
                setState(() {
                  _selectedIndustry = 'All Industries';
                });
              },
            ),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip(String label, IconData icon, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: const Color(0xFF0077CC),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF0077CC),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(
              CupertinoIcons.clear_circled_solid,
              size: 16,
              color: Color(0xFF0077CC),
            ),
          ),
        ],
      ),
    );
  }

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
                  _buildHeader(context),
                  SliverToBoxAdapter(
                    child: _buildWelcomeBanner(),
                  ),
                  SliverToBoxAdapter(
                    child: _buildActiveFilters(),
                  ),
                  SliverFillRemaining(
                    child: IndexedStack(
                      index: _selectedTabIndex,
                      children: const [
                        AvailableSurveysTab(),
                        IncompleteSurveysTab(),
                        CompletedSurveysTab(),
                        SurveyRewardsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoTabBar(
            backgroundColor: const Color(0xFF05001E),
            activeColor: CupertinoColors.white,
            inactiveColor: CupertinoColors.systemGrey,
            currentIndex: _selectedNavIndex,
            onTap: _handleBottomNavTap,
            items: _bottomNavItems
                .map((item) => item.toBottomNavigationBarItem())
                .toList(),
          ),
        ],
      ),
    );
  }
}
