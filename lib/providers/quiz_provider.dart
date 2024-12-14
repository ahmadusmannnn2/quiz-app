import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/api_service.dart';

class QuizProvider extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  // Getter untuk data yang dibutuhkan
  List<Question> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;

  // Memuat soal dari API
  Future<void> fetchQuestions() async {
    try {
      _questions = await ApiService().fetchQuestions();
      _currentIndex = 0;
      _score = 0;
      notifyListeners(); // Memberitahu widget untuk memperbarui UI
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }

  // Memeriksa jawaban
  void checkAnswer(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentIndex].correctAnswer) {
      _score++;
    }

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    } else {
      // Jika sudah selesai semua
      _currentIndex = -1; // Tanda selesai
    }
    notifyListeners(); // Perbarui state
  }

  // Restart quiz
  void restartQuiz() {
    _currentIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
