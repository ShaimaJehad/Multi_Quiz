import 'package:flutter/material.dart';
import 'package:multi_quiz/models/level_info.dart';
import 'package:multi_quiz/widgets/outline_button.dart';

class LevelDescription extends StatelessWidget {
  final Level levelInfo;

  const LevelDescription({super.key, required this.levelInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: levelInfo.colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 56, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyOutLineBtn(
                      icon: Icons.close,
                      function: () {
                        Navigator.pop(context);
                      },
                      bColor: Colors.white,
                      iconColor: Colors.white,
                    )
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(34),
                      child: Image.asset(levelInfo.image!),
                    ),
                  ),
                ),
                Text(
                  levelInfo.subtitle,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white60,
                    fontFamily: 'SF-Pro-Text',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  levelInfo.title,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Text',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  levelInfo.desription!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white60,
                    fontFamily: 'SF-Pro-Text',
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, levelInfo.routeNames);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Expanded(
                        child: Center(
                          child: Text(
                            'Play Now',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: levelInfo.colors[0],
                            ),
                          ),
                        ),
                      )),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
