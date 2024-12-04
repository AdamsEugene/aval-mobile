import 'package:e_commerce_app/widgets/customization/models/customization_type.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseCustomizationDrawer extends StatefulWidget {
  final CustomizationType type;

  const BaseCustomizationDrawer({
    super.key,
    required this.type,
  });
}
