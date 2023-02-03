import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piyomiru_application/riverpod_samp/porovider.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String data = ref.watch(provider);

    // ④状態管理している値を取得する
    final countState = ref.watch(countProvider);
    // ⑤状態管理している値を操作できるようにする
    final countNotifier = ref.watch(countProvider.notifier);

    return Scaffold(
      body: Center(
          child: Column(
        children: [Text(data), Text(countState.toString())],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countNotifier.state++;
          child:
          Icon(Icons.add);
        },
      ),
    );
  }
}
