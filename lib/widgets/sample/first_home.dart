import 'package:flutter/cupertino.dart';

class ButtonTabISO extends StatefulWidget {
  const ButtonTabISO({super.key});

  @override
  State<ButtonTabISO> createState() => _ButtonTabISOState();
}

class _ButtonTabISOState extends State<ButtonTabISO> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: const Color(0xFF05001E),
        activeColor: CupertinoColors.white,
        inactiveColor: CupertinoColors.systemGrey,
        items: [
          _buildNavItem(CupertinoIcons.home, 'Home'),
          _buildNavItem(CupertinoIcons.shopping_cart, 'Reseller Cart'),
          _buildNavItem(CupertinoIcons.cart, 'Cart'),
          _buildNavItem(CupertinoIcons.person, 'Account'),
          _buildNavItem(CupertinoIcons.ellipsis_vertical, 'More'),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              backgroundColor: const Color(0xFFEEEFF1),
              child: SafeArea(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      setState(() {});
                    }
                    return true;
                  },
                  child: CustomScrollView(
                    slivers: <Widget>[
                      CupertinoSliverNavigationBar(
                        largeTitle: const Text('The One'),
                        leading: const Icon(CupertinoIcons.person_2),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // if (_isScrolled) const Icon(CupertinoIcons.search),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(CupertinoIcons.bell),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(CupertinoIcons.cart),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: const Icon(CupertinoIcons.envelope),
                            ),
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          minHeight: 50.0,
                          maxHeight: 50.0,
                          child: Container(
                            color: const Color(0xFFEEEFF1),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: CupertinoSearchTextField(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return CupertinoListTile(
                              title: Text('Item $index'),
                              trailing: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                child: const Icon(CupertinoIcons.right_chevron),
                              ),
                            );
                          },
                          childCount: 50, // Adjust this number as needed
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Icon(icon),
    ),
    label: label,
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
