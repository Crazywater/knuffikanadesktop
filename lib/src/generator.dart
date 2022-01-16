import 'dart:math';

import 'kana.dart' show kana;

final _random = Random();

List<String> generateKana(int length) {
  final kanaKeys = kana.keys.toList();
  final result = List.generate(length, (index) {
    final i = _random.nextInt(kana.length);
    return kanaKeys[i];
  });
  return result;
}
