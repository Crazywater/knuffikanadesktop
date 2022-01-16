import 'generator.dart';

class GuessableKana {
  bool _isDone = false;
  final String kana;

  GuessableKana(this.kana);

  bool get isDone => _isDone;
}

class GuessRound {
  int _currentIndex = 0;
  final List<GuessableKana> kana;

  GuessRound(this.kana);

  int get currentIndex => _currentIndex;

  bool get isFinished => _currentIndex == kana.length;

  GuessableKana get currentKana => kana[currentIndex];

  void markCorrect() {
    kana[_currentIndex]._isDone = true;
    _currentIndex++;
  }
}

GuessRound createRound() {
  final kana = generateKana(50);
  return GuessRound(kana.map(GuessableKana.new).toList());
}
