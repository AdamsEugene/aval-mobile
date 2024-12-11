// lib/screens/currency_settings_screen.dart
import 'package:e_commerce_app/widgets/shared/main_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/shared/main_header.dart';

class CurrencySettingsScreen extends StatefulWidget {
  const CurrencySettingsScreen({super.key});

  @override
  State<CurrencySettingsScreen> createState() => _CurrencySettingsScreenState();
}

class _CurrencySettingsScreenState extends State<CurrencySettingsScreen> {
  String _selectedCurrency = 'USD';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  static const List<CurrencyItem> _currencies = [
    CurrencyItem(code: 'USD', name: 'US Dollar', symbol: '\$', rate: 1.0),
    CurrencyItem(code: 'EUR', name: 'Euro', symbol: '€', rate: 0.92),
    CurrencyItem(code: 'GBP', name: 'British Pound', symbol: '£', rate: 0.79),
    CurrencyItem(code: 'JPY', name: 'Japanese Yen', symbol: '¥', rate: 149.42),
    CurrencyItem(
        code: 'AUD', name: 'Australian Dollar', symbol: 'A\$', rate: 1.54),
    CurrencyItem(
        code: 'CAD', name: 'Canadian Dollar', symbol: 'C\$', rate: 1.36),
    CurrencyItem(
        code: 'GHS', name: 'Ghanaian Cedi', symbol: 'GH₵', rate: 12.32),
    CurrencyItem(
        code: 'NGN', name: 'Nigerian Naira', symbol: '₦', rate: 815.75),
  ];

  List<CurrencyItem> get filteredCurrencies {
    if (_searchQuery.isEmpty) return _currencies;
    return _currencies.where((currency) {
      return currency.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          currency.name.toLowerCase().contains(_searchQuery.toLowerCase());
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
            'Currency',
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

  Widget _buildCurrencyItem(CurrencyItem currency) {
    final isSelected = currency.code == _selectedCurrency;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedCurrency = currency.code);
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
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  currency.symbol,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.code,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    currency.name,
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
              )
            else
              Text(
                '${currency.rate}',
                style: TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemGrey.darkColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentCurrency() {
    final current = _currencies.firstWhere((c) => c.code == _selectedCurrency);
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF05001E),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                current.symbol,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Currency',
                  style: TextStyle(
                    fontSize: 14,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${current.code} - ${current.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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
              child: _buildCurrentCurrency(),
            ),
            const MainSearchBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildCurrencyItem(filteredCurrencies[index]),
                  childCount: filteredCurrencies.length,
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

class CurrencyItem {
  final String code;
  final String name;
  final String symbol;
  final double rate;

  const CurrencyItem({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rate,
  });
}
