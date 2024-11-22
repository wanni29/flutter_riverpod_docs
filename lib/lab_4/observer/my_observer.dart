import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyObserver extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    log('didUpdateProvider / Provider: $provider, 이전값 : $previousValue, 새 값: $newValue');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    log('didAddProvider / Provider 추가 : $provider, 값 : $value');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    log('didDisposeProvider / Provider 제거 : $provider');
  }
}
