import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class SurveyQuestion {
  final String id;
  final String question;
  final QuestionType type;
  final List<String>? options;
  final int? maxRating;
  String? answer;
  int? ratingAnswer;

  SurveyQuestion({
    required this.id,
    required this.question,
    required this.type,
    this.options,
    this.maxRating,
    this.answer,
    this.ratingAnswer,
  });
}

enum QuestionType {
  multipleChoice,
  rating,
  openEnded,
  scenario,
}

class SurveyQuestionsScreen extends StatefulWidget {
  final String title;
  final String category;
  final String reward;
  final int startingQuestionIndex;
  
  const SurveyQuestionsScreen({
    super.key,
    required this.title,
    required this.category,
    required this.reward,
    this.startingQuestionIndex = 0,
  });

  @override
  State<SurveyQuestionsScreen> createState() => _SurveyQuestionsScreenState();
}

class _SurveyQuestionsScreenState extends State<SurveyQuestionsScreen> {
  late int _currentQuestionIndex;
  bool _isSurveyComplete = false;
  final TextEditingController _textController = TextEditingController();
  final List<SurveyQuestion> _questions = [];
  
  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _currentQuestionIndex = widget.startingQuestionIndex;
  }
  
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  
  void _loadQuestions() {
    // Load questions based on survey category
    switch (widget.category) {
      case 'UX Research':
        _questions.addAll([
          SurveyQuestion(
            id: 'q1',
            question: 'How would you rate the overall usability of our app?',
            type: QuestionType.rating,
            maxRating: 5,
          ),
          SurveyQuestion(
            id: 'q2',
            question: 'Which features do you find most useful in our app?',
            type: QuestionType.multipleChoice,
            options: [
              'Search functionality',
              'Product recommendations',
              'User reviews',
              'Easy checkout process',
              'Order tracking',
            ],
          ),
          SurveyQuestion(
            id: 'q3',
            question: 'What challenges do you face when using our app?',
            type: QuestionType.openEnded,
          ),
          SurveyQuestion(
            id: 'q4',
            question: 'Scenario: You\'re looking for a specific product but can\'t find it in the search results. What would you do next?',
            type: QuestionType.multipleChoice,
            options: [
              'Look through categories manually',
              'Try different search terms',
              'Use filters to narrow down options',
              'Contact customer support',
              'Give up and try another app',
            ],
          ),
          SurveyQuestion(
            id: 'q5',
            question: 'How likely are you to recommend our app to friends or colleagues?',
            type: QuestionType.rating,
            maxRating: 10,
          ),
        ]);
        break;
        
      case 'Product Research':
        _questions.addAll([
          SurveyQuestion(
            id: 'q1',
            question: 'How satisfied are you with our checkout process?',
            type: QuestionType.rating,
            maxRating: 5,
          ),
          SurveyQuestion(
            id: 'q2',
            question: 'Which payment methods do you prefer?',
            type: QuestionType.multipleChoice,
            options: [
              'Credit/Debit Cards',
              'Mobile Money',
              'Bank Transfer',
              'PayPal',
              'Cash on Delivery',
            ],
          ),
          SurveyQuestion(
            id: 'q3',
            question: 'What improvements would you suggest for our checkout process?',
            type: QuestionType.openEnded,
          ),
          SurveyQuestion(
            id: 'q4',
            question: 'How important is the delivery speed to your purchasing decision?',
            type: QuestionType.rating,
            maxRating: 5,
          ),
          SurveyQuestion(
            id: 'q5',
            question: 'What additional features would you like to see in our app?',
            type: QuestionType.openEnded,
          ),
        ]);
        break;
        
      default:
        // Default questions for any category
        _questions.addAll([
          SurveyQuestion(
            id: 'q1',
            question: 'How would you rate your experience with our service?',
            type: QuestionType.rating,
            maxRating: 5,
          ),
          SurveyQuestion(
            id: 'q2',
            question: 'Which aspects of our service do you value most?',
            type: QuestionType.multipleChoice,
            options: [
              'Ease of use',
              'Customer support',
              'Product quality',
              'Delivery options',
              'Value for money',
            ],
          ),
          SurveyQuestion(
            id: 'q3',
            question: 'What improvements would you like to see?',
            type: QuestionType.openEnded,
          ),
          SurveyQuestion(
            id: 'q4',
            question: 'How likely are you to use our service again?',
            type: QuestionType.rating,
            maxRating: 10,
          ),
          SurveyQuestion(
            id: 'q5',
            question: 'Any additional feedback you would like to share?',
            type: QuestionType.openEnded,
          ),
        ]);
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _completeSurvey();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _completeSurvey() {
    setState(() {
      _isSurveyComplete = true;
    });
    
    // In a real app, we would submit the survey responses to a backend here
    
    // Show completion dialog
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Survey Completed!'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              const Text(
                'Thank you for completing the survey. Your feedback is valuable to us.',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.bitcoin,
                    size: 20,
                    color: CupertinoColors.activeOrange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${widget.reward} points',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.activeOrange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'have been added to your account!',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              // Close the dialog and navigate back to previous screens
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  // Save the current question's answer
  void _saveAnswer(String? answer) {
    setState(() {
      _questions[_currentQuestionIndex].answer = answer;
    });
  }
  
  // Save the current question's rating
  void _saveRating(int rating) {
    setState(() {
      _questions[_currentQuestionIndex].ratingAnswer = rating;
    });
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
                  MainHeader(
                    leading: Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      HeaderAction(
                        icon: CupertinoIcons.xmark_circle,
                        onPressed: () {
                          _showExitConfirmationDialog();
                        },
                      ),
                    ],
                    withBack: true,
                  ),
                  SliverToBoxAdapter(
                    child: _buildProgressIndicator(),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _isSurveyComplete
                        ? _buildCompletionScreen()
                        : _buildQuestionContent(),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    double progress = _questions.isEmpty ? 0 : (_currentQuestionIndex + 1) / _questions.length;
    final double availableWidth = MediaQuery.of(context).size.width - 32; // Full width minus padding
    
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                style: const TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    CupertinoIcons.bitcoin,
                    size: 14,
                    color: CupertinoColors.activeOrange,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.reward,
                    style: const TextStyle(
                      color: CupertinoColors.activeOrange,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  width: availableWidth * progress,
                  decoration: BoxDecoration(
                    color: const Color(0xFF05001E),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent() {
    if (_questions.isEmpty) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
    
    final currentQuestion = _questions[_currentQuestionIndex];
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(16),
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
                _buildQuestionBadge(currentQuestion.type),
                const SizedBox(height: 16),
                Text(
                  currentQuestion.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 24),
                _buildQuestionInput(currentQuestion),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildQuestionBadge(QuestionType type) {
    String label;
    Color color;
    IconData icon;
    
    switch (type) {
      case QuestionType.multipleChoice:
        label = 'Multiple Choice';
        color = const Color(0xFF6A5ACD);
        icon = CupertinoIcons.list_bullet;
        break;
      case QuestionType.rating:
        label = 'Rating';
        color = const Color(0xFF4CAF50);
        icon = CupertinoIcons.star;
        break;
      case QuestionType.openEnded:
        label = 'Open Ended';
        color = const Color(0xFF2196F3);
        icon = CupertinoIcons.text_cursor;
        break;
      case QuestionType.scenario:
        label = 'Scenario';
        color = const Color(0xFFFF9800);
        icon = CupertinoIcons.lightbulb;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(SurveyQuestion question) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return _buildMultipleChoiceQuestion(question);
      case QuestionType.rating:
        return _buildRatingQuestion(question);
      case QuestionType.openEnded:
      case QuestionType.scenario:
        return _buildOpenEndedQuestion(question);
    }
  }

  Widget _buildMultipleChoiceQuestion(SurveyQuestion question) {
    return Column(
      children: question.options!.map((option) {
        bool isSelected = question.answer == option;
        
        return GestureDetector(
          onTap: () {
            _saveAnswer(option);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFE5F6FF) : const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? const Color(0xFF0077CC) : const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? const Color(0xFF0077CC) : const Color(0xFF333333),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color(0xFF0077CC) : CupertinoColors.white,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF0077CC) : const Color(0xFFCCCCCC),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          CupertinoIcons.check_mark,
                          size: 14,
                          color: CupertinoColors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRatingQuestion(SurveyQuestion question) {
    // Adjust circle size based on rating count to avoid overflow
    final double circleSize = question.maxRating! <= 5 ? 40.0 : 30.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(question.maxRating!, (index) {
            final rating = index + 1;
            final isSelected = question.ratingAnswer == rating;
            
            return GestureDetector(
              onTap: () {
                _saveRating(rating);
              },
              child: Column(
                children: [
                  Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? const Color(0xFF05001E) : CupertinoColors.white,
                      border: Border.all(
                        color: isSelected ? const Color(0xFF05001E) : const Color(0xFFCCCCCC),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                          fontSize: isSelected ? (circleSize * 0.4) : (circleSize * 0.35),
                          fontWeight: FontWeight.bold,
                          color: isSelected ? CupertinoColors.white : const Color(0xFF333333),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Poor',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
            const Text(
              'Excellent',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOpenEndedQuestion(SurveyQuestion question) {
    // Initialize controller with existing answer if any
    if (question.answer != null && _textController.text.isEmpty) {
      _textController.text = question.answer!;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: CupertinoTextField(
            controller: _textController,
            placeholder: 'Type your answer here...',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF333333),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            maxLines: 5,
            onChanged: (value) {
              _saveAnswer(value);
            },
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Please provide as much detail as possible.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF666666),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: Color(0xFF4CAF50),
            size: 80,
          ),
          const SizedBox(height: 24),
          const Text(
            'Survey Completed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Thank you for your valuable feedback.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: CupertinoColors.activeOrange.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Reward Earned',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.bitcoin,
                      size: 24,
                      color: CupertinoColors.activeOrange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.reward,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.activeOrange,
                      ),
                    ),
                    const Text(
                      ' points',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.activeOrange,
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

  Widget _buildBottomNav() {
    final currentQuestion = _questions.isEmpty ? null : _questions[_currentQuestionIndex];
    final bool canProceed = currentQuestion == null || 
        (currentQuestion.type == QuestionType.multipleChoice && currentQuestion.answer != null) ||
        (currentQuestion.type == QuestionType.rating && currentQuestion.ratingAnswer != null) ||
        (currentQuestion.type == QuestionType.openEnded && 
            currentQuestion.answer != null && 
            currentQuestion.answer!.trim().isNotEmpty) ||
        (currentQuestion.type == QuestionType.scenario && 
            currentQuestion.answer != null && 
            currentQuestion.answer!.trim().isNotEmpty);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentQuestionIndex > 0)
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _previousQuestion,
              child: const Row(
                children: [
                  Icon(
                    CupertinoIcons.arrow_left,
                    color: Color(0xFF666666),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Previous',
                    style: TextStyle(
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(width: 90), // Placeholder to maintain layout when no back button
          
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: canProceed ? const Color(0xFF05001E) : const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(12),
            onPressed: canProceed ? _nextQuestion : null,
            child: Text(
              _currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Submit',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Exit Survey?'),
        content: const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Do you want to save your progress and continue later?',
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              // Exit without saving
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Exit to previous screen
            },
            child: const Text('Exit Without Saving'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              // Save progress and exit
              _saveProgress();
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Exit to previous screen
            },
            child: const Text('Save & Exit'),
          ),
        ],
      ),
    );
  }
  
  void _saveProgress() {
    // In a real app, this would save the progress to a backend or local storage
    // For this demo, we're just simulating that it's saved
    
    // You can add a visual indicator that progress is saved
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your progress has been saved!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
    
    // Here you would save:
    // 1. The survey identifier
    // 2. The current question index
    // 3. All answered questions
    // 4. Timestamp for when it was saved
  }
} 