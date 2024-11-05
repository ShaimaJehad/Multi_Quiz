import 'package:flutter/material.dart';

class MyOutLineBtn extends StatelessWidget {
  final IconData icon;
  final Color bColor;
  final Color iconColor;
  final OutlinedBorder shapeBorder;

  final Function function;
  const MyOutLineBtn({
    super.key,
    required this.icon,
    required this.function,
    required this.bColor,
    required this.iconColor,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: shapeBorder,
        side: BorderSide(color: bColor),
        padding: const EdgeInsets.all(8),
      ),
      onPressed: () {
        function();
      },
      child: Icon(icon, color: iconColor),
    );
  }
}
