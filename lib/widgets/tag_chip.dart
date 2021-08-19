import 'package:flutter/material.dart';
import 'package:singingholic_app/assets/app_theme.dart';

/// Chip of tag
class TagChip extends StatefulWidget {
  /// Tag label
  final String label;

  /// Tag background color
  final Color? backgroundColor;

  /// Text color of the chip
  final Color? textColor;

  /// Create chip of tag
  const TagChip(
      {Key? key, required this.label, this.backgroundColor, this.textColor})
      : super(key: key);

  @override
  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        widget.label,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      backgroundColor: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeSize.tagChipBorderRadius),
      ),
      labelStyle: TextStyle(color: widget.textColor),
    );
  }
}
