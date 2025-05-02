import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryCompanyRegistrationScreen extends StatefulWidget {
  const DeliveryCompanyRegistrationScreen({super.key});

  @override
  State<DeliveryCompanyRegistrationScreen> createState() => _DeliveryCompanyRegistrationScreenState();
}

class _DeliveryCompanyRegistrationScreenState extends State<DeliveryCompanyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _companyNameController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // Service types offered
  bool _offersStandardDelivery = true;
  bool _offersExpressDelivery = false;
  bool _offersBulkDelivery = false;
  bool _offersSpecializedDelivery = false;
  bool _offersDroneDelivery = false;
  
  // Vehicle types available
  final List<String> _availableVehicles = [];
  final List<String> _vehicleOptions = [
    'Motorcycle', 'Car', 'Van', 'Truck', 'Bicycle', 'Drone'
  ];
  
  // Coverage area
  final _coverageAreaController = TextEditingController();
  
  // Payment methods accepted
  bool _acceptsCash = true;
  bool _acceptsMobileMoney = true;
  bool _acceptsCard = false;
  
  // Security compliance
  bool _agreesToBackgroundChecks = false;
  bool _agreesToInsurance = false;
  bool _agreesToTerms = false;
  
  @override
  void dispose() {
    _companyNameController.dispose();
    _registrationNumberController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _coverageAreaController.dispose();
    super.dispose();
  }
  
  void _submitRegistration() {
    if (_formKey.currentState?.validate() != true) {
      return;
    }
    
    if (!_agreesToBackgroundChecks || !_agreesToInsurance || !_agreesToTerms) {
      _showComplianceAlert();
      return;
    }
    
    // Here we would normally save the data to a backend
    // For now, we'll show a success message
    _showSuccessDialog();
  }
  
  void _showComplianceAlert() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Security Compliance Required'),
        content: const Text('Please agree to all security compliance requirements to register your company.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
  
  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Registration Submitted'),
        content: const Text(
          'Your company registration has been submitted for review. You will be notified once it has been approved.'
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C3E50),
            Color(0xFF4CA1AF),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              const SizedBox(width: 16),
              const Text(
                'Company Registration',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Register your delivery company',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete the form below to register your company on our platform.',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? placeholder,
    bool isRequired = true,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool obscureText = false,
    int? maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: CupertinoColors.systemRed,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CupertinoColors.systemGrey4,
            ),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
        ),
        if (validator != null)
          Builder(
            builder: (context) {
              final error = validator(controller.text);
              if (error != null && controller.text.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    error,
                    style: const TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 12,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
      ],
    );
  }
  
  Widget _buildCheckboxItem({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: CupertinoCheckbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF4CA1AF),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildServiceTypesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Service Types Offered',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        _buildCheckboxItem(
          label: 'Standard Delivery',
          value: _offersStandardDelivery,
          onChanged: (value) => setState(() => _offersStandardDelivery = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'Express Delivery',
          value: _offersExpressDelivery,
          onChanged: (value) => setState(() => _offersExpressDelivery = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'Bulk Delivery',
          value: _offersBulkDelivery,
          onChanged: (value) => setState(() => _offersBulkDelivery = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'Specialized Delivery (Medical, Fragile, etc.)',
          value: _offersSpecializedDelivery,
          onChanged: (value) => setState(() => _offersSpecializedDelivery = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'Drone Delivery',
          value: _offersDroneDelivery,
          onChanged: (value) => setState(() => _offersDroneDelivery = value ?? false),
        ),
      ],
    );
  }
  
  Widget _buildVehicleTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Vehicle Types',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          children: _vehicleOptions.map((vehicle) {
            final isSelected = _availableVehicles.contains(vehicle);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _availableVehicles.remove(vehicle);
                  } else {
                    _availableVehicles.add(vehicle);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF4CA1AF)
                      : CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  vehicle,
                  style: TextStyle(
                    color: isSelected 
                        ? CupertinoColors.white
                        : CupertinoColors.label,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  Widget _buildComplianceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security Compliance',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        _buildCheckboxItem(
          label: 'I agree to conduct background checks on all delivery personnel',
          value: _agreesToBackgroundChecks,
          onChanged: (value) => setState(() => _agreesToBackgroundChecks = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'I agree to maintain insurance coverage for all deliveries',
          value: _agreesToInsurance,
          onChanged: (value) => setState(() => _agreesToInsurance = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'I agree to the terms and conditions of the platform',
          value: _agreesToTerms,
          onChanged: (value) => setState(() => _agreesToTerms = value ?? false),
        ),
      ],
    );
  }
  
  Widget _buildPaymentMethodsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Methods Accepted',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        _buildCheckboxItem(
          label: 'Cash',
          value: _acceptsCash,
          onChanged: (value) => setState(() => _acceptsCash = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'Mobile Money',
          value: _acceptsMobileMoney,
          onChanged: (value) => setState(() => _acceptsMobileMoney = value ?? false),
        ),
        const SizedBox(height: 8),
        _buildCheckboxItem(
          label: 'Credit/Debit Card',
          value: _acceptsCard,
          onChanged: (value) => setState(() => _acceptsCard = value ?? false),
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildHeaderSection(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildTextField(
                    controller: _companyNameController,
                    label: 'Company Name',
                    placeholder: 'Enter your company name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Company name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _registrationNumberController,
                    label: 'Registration Number',
                    placeholder: 'Enter company registration number',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Registration number is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _addressController,
                    label: 'Company Address',
                    placeholder: 'Enter company address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Company address is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Contact Phone',
                    placeholder: 'Enter contact phone number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contact phone is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Contact Email',
                    placeholder: 'Enter contact email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Contact email is required';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _websiteController,
                    label: 'Website',
                    placeholder: 'Enter company website (optional)',
                    isRequired: false,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Company Description',
                    placeholder: 'Briefly describe your company and services',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  _buildServiceTypesSection(),
                  const SizedBox(height: 24),
                  _buildVehicleTypeSelector(),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _coverageAreaController,
                    label: 'Coverage Areas',
                    placeholder: 'Enter the areas you service (cities, regions)',
                  ),
                  const SizedBox(height: 24),
                  _buildPaymentMethodsSection(),
                  const SizedBox(height: 24),
                  _buildComplianceSection(),
                  const SizedBox(height: 32),
                  CupertinoButton(
                    onPressed: _submitRegistration,
                    color: const Color(0xFF4CA1AF),
                    borderRadius: BorderRadius.circular(8),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      'Submit Registration',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 