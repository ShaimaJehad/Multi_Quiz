import 'package:flutter/material.dart';
import 'package:multi_quiz/constants.dart';
import 'package:multi_quiz/pages/level_description.dart';
import 'package:multi_quiz/widgets/myLevelwidget.dart';
import 'package:multi_quiz/widgets/outline_button.dart';

import '../models/level_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Level> levels = [
    Level(
      title: 'True or False',
      subtitle: 'Level 1',
      desription:
          'Do you feel exciting? Here you\'ll challenge one of our most easy  true-false questions!',
      image: 'assets/images/bags.png',
      icon: Icons.check,
      colors: [kL1, kL12],
      routeNames: '/level1',
    ),
    Level(
      title: 'Multiple Choice',
      subtitle: 'Level 2',
      desription:
          'Do you feel confident? Here you\'ll challenge one of our most difficult muliple choice questions!',
      image: 'assets/images/ballon-s.png',
      icon: Icons.play_arrow,
      colors: [kL2, kL22],
      routeNames: '/level2',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        actions: [
          MyOutLineBtn(
            icon: Icons.favorite,
            bColor: Colors.grey.withOpacity(0.5),
            iconColor: kBlueBg,
            function: () {},
          ),
          const SizedBox(
            width: 8,
          ),
          MyOutLineBtn(
            icon: Icons.person,
            bColor: Colors.grey.withOpacity(0.5),
            iconColor: kBlueBg,
            function: () {},
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s Play',
              style: TextStyle(
                color: kRedFont,
                fontFamily: kFontFamily,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Be the first !',
                style: TextStyle(
                  color: kGreyFont,
                  fontFamily: kFontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: levels.length,
              itemBuilder: (context, index) {
                return MyLevelwidget(
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelDescription(
                            levelInfo: levels[index],
                          ),
                        ),
                      );
                    },
                    level: levels[index]);
              },
            ))
          ],
        ),
      ),
    );
  }
}
