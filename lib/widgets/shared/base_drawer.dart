import 'package:flutter/cupertino.dart';

class DrawerAction {
  final Widget? icon;
  final String? text;
  final VoidCallback onTap;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const DrawerAction({
    this.icon,
    this.text,
    required this.onTap,
    this.textColor = const Color(0xFF05001E),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
  }) : assert(icon != null || text != null,
            'Either icon or text must be provided');

  Widget build() {
    if (icon != null && text == null) {
      return icon!;
    }

    if (text != null && icon == null) {
      return Text(
        text!,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) icon!,
        if (icon != null && text != null) const SizedBox(width: 4),
        if (text != null)
          Text(
            text!,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
      ],
    );
  }
}

class BaseDrawer extends StatelessWidget {
  final double? height;
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? handleColor;
  final DrawerAction? leadingAction;
  final DrawerAction? trailingAction;

  const BaseDrawer({
    super.key,
    required this.child,
    this.height,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
    this.handleColor,
    this.leadingAction,
    this.trailingAction,
  });

  static void show({
    required BuildContext context,
    required Widget child,
    double? height,
    Color? backgroundColor,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    Color? handleColor,
    DrawerAction? leadingAction,
    DrawerAction? trailingAction,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => BaseDrawer(
        height: height,
        backgroundColor: backgroundColor,
        padding: padding,
        borderRadius: borderRadius,
        handleColor: handleColor,
        leadingAction: leadingAction,
        trailingAction: trailingAction,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? CupertinoColors.white,
        borderRadius: borderRadius ??
            const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top section with handle and actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Drawer Handle
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: handleColor ?? const Color(0xFF050311),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Actions row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Leading action
                    if (leadingAction != null)
                      GestureDetector(
                        onTap: leadingAction!.onTap,
                        child: leadingAction!.build(),
                      )
                    else
                      const SizedBox(width: 24, height: 24),
                    // Trailing action
                    if (trailingAction != null)
                      GestureDetector(
                        onTap: trailingAction!.onTap,
                        child: trailingAction!.build(),
                      )
                    else
                      const SizedBox(width: 24, height: 24),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Flexible(child: child),
        ],
      ),
    );
  }
}
