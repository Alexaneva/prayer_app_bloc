import 'package:flutter/material.dart';
import 'package:prayer_bloc/app_widgets/typography.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final Size minimumSize;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.foregroundColor,
    required this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
    this.minimumSize = const Size(400, 60),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: padding,
        minimumSize: minimumSize,
      ),
      onPressed: onPressed,
      child: Text(text, style: AppTypography.heading4),
    );
  }
}