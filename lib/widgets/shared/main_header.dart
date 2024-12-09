// lib/widgets/shared/main_header.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/sliver_app_bar_delegate.dart';
import 'package:e_commerce_app/screen/account_screen.dart';

class MainHeader extends StatelessWidget {
  final Widget? leading;
  final List<HeaderAction>? actions;
  final Color? bgColor;
  final bool isSliver;

  const MainHeader({
    super.key,
    this.leading,
    this.actions,
    this.bgColor = const Color(0xFFEEEFF1),
    this.isSliver = true,
  });

  Widget _buildHeaderContent(BuildContext context) {
    return Container(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              child: leading ?? _buildDefaultLeading(context),
            ),
            if (actions != null)
              Row(
                children: actions!
                    .map((action) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ElevatedIconButton(
                            icon: action.icon,
                            onPressed: action.onPressed,
                            badgeCount: action.badgeCount,
                            flagBadge: action.flagBadge,
                          ),
                        ))
                    .toList(),
              )
            else
              _buildDefaultActions(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          minHeight: 60.0,
          maxHeight: 60.0,
          child: _buildHeaderContent(context),
        ),
      );
    }

    return SizedBox(
      height: 60.0,
      child: _buildHeaderContent(context),
    );
  }

  Widget _buildDefaultLeading(BuildContext context) {
    return Row(
      children: [
        Text(
          'Aval',
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
        const SizedBox(width: 2),
        const Icon(
          CupertinoIcons.location_solid,
          color: Color(0xFFF08D00),
          size: 28,
        ),
        const SizedBox(width: 2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 80),
          child: Text(
            'Deliver to Kumasi',
            style: CupertinoTheme.of(context)
                .textTheme
                .navTitleTextStyle
                .copyWith(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultActions(BuildContext context) {
    return Row(
      children: [
        ElevatedIconButton(
          icon: CupertinoIcons.flag,
          onPressed: () {},
          flagBadge: 'assets/images/flag.png',
        ),
        const SizedBox(width: 8),
        ElevatedIconButton(
          icon: CupertinoIcons.money_dollar,
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        ElevatedIconButton(
          icon: CupertinoIcons.bell,
          onPressed: () {},
          badgeCount: 2,
        ),
        const SizedBox(width: 8),
        ElevatedIconButton(
          icon: CupertinoIcons.person,
          onPressed: () {
            Navigator.of(context, rootNavigator: false).push(
              CupertinoPageRoute(
                builder: (context) => const AccountScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class HeaderAction {
  final IconData icon;
  final VoidCallback onPressed;
  final int? badgeCount;
  final String? flagBadge;

  const HeaderAction({
    required this.icon,
    required this.onPressed,
    this.badgeCount,
    this.flagBadge,
  });
}

class ElevatedIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final int? badgeCount;
  final String? flagBadge;

  const ElevatedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.badgeCount,
    this.flagBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(8),
            onPressed: onPressed,
            child: Icon(
              icon,
              color: CupertinoColors.black,
            ),
          ),
          if (badgeCount != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemRed,
                  borderRadius: BorderRadius.circular(50),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: Text(
                    badgeCount.toString(),
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          if (flagBadge != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(flagBadge!),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: CupertinoColors.white,
                    width: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
