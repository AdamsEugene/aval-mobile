import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screen/surveys/survey_questions_screen.dart';

class IncompleteSurveysTab extends StatefulWidget {
  const IncompleteSurveysTab({super.key});

  @override
  State<IncompleteSurveysTab> createState() => _IncompleteSurveysTabState();
}

class _IncompleteSurveysTabState extends State<IncompleteSurveysTab> {
  // Sample data for incomplete surveys
  final List<Map<String, dynamic>> _incompleteSurveys = [
    {
      'id': 'survey1',
      'title': 'UX Feedback Survey',
      'progress': 45,
      'date': 'Started: March 20, 2024',
      'reward': '250',
      'category': 'UX Research',
      'description': 'Help us improve our app interface',
      'duration': '10-15 min',
      'currentQuestionIndex': 2,
      'totalQuestions': 5,
    },
    {
      'id': 'survey2',
      'title': 'Product Test Feedback',
      'progress': 30,
      'date': 'Started: March 18, 2024',
      'reward': '300',
      'category': 'Product Testing',
      'description': 'Evaluate our new electronics product',
      'duration': '15-20 min',
      'currentQuestionIndex': 1,
      'totalQuestions': 6,
    },
    {
      'id': 'survey3',
      'title': 'Customer Satisfaction',
      'progress': 70,
      'date': 'Started: March 15, 2024',
      'reward': '150',
      'category': 'CSAT',
      'description': 'Rate your recent shopping experience',
      'duration': '5-8 min',
      'currentQuestionIndex': 3,
      'totalQuestions': 5,
    },
    {
      'id': 'survey4',
      'title': 'E-Commerce Trends',
      'progress': 25,
      'date': 'Started: March 17, 2024',
      'reward': '400',
      'category': 'Market Research',
      'description': 'Share insights about online shopping habits',
      'duration': '10-12 min',
      'currentQuestionIndex': 1,
      'totalQuestions': 8,
    },
    {
      'id': 'survey5',
      'title': 'Website Usability Test',
      'progress': 60,
      'date': 'Started: March 19, 2024',
      'reward': '200',
      'category': 'UX Research',
      'description': 'Test our website navigation and features',
      'duration': '8-10 min',
      'currentQuestionIndex': 3,
      'totalQuestions': 5,
    },
    {
      'id': 'survey6',
      'title': 'Product Feature Prioritization',
      'progress': 15,
      'date': 'Started: March 21, 2024',
      'reward': '350',
      'category': 'Feature Prioritization',
      'description': 'Help us decide which features to develop next',
      'duration': '12-15 min',
      'currentQuestionIndex': 1,
      'totalQuestions': 7,
    },
  ];
  
  // For search functionality
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredSurveys = [];

  @override
  void initState() {
    super.initState();
    _filteredSurveys = _incompleteSurveys;
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
        _filteredSurveys = _incompleteSurveys;
      } else {
        _filteredSurveys = _incompleteSurveys.where((survey) {
          return survey['title'].toLowerCase().contains(query) || 
                 survey['category'].toLowerCase().contains(query) ||
                 survey['description'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
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
                  color: _isSearching ? CupertinoColors.systemBlue.withOpacity(0.1) : CupertinoColors.white,
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
                        color: CupertinoColors.activeBlue,
                      ),
                    )
                    : const Text(
                      'Incomplete Surveys',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _isSearching ? CupertinoColors.destructiveRed : CupertinoColors.activeBlue,
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
                    color: CupertinoColors.systemBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: CupertinoColors.activeBlue.withOpacity(0.3), width: 2),
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
                        'Search Incomplete Surveys',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: CupertinoColors.activeBlue,
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
                          print("Search text changed: $value");
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
                            Color(0xFF6448FE),
                            Color(0xFF5FC3E4),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6448FE).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(child: _buildStatItem('Total\nIncomplete', '${_incompleteSurveys.length}')),
                          _buildDivider(),
                          Expanded(child: _buildStatItem('Awaiting\nSubmission', '${_incompleteSurveys.length}')),
                          _buildDivider(),
                          Expanded(
                            child: _buildStatItem(
                              'Potential\nPoints', 
                              '${_incompleteSurveys.fold(0, (sum, survey) => sum + int.parse(survey['reward']))}'
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
                          color: CupertinoColors.activeBlue,
                          borderRadius: BorderRadius.circular(10),
                          onPressed: _toggleSearch,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(CupertinoIcons.search, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Search Incomplete Surveys',
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

            // Incomplete Surveys List (filtered)
            if (_filteredSurveys.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final survey = _filteredSurveys[index];
                      return _buildIncompleteSurvey(
                        title: survey['title'],
                        progress: survey['progress'],
                        date: survey['date'],
                        reward: survey['reward'],
                        category: survey['category'],
                        description: survey['description'],
                        duration: survey['duration'],
                        currentQuestionIndex: survey['currentQuestionIndex'],
                        totalQuestions: survey['totalQuestions'],
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
                  color: CupertinoColors.activeBlue,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.activeBlue.withOpacity(0.4),
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

  Widget _buildIncompleteSurvey({
    required String title,
    required int progress,
    required String date,
    required String reward,
    required String category,
    required String description,
    required String duration,
    required int currentQuestionIndex,
    required int totalQuestions,
  }) {
    return GestureDetector(
      onTap: () => _continueSurvey(
        title: title,
        category: category,
        reward: reward,
        description: description,
        duration: duration,
        currentQuestionIndex: currentQuestionIndex,
      ),
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
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    CupertinoIcons.time,
                    color: Color(0xFF2196F3),
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
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        CupertinoIcons.bitcoin,
                        size: 14,
                        color: Color(0xFF2196F3),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        reward,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      height: 8,
                      color: CupertinoColors.systemGrey5,
                      child: Row(
                        children: [
                          Container(
                            width: progress / 100 * (300),
                            color: const Color(0xFF2196F3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "$progress%",
                  style: const TextStyle(
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Question $currentQuestionIndex of $totalQuestions",
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(8),
              minSize: 0,
              onPressed: () => _continueSurvey(
                title: title,
                category: category,
                reward: reward,
                description: description,
                duration: duration,
                currentQuestionIndex: currentQuestionIndex,
              ),
              child: const Text(
                'Continue Survey',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _continueSurvey({
    required String title,
    required String category,
    required String reward,
    required String description,
    required String duration,
    required int currentQuestionIndex,
  }) {
    // Show confirmation dialog
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Continue Survey'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text(
            'You will continue from question $currentQuestionIndex. Your previous answers have been saved.',
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to the survey questions screen with saved state
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => SurveyQuestionsScreen(
                    title: title,
                    category: category,
                    reward: reward,
                    startingQuestionIndex: currentQuestionIndex - 1, // Index is 0-based
                  ),
                ),
              );
            },
            isDefaultAction: true,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
} 