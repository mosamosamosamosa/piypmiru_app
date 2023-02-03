import 'package:flutter_riverpod/flutter_riverpod.dart';

//更新しない値
final Provider<String> provider = Provider((ref) {
  return 'Hello';
});

//更新可能な値
final StateProvider<int> countProvider = StateProvider((ref) {
  return 0;
});
