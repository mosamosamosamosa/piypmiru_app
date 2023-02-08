import 'package:flutter_riverpod/flutter_riverpod.dart';

//更新しない値
// final Provider<String> provider = Provider((ref) {
//   return 'Hello';
// });

//更新可能な値：ユーザID
final StateProvider<int> userProvider = StateProvider((ref) {
  return 0;
});

//更新可能な値：名前
final StateProvider<String> nameProvider = StateProvider((ref) {
  return "";
});

//更新可能な値:familyID
final StateProvider<int> familyProvider = StateProvider((ref) {
  return 0;
});

//更新可能な値:operationId
final StateProvider<int> opeProvider = StateProvider((ref) {
  return 0;
});

//更新可能な値:運転手か。保護者か
final StateProvider<bool> roleProvider = StateProvider((ref) {
  return true;
});

//更新可能な値:mail
final StateProvider<String> mailProvider = StateProvider((ref) {
  return '';
});

//更新可能な値:group
final StateProvider<String> groupProvider = StateProvider((ref) {
  return '';
});
