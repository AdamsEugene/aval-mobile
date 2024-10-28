import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/common/conditional_widget.dart';
import 'package:e_commerce_app/widgets/product_carousel/timer_display.dart';
import 'package:e_commerce_app/widgets/product_carousel/title_display.dart';

class PromoSection extends StatelessWidget {
  final int secondsRemaining;
  final bool? ourChoice;

  const PromoSection({
    super.key,
    required this.secondsRemaining,
    this.ourChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          width: 151,
          decoration: const BoxDecoration(
            color: CupertinoColors.systemRed,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
            ),
          ),
          child: const Text(
            '-58%',
            style: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ConditionalWidget(
          condition: ourChoice,
          whenTrue: const TitleDisplay(title: "Aval Choice"),
          whenFalse: TimerDisplay(secondsRemaining: secondsRemaining),
        ),
      ],
    );
  }
}
