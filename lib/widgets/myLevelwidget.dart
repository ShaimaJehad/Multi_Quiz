import 'package:flutter/material.dart';
import 'package:multi_quiz/constants.dart';
import 'package:multi_quiz/widgets/outline_button.dart';

import '../models/level_info.dart';

class MyLevelwidget extends StatelessWidget {
  final Function() function;
  final Level level;

  const MyLevelwidget({
    super.key,
    required this.function,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: level.colors),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: MyOutLineBtn(
                    function: () {},
                    bColor: Colors.white,
                    iconColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    icon: level.icon!,
                  ),
                ),
                Text(
                  level.subtitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontFamily: kFontFamily,
                    color: Colors.white60,
                  ),
                ),
                Text(
                  level.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: kFontFamily,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 28),
            child: Image.asset(level.image!),
          ),
        ],
      ),
    );
  }
}
