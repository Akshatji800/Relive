import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mental_health/screens/k_ten_scale/models/questions.dart';
import 'package:mental_health/screens/k_ten_scale/screens/score/score_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Lets animated our progress bar
  late int scoretotal = 0;
  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sampleData
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => _questions;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOffiveScoreAns = 0;
  int _numOffourScoreAns = 0;
  int _numOfthreeScoreAns = 0;
  int _numOftwoScoreAns = 0;
  int _numOfoneScoreAns = 0;
  int get numOffiveScoreAns => _numOffiveScoreAns;
  int get numOffourScoreAns => _numOffourScoreAns;
  int get numOfthreeScoreAns => _numOfthreeScoreAns;
  int get numOftwoScoreAns => _numOftwoScoreAns;
  int get numOfoneScoreAns => _numOfoneScoreAns;
  final int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;


  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: const Duration(seconds: 600), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_selectedAns == 0) _numOffiveScoreAns++;
    if (_selectedAns == 1) _numOffourScoreAns++;
    if (_selectedAns == 2) _numOfthreeScoreAns++;
    if (_selectedAns == 3) _numOftwoScoreAns++;
    if (_selectedAns == 4) _numOfoneScoreAns++;
    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
    scoretotal = numOffiveScoreAns*5 + numOffourScoreAns*4 + numOfthreeScoreAns*3 + numOftwoScoreAns*2 + numOfoneScoreAns*1;
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to navigate another page
      Get.to(const ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
