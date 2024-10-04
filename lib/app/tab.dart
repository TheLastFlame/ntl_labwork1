import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  const MyTab({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Icon(icon), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
