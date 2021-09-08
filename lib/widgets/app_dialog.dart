import 'package:flutter/material.dart';

/// App customized dialog
class AppDialog extends StatefulWidget {
  /// Content inside the dialog
  final Widget child;

  /// Create customized dialog
  const AppDialog({Key? key, required this.child}) : super(key: key);

  @override
  _AppDialogState createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: widget.child,
    );
  }
}
