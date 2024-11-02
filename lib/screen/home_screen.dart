import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/home/home_content.dart';
import 'package:e_commerce_app/widgets/shared/bottom_tab_iso.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ButtonTabISO(
      slivers: HomeContent(),
    );
  }
}
