import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_1/model/user.dart';
import 'package:flutter_provider_lab/lab_1/provider/user.dart';
import 'package:flutter_provider_lab/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User 객체 전체를 구독하는 상황
// User 객체의 필드값중 일부가 변해도 계속해서 그림을 재빌드함
// 굉장히 비효율적인 코드가 되어버림
// 아래는 그것을 보여주는 사례
class TotalWatch extends ConsumerWidget {
  const TotalWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // User 객체 전체를 구독
    final user = ref.watch(userProvider);

    log(' 재빌드가 되면 이 문구가 떠요 ! - 비효율적인 코드를 증명 ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('User example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 이름 텍스트 위젯
          Text(
            'Name : ${user.name}',
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              // 나이만 변경
              ref.read(userProvider.notifier).state =
                  User(user.name, user.age + 1);
            },
            child: const Text('Increase Age'),
          )
        ],
      ),
    );
  }
}
