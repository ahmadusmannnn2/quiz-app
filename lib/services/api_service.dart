import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  final String baseUrl =
      'https://opentdb.com/api.php?amount=10&category=22&difficulty=easy&type=multiple';

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return (data['results'] as List)
            .map((questionData) => Question.fromJson(questionData))
            .toList();
      } else {
        throw Exception('Failed to load questions: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
