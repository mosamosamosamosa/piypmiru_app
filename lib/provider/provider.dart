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

//更新可能な値：１号車
final StateProvider<int> bus1Provider = StateProvider((ref) {
  return 0;
});

//更新可能な値：2号車
final StateProvider<int> bus2Provider = StateProvider((ref) {
  return 0;
});

//更新可能な値：3号車
final StateProvider<int> bus3Provider = StateProvider((ref) {
  return 0;
});

//更新可能な値：リスト
final StateProvider<List<int>> pushProvider = StateProvider((ref) {
  return List.generate(10, (i) => 0);
});

//更新可能な値：お見送りかお迎えか
final StateProvider<bool> setoffProvider = StateProvider((ref) {
  return true;
});
