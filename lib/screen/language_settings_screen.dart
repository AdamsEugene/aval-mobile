// lib/screens/language_settings_screen.dart
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'en_US';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  static const List<LanguageItem> _languages = [
    LanguageItem(
      code: 'en_US',
      name: 'English (US)',
      localName: 'English (US)',
      flag: 'assets/images/flag.png',
    ),
    LanguageItem(
      code: 'en_GB',
      name: 'English (UK)',
      localName: 'English (UK)',
      flag: 'assets/images/flag.png',
    ),
    LanguageItem(
      code: 'fr_FR',
      name: 'French',
      localName: 'Français',
      flag: 'assets/images/flag.png',
    ),
    LanguageItem(
      code: 'es_ES',
      name: 'Spanish',
      localName: 'Español',
      flag: 'assets/images/flag.png',
    ),
    LanguageItem(
      code: 'zh_CN',
      name: 'Chinese',
      localName: '中文',
      flag: 'assets/images/flag.png',
    ),
    LanguageItem(
      code: 'ar_SA',
      name: 'Arabic',
      localName: 'العربية',
      flag: 'assets/images/flag.png',
    ),
    LanguageItem(
      code: 'hi_IN',
      name: 'Hindi',
      localName: 'हिंदी',
      flag: 'assets/images/flag.png',
    ),
  ];

  List<LanguageItem> get filteredLanguages {
    if (_searchQuery.isEmpty) return _languages;
    return _languages.where((language) {
      return language.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          language.localName.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildHeader(BuildContext context) {
    return MainHeader(
      leading: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Color(0xFF05001E),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Language',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ],
      ),
      actions: [
        HeaderAction(
          icon: CupertinoIcons.slider_horizontal_3,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCurrentLanguage() {
    final current = _languages.firstWhere((l) => l.code == _selectedLanguage);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              current.flag,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Language',
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  current.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  current.localName,
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey.darkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(LanguageItem language) {
    final isSelected = language.code == _selectedLanguage;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedLanguage = language.code);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 8),
        decoration: const BoxDecoration(
            color: CupertinoColors.white,
            border: Border(
              bottom: BorderSide(
                color: CupertinoColors.systemGrey6,
                width: 1,
              ),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                language.flag,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    language.localName,
                    style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.systemGrey.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: Color(0xFF05001E),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFEEEFF1),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildHeader(context),
            SliverToBoxAdapter(
              child: _buildCurrentLanguage(),
            ),
            const MainSearchBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildLanguageItem(filteredLanguages[index]),
                  childCount: filteredLanguages.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class LanguageItem {
  final String code;
  final String name;
  final String localName;
  final String flag;

  const LanguageItem({
    required this.code,
    required this.name,
    required this.localName,
    required this.flag,
  });
}
