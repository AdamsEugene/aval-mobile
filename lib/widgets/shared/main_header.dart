// lib/widgets/shared/main_header.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:e_commerce_app/widgets/shared/sliver_app_bar_delegate.dart';
import 'package:e_commerce_app/widgets/shared/buttons/elevated_icon_button.dart';
import 'package:e_commerce_app/widgets/shared/location_section.dart';
import 'package:e_commerce_app/screen/account_screen.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 60.0,
        child: Container(
          color: const Color(0xFFEEEFF1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Expanded(child: LocationSection()),
                Row(
                  children: [
                    ElevatedIconButton(
                      icon: Platform.isIOS
                          ? CupertinoIcons.flag
                          : Icons.flag_outlined,
                      onPressed: () {},
                      flagBadge: 'assets/images/flag.png',
                    ),
                    const SizedBox(width: 8),
                    ElevatedIconButton(
                      icon: Platform.isIOS
                          ? CupertinoIcons.money_dollar
                          : Icons.attach_money,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    ElevatedIconButton(
                      icon: Platform.isIOS
                          ? CupertinoIcons.bell
                          : Icons.notifications_outlined,
                      onPressed: () {},
                      badgeCount: 2,
                    ),
                    const SizedBox(width: 8),
                    ElevatedIconButton(
                      icon: Platform.isIOS
                          ? CupertinoIcons.person
                          : Icons.person_outline,
                      onPressed: () {
                        if (Platform.isIOS) {
                          Navigator.of(context, rootNavigator: false).push(
                            CupertinoPageRoute(
                              builder: (context) => const AccountScreen(),
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AccountScreen(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
