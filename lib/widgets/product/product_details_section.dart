import 'package:flutter/cupertino.dart';

class ProductDetailsSection extends StatelessWidget {
  final String description;
  final bool expandable;

  const ProductDetailsSection({
    super.key,
    required this.description,
    this.expandable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'More Product Details',
              style: TextStyle(
                color: Color(0xFF05001E),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Descriptions',
                  style: TextStyle(
                    color: Color(0xFF05001E),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                if (expandable) ...[
                  _ExpandableDescription(description: description),
                ] else ...[
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandableDescription extends StatefulWidget {
  final String description;

  const _ExpandableDescription({
    required this.description,
  });

  @override
  State<_ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<_ExpandableDescription> {
  bool _isExpanded = false;
  bool? _needsExpansion;
  static const int _maxLines = 3;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateIfNeedsExpansion();
  }

  void _calculateIfNeedsExpansion() {
    // Calculate if text needs expansion button
    final span = TextSpan(
      text: widget.description,
      style: const TextStyle(
        color: Color(0xFF4A4A4A),
        fontSize: 15,
        height: 1.5,
      ),
    );
    final tp = TextPainter(
      text: span,
      maxLines: _maxLines,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: MediaQuery.of(context).size.width - 32);
    _needsExpansion = tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    if (_needsExpansion == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.description,
          maxLines: _isExpanded ? null : _maxLines,
          overflow: _isExpanded ? null : TextOverflow.fade,
          style: const TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 15,
            height: 1.5,
          ),
        ),
        if (_needsExpansion!) ...[
          const SizedBox(height: 8),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _isExpanded ? 'Show Less' : 'Read More',
                  style: const TextStyle(
                    color: CupertinoColors.systemBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _isExpanded
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  size: 14,
                  color: CupertinoColors.systemBlue,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
