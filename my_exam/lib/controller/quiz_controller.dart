import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_exam/model/question_model.dart';
import 'package:my_exam/screens/result_screen.dart';
import 'package:my_exam/screens/wellcome_screen.dart';

class QuizzQontroller extends GetxController {
  String name = '';
  final List<QuestionModel> _questionList = [
    QuestionModel(
        id: 1,
        question: 'How are you',
        answer: 3,
        options: ['fine', 'good', 'ok', 'cool']),
    QuestionModel(
        id: 2,
        question: 'whats your name',
        answer: 2,
        options: ['ahmad', 'yaser', 'Ali', 'faisal']),
    QuestionModel(
        id: 3,
        question: 'How older you',
        answer: 1,
        options: ['25', '26', '28', '30']),
    QuestionModel(
        id: 4,
        question: 'Whats your job',
        answer: 2,
        options: ['doctor', 'teacher', 'pailot', 'engineer']),
    QuestionModel(
        id: 5,
        question: 'who is the best player in the world  ',
        answer: 1,
        options: ['Ronaldo', 'messi', 'maradona', 'pele']),
    QuestionModel(
        id: 6,
        question: 'What is the best car type',
        answer: 4,
        options: ['bmw', 'merceds', 'ford', 'tesla']),
  ];
  List<QuestionModel> get questionList => [..._questionList];

  bool _isPressed = false;
  bool get isPressed => isPressed;
  double _numberOfQuestion = 1;
  double get numberOfQuestion => _numberOfQuestion;

  int? _selectedAnswer;
  int? get selectedAnswer => _selectedAnswer;

  int _countOfCorrectAnswers = 0;
  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  final RxInt _sec = 15.obs;
  RxInt get sec => _sec;

  int get countOfQuestion => _questionList.length;
  final Map<int, bool> _questionIsAnswerd = {};
  Timer? _timer;
  final maxSec = 15;
  late PageController pageController;
  int? _correctAnswer;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();

    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  double get scoreResult {
    return (_countOfCorrectAnswers * 100) / _questionList.length;
  }

  void checkAnswer(int selectAnswer, QuestionModel questionModel) {
    _isPressed = true;
    _selectedAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;
    if (_correctAnswer == _selectedAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

  bool checkIsQuestionAnswer(int questionID) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == questionID)
        .value;
  }

  void resetAnswer() {
    for (var element in _questionList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green;
      } else if (answerIndex == selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Colors.red;
      }
    }
    return Colors.white;
  }

  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == selectedAnswer &&
          _correctAnswer != _selectedAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }
    if (pageController.page == _questionList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed == false;
      pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.linear);
      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        startTimer();
        nextQuestion();
      }
    });
  }

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    _selectedAnswer = null;
    resetAnswer();
    Get.offAllNamed(WelcomeScreen.routeName);
  }

  stopTimer() => _timer!.cancel();

  void resetTimer() => _sec.value = maxSec;
}

