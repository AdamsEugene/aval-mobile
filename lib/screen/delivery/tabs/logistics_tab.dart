// lib/screen/delivery/tabs/logistics_tab.dart
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/widgets/delivery/vehicle_card.dart';

class LogisticsTab extends StatefulWidget {
  const LogisticsTab({super.key});

  @override
  State<LogisticsTab> createState() => _LogisticsTabState();
}

class _LogisticsTabState extends State<LogisticsTab> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Passenger',
    'Cargo',
    'Special',
    'Heavy Duty'
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _categories.map((category) {
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: isSelected
                        ? const Color(0xFF05001E)
                        : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(18),
                    onPressed: () =>
                        setState(() => _selectedCategory = category),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected
                            ? CupertinoColors.white
                            : const Color(0xFF05001E),
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1A2980),
                  Color(0xFF26D0CE),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1A2980).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ground Logistics',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find the perfect vehicle for your transportation needs',
                  style: TextStyle(
                    color: CupertinoColors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickOption(
                      icon: CupertinoIcons.person_2,
                      label: 'Passengers',
                      onTap: () {
                        setState(() => _selectedCategory = 'Passenger');
                      },
                    ),
                    _buildQuickOption(
                      icon: CupertinoIcons.cube_box,
                      label: 'Goods',
                      onTap: () {
                        setState(() => _selectedCategory = 'Cargo');
                      },
                    ),
                    _buildQuickOption(
                      icon: CupertinoIcons.group,
                      label: 'Group',
                      onTap: () {
                        // Navigate to group logistics
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              _selectedCategory == 'All'
                  ? 'Available Vehicles'
                  : '$_selectedCategory Vehicles',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const VehicleCard(
                name: 'Sedan - Toyota Camry',
                type: 'Passenger',
                capacity: '4 passengers',
                pricePerKm: '\$0.80',
                imageUrl: 'assets/images/a.jpg',
                features: [
                  'Air Conditioning',
                  'Comfortable Seating',
                  'Luggage Space'
                ],
              ),
              const SizedBox(height: 16),
              const VehicleCard(
                name: 'Pickup Truck - Toyota Hilux',
                type: 'Cargo',
                capacity: '1 ton',
                pricePerKm: '\$1.20',
                imageUrl: 'assets/images/b.jpg',
                features: ['Open Bed', 'All-Terrain', 'Towing Capability'],
              ),
              const SizedBox(height: 16),
              const VehicleCard(
                name: 'Minivan - Toyota Sienna',
                type: 'Passenger',
                capacity: '7 passengers',
                pricePerKm: '\$1.50',
                imageUrl: 'assets/images/c.jpg',
                features: [
                  'Spacious Interior',
                  'Family Friendly',
                  'Multiple Stops'
                ],
              ),
              const SizedBox(height: 16),
              const VehicleCard(
                name: 'Box Truck - Enclosed',
                type: 'Cargo',
                capacity: '3 tons',
                pricePerKm: '\$2.00',
                imageUrl: 'assets/images/d.jpg',
                features: [
                  'Enclosed Storage',
                  'Weather Protection',
                  'Security'
                ],
              ),
              const SizedBox(height: 16),
              const VehicleCard(
                name: 'Bus - VIP Service',
                type: 'Passenger',
                capacity: '28 passengers',
                pricePerKm: '\$3.50',
                imageUrl: 'assets/images/e.jpg',
                features: ['Group Travel', 'AC Included', 'Long Distance'],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF1A2980),
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
