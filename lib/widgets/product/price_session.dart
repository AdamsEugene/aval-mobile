import 'package:flutter/cupertino.dart';

class PriceSession extends StatelessWidget {
  const PriceSession({super.key});

  Widget _buildPriceBlock({
    required String price,
    required String description,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'USD ',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE67E22), // Darker orange
            Color.fromARGB(182, 243, 157, 18), // Lighter orange
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.symmetric(
            horizontal: BorderSide(
          color: Color(0XffEF8D01),
          width: 4,
        )),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildPriceBlock(
              price: '46.45',
              description: 'Mini.Orders 10',
            ),
            const Spacer(),
            // Container(
            //   decoration: const BoxDecoration(
            //       border: Border(
            //     right: BorderSide(
            //       color: CupertinoColors.white,
            //       width: 1,
            //     ),
            //   )),
            // ),
            // const Spacer(),
            _buildPriceBlock(
              price: '26.45',
              description: '10 - 100 Orders',
            ),
          ],
        ),
      ),
    );
  }
}
