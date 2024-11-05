import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../constants.dart';
import '../models/true_false/quiz_brain.dart';
import 'home.dart';

class TruefalseQuiz extends StatefulWidget {
  const TruefalseQuiz({super.key});

  @override
  State<TruefalseQuiz> createState() => _TruefalseQuizState();
}

class _TruefalseQuizState extends State<TruefalseQuiz> {
  Brain quizBrain = Brain();
  List<Icon> scoreKeeper = [];
  int score = 0;
  int counter = 10;
  bool? isCorrect;
  bool? userChoice;
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
    bool correctAnswer = quizBrain.getQuestionanswer();
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

    if (quizBrain.isFinished()) {
      cancelTimer();

      Timer(const Duration(seconds: 2), () {
        alertFinished();
        setState(() {
          quizBrain.reset();
          scoreKeeper.clear();
          isCorrect = null;
          userChoice = null;
          counter = 10;
        });
      });
    }
  }

  void next() {
    if (quizBrain.isFinished()) {
      alertFinished();
      setState(() {
        quizBrain.reset();
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
        quizBrain.nextQuestion();
      });
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        counter--;
      });
      if (counter == 5) {
        final duration = await player.setSourceAsset(// Load a URL
            'sounds/clock_tic.mp3'); // Schemes: (https: | file: | asset: )
        player.playerId;
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
      type: score < (quizBrain.getQuestiosNumber() / 2)
          ? QuickAlertType.error
          : QuickAlertType.success,
      text: 'Your Score is $score/${quizBrain.getQuestiosNumber()}',
      title: score < (quizBrain.getQuestiosNumber() / 2)
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 70, left: 10, right: 10, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 44,
                    height: 44,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.all(8),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return const HomePage();
                        }), (route) => false);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          value: counter / 10,
                          color: counter <= 5 ? Colors.redAccent : Colors.white,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      Text(
                        counter.toString(),
                        style: TextStyle(
                          fontFamily: 'Sf-Pro-Text',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: counter <= 5 ? Colors.redAccent : Colors.white,
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
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child: AnimatedScale(
                      scale: favScal,
                      duration: const Duration(microseconds: 500),
                      child: Icon(
                        Icons.favorite,
                        color: favColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(70.0),
                  child: Image.asset(
                    'assets/images/tf_2.png',
                  ),
                )),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'question ${quizBrain.getCurrentQNumber()} of ${quizBrain.getQuestiosNumber()}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white60,
                ),
              ),
            ),
            AutoSizeText(
              maxLines: 3,
              quizBrain.getQuestionText(),
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Sf-Pro-Text',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: counterFinished
                    ? null
                    : userChoice == null
                        ? () {
                            // print("Index:$index");
                            userChoice = true;
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
                              ? (isCorrect! && userChoice == true)
                                  ? [ky1, ky2]
                                  : userChoice == true
                                      ? [kr1, kr2]
                                      : [Colors.white54, Colors.white54]
                              : showCorrectAnswer &&
                                      quizBrain.getQuestionanswer()
                                  ? [ky1, ky2]
                                  : [Colors.white, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'True',
                            style: TextStyle(
                                color: userChoice != null
                                    ? userChoice == true
                                        ? Colors.white
                                        : kL2
                                    : kL2,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Icon(
                        userChoice == null
                            ? null
                            : isCorrect! && userChoice == true
                                ? Icons.check
                                : userChoice == true
                                    ? Icons.close
                                    : null,
                        color: userChoice != null
                            ? userChoice == true
                                ? Colors.white
                                : null
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: counterFinished
                    ? null
                    : userChoice == null
                        ? () {
                            userChoice = false;
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
                              ? (isCorrect! && userChoice == false)
                                  ? [ky1, ky2]
                                  : userChoice == false
                                      ? [kr1, kr2]
                                      : [Colors.white54, Colors.white54]
                              : showCorrectAnswer &&
                                      !quizBrain.getQuestionanswer()
                                  ? [ky1, ky2]
                                  : [Colors.white, Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'False',
                            style: TextStyle(
                                color: userChoice != null
                                    ? userChoice == false
                                        ? Colors.white
                                        : kL2
                                    : kL2,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Icon(
                        userChoice == null
                            ? null
                            : isCorrect! && userChoice == false
                                ? Icons.check
                                : userChoice == false
                                    ? Icons.close
                                    : null,
                        color: userChoice != null
                            ? userChoice == false
                                ? Colors.white
                                : null
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Wrap(
              children: scoreKeeper,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                  },
                  child: Text(
                    (userChoice == null && counter == 0) ? 'Show Answer' : '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.underline),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    next();
                  },
                  child: Text(
                    (userChoice != null && !quizBrain.isFinished() ||
                            userChoice == null && counter == 0)
                        ? userChoice == null &&
                                counter == 0 &&
                                quizBrain.isFinished()
                            ? 'show result'
                            : 'Next'
                        : '',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }
}
