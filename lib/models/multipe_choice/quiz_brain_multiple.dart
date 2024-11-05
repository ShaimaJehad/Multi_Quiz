import 'package:multi_quiz/models/multipe_choice/question_multiple.dart';

class QuizBrainMulti {
  int _questionNumber = 0;

  final List<QuestionMultiple> _questionBank = [
    QuestionMultiple(
      questionText: "Best Channel for Flutter ",
      questionAnswer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
      ],
    ),
    QuestionMultiple(
      questionText: "Best State Mangment Ststem is ",
      questionAnswer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionMultiple(
      questionText: "Best Flutter dev",
      questionAnswer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
    ),
    QuestionMultiple(
      questionText: "Sherif is",
      questionAnswer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
    ),
    QuestionMultiple(
      questionText: "Best Rapper in Egypt",
      questionAnswer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
    ),
    QuestionMultiple(
      questionText: "Real Name of ahmed sherif",
      questionAnswer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionMultiple(
      questionText: "Sherif love",
      questionAnswer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
    ),
    QuestionMultiple(
      questionText: "hello",
      questionAnswer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionMultiple(
      questionText: "Best Channel for Flutter ",
      questionAnswer: 2,
      options: [
        'Sec it',
        'Sec it developer',
        'sec it developers',
        'mesh sec it '
      ],
    ),
    QuestionMultiple(
      questionText: "Best State Mangment Ststem is ",
      questionAnswer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  int getQuestionAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  int getQuestionNumber() {
    return _questionBank.length;
  }

  int getCurrentQNumber() {
    return _questionNumber + 1;
  }

  List<String> getOptions() {
    return _questionBank[_questionNumber].options;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
