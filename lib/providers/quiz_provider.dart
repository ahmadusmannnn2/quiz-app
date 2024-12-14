void restartQuiz() async {
  try {
    _questions = await ApiService().fetchQuestions(); // Memuat ulang soal dari API
    _currentIndex = 0; // Reset indeks soal
    _score = 0;        // Reset skor
    notifyListeners();
  } catch (e) {
    throw Exception('Failed to restart quiz: $e');
  }
}
