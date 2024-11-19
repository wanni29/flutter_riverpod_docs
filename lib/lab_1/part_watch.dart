import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_1/model/user.dart';
import 'package:flutter_provider_lab/lab_1/provider/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// User 객체의 일부 필드값만을 구독하는 상황
// User 객체의 다른 필드값이 변해도 리빌딩하지 않음
// 굉장히 효율적인 코드를 만듦
// 아래는 것을 보여주는 사례
class PartWatch extends ConsumerWidget {
  const PartWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // User 객체 전체가 아닌, 필요한 부분 name만을 구독
    final name = ref.watch(userProvider.select((user) => user.name));

    // 하지만 안뜸, 그래서 효율적인 코드
    log(' 재빌드가 되면 이 문구가 떠요 ! - 비효율적인 코드를 증명해요. ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('User example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 이름 텍스트 위젯
          Text(
            'Name : ${name}',
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              // User의 속성만을 watch해주는 대신에,
              // 이렇게 ref.read코드가 한줄 더 필요하다.
              final user = ref.read(userProvider);

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
