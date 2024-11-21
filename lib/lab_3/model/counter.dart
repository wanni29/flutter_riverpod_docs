class Counter {
  final int count;
  final String messageId;

  Counter({
    required this.count,
    required this.messageId,
  });

  // copywith에 대한 코드 개념 및 사용법 정리
  // -> 기존에 사용하던 객체는 그대로 두고, 새로운 객체가 생성되지만 필드값이 조금씩 다르게 생성됨
  Counter copyWith({int? count, String? messageId}) {
    return Counter(
      count: count ?? this.count,
      messageId: messageId ?? this.messageId,
    );
  }
}
