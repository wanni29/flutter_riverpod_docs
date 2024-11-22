import 'package:flutter_riverpod/flutter_riverpod.dart';

final greetingProvider =
    Provider.family.autoDispose<String, String>((ref, name) {
  return 'Hello, $name!';
});
