import 'package:e_commerce_app/widgets/magic_box/magic_box_carousel.dart';
import 'package:flutter/cupertino.dart';

class AllMagicBoxesPage extends StatefulWidget {
  final List<MagicBoxTheme> boxes;

  const AllMagicBoxesPage({
    super.key,
    required this.boxes,
  });

  @override
  State<AllMagicBoxesPage> createState() => _AllMagicBoxesPageState();
}

class _AllMagicBoxesPageState extends State<AllMagicBoxesPage> {
  String _selectedCategory = 'All Boxes';

  final List<String> _categories = [
    'All Boxes',
    'Popular',
    'Value',
    'Premium',
    'Limited Edition',
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Mystery Boxes'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildBoxesCategoryTabs(),
            _buildSubheader(),
            Expanded(
              child: _buildMagicBoxGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubheader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: const Text(
        'Discover premium products at amazing prices',
        style: TextStyle(
          fontSize: 14,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  Widget _buildBoxesCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: isSelected
                  ? CupertinoColors.activeBlue
                  : CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(20),
              minSize: 0,
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMagicBoxGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7, // Adjusted from 0.75 to give more height
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: widget.boxes.length,
      itemBuilder: (context, index) {
        final box = widget.boxes[index];
        return _buildMagicBoxCard(box, index);
      },
    );
  }

  Widget _buildMagicBoxCard(MagicBoxTheme box, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: box.startColor.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _showBoxDetails(box);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Box visual
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        box.startColor,
                        box.endColor,
                      ],
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Center icon
                      Center(
                        child: Icon(
                          CupertinoIcons.gift_fill,
                          size: 60,
                          color: CupertinoColors.white.withOpacity(0.9),
                        ),
                      ),

                      // Value indicator for boxes that are a good deal
                      if (index % 2 == 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '50% OFF',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: box.startColor,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Box info
              Expanded(
                flex: 2,
                child: Container(
                  color: CupertinoColors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Box name
                      Text(
                        box.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Description text
                      Text(
                        _getBoxDescription(box.title),
                        style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.systemGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Price and buy button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${box.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: box.startColor,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: box.startColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'BUY',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBoxDetails(MagicBoxTheme box) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(box.title),
        content: Column(
          children: [
            const SizedBox(height: 8),
            Text(_getBoxDescription(box.title)),
            const SizedBox(height: 8),
            Text('Price: \$${box.price.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Purchase'),
            onPressed: () {
              Navigator.pop(context);
              // Handle purchase logic
            },
          ),
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  String _getBoxDescription(String boxTitle) {
    // Generate unique descriptions based on box title
    switch (boxTitle.toLowerCase()) {
      case 'mystery box':
        return 'A surprise selection of popular items at a great value.';
      case 'pure magic box':
        return 'Premium quality items with guaranteed superior value.';
      case 'premium box':
        return 'Luxury items with a minimum value of \$50+';
      case 'deluxe box':
        return 'High-end collection with exclusive items worth \$75+';
      case 'ultimate box':
        return 'Our finest selection with luxury items worth \$100+';
      default:
        return 'A special selection of surprise products at amazing value.';
    }
  }
}
