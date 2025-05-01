// lib/screens/surveys/tabs/completed_tab.dart
import 'package:flutter/cupertino.dart';

class CompletedSurveysTab extends StatefulWidget {
  const CompletedSurveysTab({super.key});

  @override
  State<CompletedSurveysTab> createState() => _CompletedSurveysTabState();
}

class _CompletedSurveysTabState extends State<CompletedSurveysTab> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  
  // Sample data for completed surveys
  final List<Map<String, dynamic>> _completedSurveys = [
    {
      'id': 'survey1',
      'title': 'Customer Satisfaction Evaluation',
      'date': 'March 20, 2024',
      'reward': '250',
      'category': 'CSAT',
      'description': 'Evaluation of overall customer experience',
    },
    {
      'id': 'survey2',
      'title': 'Product Feature Feedback',
      'date': 'March 18, 2024',
      'reward': '300',
      'category': 'Product Research',
      'description': 'Feedback on new product features',
    },
    {
      'id': 'survey3',
      'title': 'Shopping Experience Survey',
      'date': 'March 15, 2024',
      'reward': '150',
      'category': 'UX Research',
      'description': 'Analysis of online shopping experience',
    },
    {
      'id': 'survey4',
      'title': 'Market Trends Analysis',
      'date': 'March 17, 2024',
      'reward': '400',
      'category': 'Market Research',
      'description': 'Research on current market trends',
    },
    {
      'id': 'survey5',
      'title': 'Website Usability Feedback',
      'date': 'March 19, 2024',
      'reward': '200',
      'category': 'UX Research',
      'description': 'Evaluation of website user interface',
    },
    {
      'id': 'survey6',
      'title': 'Product Improvement Suggestions',
      'date': 'March 14, 2024',
      'reward': '350',
      'category': 'Product Research',
      'description': 'Ideas for product enhancements',
    },
    {
      'id': 'survey7',
      'title': 'App Usability Test Results',
      'date': 'March 13, 2024',
      'reward': '275',
      'category': 'UX Research',
      'description': 'Results from mobile app testing',
    },
    {
      'id': 'survey8',
      'title': 'Customer Needs Assessment',
      'date': 'March 12, 2024',
      'reward': '325',
      'category': 'Market Research',
      'description': 'Analysis of customer requirements',
    },
    {
      'id': 'survey9',
      'title': 'Service Quality Evaluation',
      'date': 'March 11, 2024',
      'reward': '225',
      'category': 'Service Evaluation',
      'description': 'Feedback on service quality',
    },
    {
      'id': 'survey10',
      'title': 'E-commerce Checkout Process',
      'date': 'March 10, 2024',
      'reward': '175',
      'category': 'UX Research',
      'description': 'Analysis of checkout flow',
    },
  ];
  
  List<Map<String, dynamic>> _filteredSurveys = [];

  @override
  void initState() {
    super.initState();
    _filteredSurveys = _completedSurveys;
    _searchController.addListener(_filterSurveys);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSurveys);
    _searchController.dispose();
    super.dispose();
  }

  void _filterSurveys() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredSurveys = _completedSurveys;
      } else {
        _filteredSurveys = _completedSurveys.where((survey) {
          return survey['title'].toLowerCase().contains(query) || 
                 survey['category'].toLowerCase().contains(query) ||
                 survey['description'].toLowerCase().contains(query);
        }).toList();
      }
    });
    
    // Debug print to verify the state is changing
    print("Completed: Search text changed: ${_searchController.text}");
    print("Completed: Filtered surveys: ${_filteredSurveys.length}");
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _filteredSurveys = _completedSurveys;
      } else {
        // Focus on the search field when it appears
        Future.delayed(const Duration(milliseconds: 100), () {
          FocusScope.of(context).requestFocus(FocusNode());
        });
      }
    });
    
    // Debug print to verify the state is changing
    print("Completed: Search state changed, _isSearching: $_isSearching");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // App bar with search button
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                decoration: BoxDecoration(
                  color: _isSearching ? CupertinoColors.systemOrange.withOpacity(0.1) : CupertinoColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey5,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _isSearching 
                    ? const Text(
                      'Search Mode',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.activeOrange,
                      ),
                    )
                    : const Text(
                      'Completed Research',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _isSearching ? CupertinoColors.destructiveRed : CupertinoColors.activeOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CupertinoButton(
                        padding: const EdgeInsets.all(8),
                        onPressed: _toggleSearch,
                        child: Icon(
                          _isSearching ? CupertinoIcons.xmark : CupertinoIcons.search,
                          size: 20,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Search bar (when searching)
            if (_isSearching)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemOrange.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: CupertinoColors.activeOrange.withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.systemGrey5,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Search Completed Surveys',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: CupertinoColors.activeOrange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CupertinoSearchTextField(
                        controller: _searchController,
                        placeholder: 'Type to search...',
                        prefixIcon: const Icon(CupertinoIcons.search, size: 20),
                        suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill, size: 20),
                        suffixMode: OverlayVisibilityMode.editing,
                        onSuffixTap: () => _searchController.clear(),
                        style: const TextStyle(fontSize: 16),
                        backgroundColor: CupertinoColors.white,
                        autocorrect: false,
                        onChanged: (value) {
                          // Explicit call to filter when text changes
                          _filterSurveys();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
            // Stats Summary
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats card
                    Container(
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
                      child: Row(
                        children: [
                          Expanded(child: _buildStatItem('Total\nCompleted', '${_completedSurveys.length}')),
                          _buildDivider(),
                          Expanded(child: _buildStatItem('This\nMonth', '${_completedSurveys.length}')),
                          _buildDivider(),
                          Expanded(
                            child: _buildStatItem(
                              'Earned\nPoints', 
                              '${_completedSurveys.fold(0, (sum, survey) => sum + int.parse(survey['reward']))}'
                            )
                          ),
                        ],
                      ),
                    ),
                    
                    // Search button below stats card for better visibility
                    if (!_isSearching)
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          color: CupertinoColors.activeOrange,
                          borderRadius: BorderRadius.circular(10),
                          onPressed: _toggleSearch,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(CupertinoIcons.search, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Search Completed Surveys',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            // Empty state message when no results are found
            if (_filteredSurveys.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CupertinoIcons.search,
                        size: 50,
                        color: CupertinoColors.systemGrey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No matching surveys found',
                        style: TextStyle(
                          fontSize: 18,
                          color: CupertinoColors.systemGrey.darkColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try adjusting your search',
                        style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Completed Surveys List (filtered)
            if (_filteredSurveys.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final survey = _filteredSurveys[index];
                      return _buildCompletedSurvey(
                        title: survey['title'],
                        date: survey['date'],
                        reward: survey['reward'],
                        category: survey['category'],
                        description: survey['description'],
                      );
                    },
                    childCount: _filteredSurveys.length,
                  ),
                ),
              ),
          ],
        ),
        
        // Floating action button for search
        if (!_isSearching)
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: _toggleSearch,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: CupertinoColors.activeOrange,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.activeOrange.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  CupertinoIcons.search,
                  color: CupertinoColors.white,
                  size: 28,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CupertinoColors.white.withOpacity(0.8),
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const SizedBox(width: 12);
  }

  Widget _buildCompletedSurvey({
    required String title,
    required String date,
    required String reward,
    required String category,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle survey details tap
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEAD1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    CupertinoIcons.checkmark_circle_fill,
                    color: CupertinoColors.activeOrange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey6,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              category,
                              style: const TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEEAD1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.bitcoin,
                        size: 14,
                        color: CupertinoColors.activeOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        reward,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: CupertinoColors.activeOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 14,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
