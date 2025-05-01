import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DeliveryServiceSelectionScreen extends StatefulWidget {
  const DeliveryServiceSelectionScreen({super.key});

  @override
  State<DeliveryServiceSelectionScreen> createState() => _DeliveryServiceSelectionScreenState();
}

class _DeliveryServiceSelectionScreenState extends State<DeliveryServiceSelectionScreen> {
  // Currently selected service
  String? _selectedServiceId;
  
  // List of delivery service providers in Ghana and globally
  final List<DeliveryServiceProvider> _deliveryServices = [
    // Ghana-based services
    DeliveryServiceProvider(
      id: 'swiftly',
      name: 'Swiftly',
      logo: 'assets/logos/swiftly.png',
      description: 'Fast local delivery across major cities in Ghana',
      isPopular: true,
      rating: 4.7,
      deliveryTime: '30-45 min',
      basePrice: 'GH₵ 15',
      color: const Color(0xFF4CAF50),
    ),
    DeliveryServiceProvider(
      id: 'ghexpress',
      name: 'Ghana Express',
      logo: 'assets/logos/ghexpress.png',
      description: 'Nationwide delivery service with tracking',
      isPopular: true,
      rating: 4.5,
      deliveryTime: '1-2 days',
      basePrice: 'GH₵ 25',
      color: const Color(0xFF3F51B5),
    ),
    DeliveryServiceProvider(
      id: 'transpoco',
      name: 'TranspoCo',
      logo: 'assets/logos/transpoco.png',
      description: 'Specialized transportation for all kinds of goods',
      isPopular: false,
      rating: 4.2,
      deliveryTime: '1-3 days',
      basePrice: 'GH₵ 30',
      color: const Color(0xFFFF9800),
    ),
    DeliveryServiceProvider(
      id: 'medexpress',
      name: 'MedExpress',
      logo: 'assets/logos/medexpress.png',
      description: 'Medical delivery specialists with temperature control',
      isPopular: false,
      rating: 4.8,
      deliveryTime: '1-2 hours',
      basePrice: 'GH₵ 40',
      color: const Color(0xFFE91E63),
    ),
    DeliveryServiceProvider(
      id: 'gofer',
      name: 'Gofer',
      logo: 'assets/logos/gofer.png',
      description: 'On-demand couriers for quick deliveries',
      isPopular: true,
      rating: 4.6,
      deliveryTime: '15-30 min',
      basePrice: 'GH₵ 20',
      color: const Color(0xFF2196F3),
    ),
    
    // Global services also operating in Ghana
    DeliveryServiceProvider(
      id: 'dhl',
      name: 'DHL',
      logo: 'assets/logos/dhl.png',
      description: 'International shipping and local premium delivery',
      isPopular: true,
      rating: 4.5,
      deliveryTime: '1-5 days',
      basePrice: 'GH₵ 60',
      color: const Color(0xFFFFEB3B),
    ),
    DeliveryServiceProvider(
      id: 'fedex',
      name: 'FedEx',
      logo: 'assets/logos/fedex.png',
      description: 'Global and domestic shipping solutions',
      isPopular: false,
      rating: 4.4,
      deliveryTime: '1-3 days',
      basePrice: 'GH₵ 55',
      color: const Color(0xFF673AB7),
    ),
    DeliveryServiceProvider(
      id: 'ups',
      name: 'UPS',
      logo: 'assets/logos/ups.png',
      description: 'Worldwide express courier, package delivery',
      isPopular: false,
      rating: 4.3,
      deliveryTime: '1-4 days',
      basePrice: 'GH₵ 50',
      color: const Color(0xFF795548),
    ),
    DeliveryServiceProvider(
      id: 'gokada',
      name: 'Gokada',
      logo: 'assets/logos/gokada.png',
      description: 'Fast motorcycle deliveries across major African cities',
      isPopular: true,
      rating: 4.6,
      deliveryTime: '25-40 min',
      basePrice: 'GH₵ 18',
      color: const Color(0xFF00BCD4),
    ),
    DeliveryServiceProvider(
      id: 'glovo',
      name: 'Glovo',
      logo: 'assets/logos/glovo.png',
      description: 'Multi-category delivery service for packages',
      isPopular: false,
      rating: 4.4,
      deliveryTime: '30-60 min',
      basePrice: 'GH₵ 22',
      color: const Color(0xFFFFCA28),
    ),
  ];

  // Select a random service
  void _selectRandomService() {
    final random = Random();
    final randomIndex = random.nextInt(_deliveryServices.length);
    setState(() {
      _selectedServiceId = _deliveryServices[randomIndex].id;
    });
  }

  // Continue to the send package flow
  void _proceedWithSelectedService() {
    if (_selectedServiceId == null) {
      // Show alert if no service is selected
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('No Service Selected'),
          content: const Text('Please select a delivery service to continue.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }

    // Get the selected service
    final selectedService = _deliveryServices.firstWhere(
      (service) => service.id == _selectedServiceId,
    );

    // Navigate back with the selected service
    Navigator.of(context).pop(selectedService);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      child: SafeArea(
        child: Column(
          children: [
            // Enhanced gradient header
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFF9966),  // Orange for Send Package theme
                    Color(0xFFFF5E62),  // Red for Send Package theme
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5E62).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button and select random button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            CupertinoIcons.back,
                            color: CupertinoColors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _selectRandomService,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.shuffle,
                                color: CupertinoColors.white,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Random',
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Header title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: CupertinoColors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          CupertinoIcons.cube_box,
                          color: CupertinoColors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Choose Delivery Service',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Description
                  const Text(
                    'Select a service provider to deliver your package',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            
            // Popular services section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5E62),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Popular Services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF05001E),
                    ),
                  ),
                ],
              ),
            ),
            
            // List of delivery services
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _deliveryServices.length,
                itemBuilder: (context, index) {
                  final service = _deliveryServices[index];
                  final isSelected = service.id == _selectedServiceId;
                  
                  // Only show popular services in the popular section
                  if (!service.isPopular && index < 5) {
                    return const SizedBox.shrink();
                  }
                  
                  // Add a section header for All Services
                  if (index == 5) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF5E62),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'All Services',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF05001E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildServiceCard(service, isSelected),
                      ],
                    );
                  }
                  
                  return _buildServiceCard(service, isSelected);
                },
              ),
            ),
            
            // Continue button
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: _proceedWithSelectedService,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF9966),  // Orange
                        Color(0xFFFF5E62),  // Red
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5E62).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.arrow_right_circle,
                        color: CupertinoColors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Continue',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServiceCard(DeliveryServiceProvider service, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedServiceId = service.id;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected 
                ? service.color.withOpacity(0.1) 
                : CupertinoColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected 
                  ? service.color 
                  : CupertinoColors.systemGrey5,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Service logo placeholder
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: service.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    service.name.substring(0, 1),
                    style: TextStyle(
                      color: service.color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Service details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          service.name,
                          style: TextStyle(
                            color: const Color(0xFF05001E),
                            fontSize: 16,
                            fontWeight: isSelected 
                                ? FontWeight.bold 
                                : FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (service.isPopular)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6, 
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF5E62).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Popular',
                              style: TextStyle(
                                color: Color(0xFFFF5E62),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      service.description,
                      style: TextStyle(
                        color: const Color(0xFF05001E).withOpacity(0.6),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Rating
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.star_fill,
                              color: Color(0xFFFFC107),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              service.rating.toString(),
                              style: const TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        
                        // Delivery time
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.clock,
                              color: Color(0xFF3F51B5),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              service.deliveryTime,
                              style: const TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        
                        // Base price
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.money_dollar_circle,
                              color: Color(0xFF4CAF50),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              service.basePrice,
                              style: const TextStyle(
                                color: Color(0xFF05001E),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Selected indicator
              if (isSelected)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: service.color,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.checkmark,
                    color: CupertinoColors.white,
                    size: 12,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Model for delivery service provider
class DeliveryServiceProvider {
  final String id;
  final String name;
  final String logo;
  final String description;
  final bool isPopular;
  final double rating;
  final String deliveryTime;
  final String basePrice;
  final Color color;

  DeliveryServiceProvider({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.isPopular,
    required this.rating,
    required this.deliveryTime,
    required this.basePrice,
    required this.color,
  });
} 