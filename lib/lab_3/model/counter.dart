class Counter {
  final int count;
  final String messageId;

  Counter({
    required this.count,
    required this.messageId,
  });

  // copywith에 대한 코드 개념 및 사용법 정리
  Counter copyWith({int? count, String? messageId}) {
    return Counter(
      count: count ?? this.count,
      messageId: messageId ?? this.messageId,
    );
  }
}
