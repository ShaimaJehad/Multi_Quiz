import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:multi_quiz/constants.dart';
import 'package:multi_quiz/models/multipe_choice/quiz_brain_multiple.dart';
import 'package:multi_quiz/pages/home.dart';
import 'package:multi_quiz/widgets/outline_button.dart';
import 'package:quickalert/quickalert.dart';

class MultiquestionQuiz extends StatefulWidget {
  const MultiquestionQuiz({super.key});

  @override
  State<MultiquestionQuiz> createState() => _MultiquestionQuizState();
}

class _MultiquestionQuizState extends State<MultiquestionQuiz> {
  QuizBrainMulti quizMulti = QuizBrainMulti();
  List<Icon> scoreKeeper = [];
  int score = 0;
  int counter = 10;
  bool? isCorrect;
  int? userChoice;
  late Timer timer;
  Color favColor = Colors.white;
  double favScal = 1;
  final player = AudioPlayer();
  bool counterFinished = false;

  bool showCorrectAnswer = false;

  void checkAnswer() {
    if (counter <= 5) {
      player.stop();
    }
    int correctAnswer = quizMulti.getQuestionAnswer();
    cancelTimer();
    setState(() {
      if (correctAnswer == userChoice) {
        score++;
        print('Score $score');
        isCorrect = true;
        setState(() {
          favColor = Colors.redAccent;
          favScal = 2;
          Timer(const Duration(milliseconds: 300), () {
            setState(() {
              favScal = 1;
            });
          });
          Timer(const Duration(milliseconds: 1000), () {
            setState(() {
              favColor = Colors.white;
            });
          });

          scoreKeeper.add(
            const Icon(
              Icons.check,
              color: Colors.lightGreen,
              size: 24,
            ),
          );
        });
      } else {
        isCorrect = false;
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.redAccent,
            size: 24,
          ),
        );
      }
    });
  }

  void next() {
    if (quizMulti.isFinished()) {
      alertFinished();
      setState(() {
        counterFinished = false;
        quizMulti.reset();
        scoreKeeper.clear();
        isCorrect = null;
        userChoice = null;
        counter = 10;
      });
    } else {
      setState(() {
        counterFinished = false;
        showCorrectAnswer = false;
      });
      counter = 10;
      startTimer();
      setState(() {
        isCorrect = null;
        userChoice = null;
        quizMulti.nextQuestion();
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        counter--;
      });
      if (counter == 5) {
        final duration = await player.setSourceAsset('sounds/clock_tic.mp3');
        player.play;
      }
      if (counter == 0 && userChoice == null) {
        counterFinished = true;
        player.stop();
        timer.cancel();
        setState(() {
          scoreKeeper.add(const Icon(
            Icons.question_mark,
            color: Colors.white,
          ));
        });
        // next();
      }
    });
  }

  void cancelTimer() {
    timer.cancel();
  }

  void alertFinished() {
    QuickAlert.show(
      context: context,
      type: score < (quizMulti.getQuestionNumber() / 2)
          ? QuickAlertType.error
          : QuickAlertType.success,
      text: 'Your Score is $score/${quizMulti.getQuestionNumber()}',
      title: score < (quizMulti.getQuestionNumber() / 2)
          ? 'Good Luck!😞'
          : 'Congratulations! 🎉',
      confirmBtnText: 'Play Agin',
      onConfirmBtnTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onCancelBtnTap: () {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home_screen', (route) => false);
      },
      showCancelBtn: true,
      cancelBtnText: 'Finish',
      confirmBtnColor: Colors.green,
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBlueBg,
              kL2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyOutLineBtn(
                    icon: Icons.close,
                    function: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }), (route) => false);
                    },
                    bColor: Colors.white,
                    iconColor: Colors.white),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 56,
                      height: 56,
                      child: CircularProgressIndicator(
                        value: counter / 10,
                        color: counter > 5 ? Colors.white : Colors.redAccent,
                        backgroundColor: Colors.white12,
                      ),
                    ),
                    Text(
                      counter.toString(),
                      style: TextStyle(
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 24,
                        color: counter > 5 ? Colors.white : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: const BorderSide(color: Colors.white)),
                  child: AnimatedScale(
                    scale: favScal,
                    duration: const Duration(microseconds: 500),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: Image.asset('assets/images/ballon-b.png'),
              ),
            ),
            Text(
              'question ${quizMulti.getCurrentQNumber()} of ${quizMulti.getQuestionNumber()}',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'SF-Pro-Text',
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            AutoSizeText(
              maxLines: 3,
              quizMulti.getQuestionText(),
              style: const TextStyle(
                fontSize: 32,
                fontFamily: 'SF-Pro-Text',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: quizMulti.getOptions().length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: counterFinished
                          ? null
                          : userChoice == null
                              ? () {
                                  print('Index :$index');
                                  userChoice = index;
                                  checkAnswer();
                                }
                              : null,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: userChoice != null
                                ? (isCorrect! && userChoice == index)
                                    ? [ky1, ky2]
                                    : userChoice == index
                                        ? [kr1, kr2]
                                        : showCorrectAnswer &&
                                                quizMulti.getQuestionAnswer() ==
                                                    index
                                            ? [ky1, ky2]
                                            : [
                                                Colors.white54,
                                                Colors.white54,
                                              ]
                                : showCorrectAnswer &&
                                        quizMulti.getQuestionAnswer() == index
                                    ? [
                                        ky1,
                                        ky2,
                                      ]
                                    : [
                                        Colors.white,
                                        Colors.white,
                                      ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  quizMulti.getOptions()[index],
                                  style: TextStyle(
                                    color: userChoice != null
                                        ? userChoice == index
                                            ? Colors.white
                                            : kL2
                                        : kL2,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              userChoice == null
                                  ? null
                                  : isCorrect! && userChoice == index
                                      ? Icons.check
                                      : userChoice == index
                                          ? Icons.close
                                          : null,
                              color: userChoice != null
                                  ? userChoice == index
                                      ? Colors.white
                                      : null
                                  : null,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Wrap(
              children: scoreKeeper,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    showCorrectAnswer = true;
                  });
                  print(showCorrectAnswer);
                },
                child: Text(
                  ((userChoice == null && counter == 0) ||
                          (userChoice != null && !isCorrect!))
                      ? 'Show Answer'
                      : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  next();
                },
                child: Text(
                  (userChoice != null || userChoice == null && counter == 0)
                      ? (userChoice == null &&
                                  counter == 0 &&
                                  quizMulti.isFinished() ||
                              (userChoice != null && quizMulti.isFinished()))
                          ? 'Show Result'
                          : 'Next'
                      : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
