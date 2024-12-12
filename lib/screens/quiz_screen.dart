import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<Question>> _questionsFuture;
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _questionsFuture = ApiService().fetchQuestions();
  }

  void _checkAnswer(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentIndex].correctAnswer) {
      setState(() {
        _score++;
      });
    }
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: _score, total: _questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: FutureBuilder<List<Question>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No questions available.'));
          } else {
            _questions = snapshot.data!;
            final question = _questions[_currentIndex];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Question ${_currentIndex + 1}/${_questions.length}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Text(question.question, style: const TextStyle(fontSize: 22)),
                  const SizedBox(height: 20),
                  ...question.options.map((option) {
                    return ElevatedButton(
                      onPressed: () => _checkAnswer(option),
                      child: Text(option),
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
