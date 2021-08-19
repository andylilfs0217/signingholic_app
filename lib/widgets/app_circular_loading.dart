import 'package:flutter/material.dart';

class AppCircularLoading extends StatelessWidget {
  const AppCircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
