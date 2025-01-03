# RiverPod Docs 공부하기

처음에는 플러터 조금 끄적이다가 리버팟이 문서가 어떻게 되있는지 갑자기 궁금해져서 검색해봄, Riverpod을 공부 할 수 있는 사이트가 잘되어있어서 공부시작
> 참고링크 :   https://riverpod.dev/ko/

# 공부 순서
문서 읽는데 무슨말 하는지 하나도 모르겠음,
지피티에게 물어봄

_지피티 : ㄴㄴ, 님 그렇게 말고 단계별로 진행하셈, 알려드림_

1. provider의 개념, 사용법, 종류

2. RiverPod 문서를 한번에 다 읽지 말고 단계별로 세분화 해서 읽을것( riverpod 개요 / riverpod 종류 / riverpod 상태관리 패턴 - watch, read, notify)

3. 상태변경과 UI업데이트

---

# 기본기 : Provider
- Provider의 개념_1 : Singletons, Service Locators, Dependency Injection, InheritedWidget의 개념을 하나로 다룰수 있는 편리한 도구라고 보면됨
(추후 GPT한테 물어봐서 Singletons, Service 등 4가지 Dart로 구현해보기) 

- Provider의 개념_2 : 근데 가장 중요한 핵심적인 개념은 상태관리를 부모에서 자식에게 넘겨주고 또 넘겨주고 반대로 자식에서 부모에게로 위로 올리고 하는 번거로운 작업을 더욱  편리하게 처리하기위해서 매개변수로 받는것이 아닌 아예 밖으로 빼내서 제 3의 창고에 보관해서 빼고 쓰는것이 가장 핵심적인 개념임

- Provider의 개념_3 : 그래서 전역적으로 사용하기 위해서 void main() {} 안에 runApp()이 선언되기 전에 ProviderScope로 감싸주는게 그 이유임 가장 최상위의 위젯이니, 어디든 접근이 가능한거임

- Provider의 개념_4 : 코드를 누구나 함부로 손대지 못하도록 Provider패키지 안에서는 __불변성(immutable)__ 만들어져있음 한마디로 말해 읽기전용으로 패키지가 구성되어있으며, 자바로 치면 getter의 개념임
그래서 값을 변경하기 위해서 StateNotifier나 StateNotifierProvider가 필요하다.
(정확한건 아니지만 setter가 되는 StateNotifier or StateNotifierProvider)

- Provider의 개념_5 : 코드 안에서 Provider를 사용하려면 ref라는 값이 필요함
이 ref는 flutter가 기본으로 제공하는 매개변수값이아니기 때문에 위젯을 변경해주어야함
(statelessWidget -> ConsumerWidget)
(statefulWidget -> ConsumerStatefulWidget)
(빌드가 되고 싶은 위젯부분에 Consumer로 감싸 준뒤 (context, ref, child) {} 을 이용하여 ref값 얻어내기)
결국엔 ref 값을 얻어내기 위한 코드였던거임

# 객체의 전체 필드값을 구독 vs 객체의 일부 값을 구독 (lib / lab_1을 참고하기)
- 객체를 구독하는 것이 이전까지 내가 알고있던 전부였다. 신기하게도 객체뿐만 아니라 좀 더 정밀하게 객체의 필드값을 구독하는 것도있다.

- 무엇이 다른걸까?

> _객체를 구독하게 된다면(User)_
객체의 한 부분만 달라져도 리빌딩된다. 화면이 다시 그려지기 때문에 만약 값이 실시간으로 변하는 구글맵이라든지, 많은 필드값을 가지고 있는 점에 대해서는 무수히 많은 깜빡임과 API요청이 끊임 없이 발생할것이다.
```
final user = ref.watch(userProvider); 
```

>  _객체의 필드값만을 구독하게 된다면(User.name)_
name만 변경됨에 따라 UI가 변경이 되기에 User의 나이, 이메일, 주소, 기타 등등 이 변경되도 UI의 변화는 없다. 매우 효율적인 코드가 된다는 점이다. 불필요한 API사용이 없으며, front / back 둘다 효과적인 방안이다. 
```
final name = ref.watch(userProvider.select((user) => user.name))
```
# Combine Provider(lib / lab_2 참고하기)
생각 보다 간단한 내용임, lab_2를 보면 filtered_todo_list_provider -> 이 공급자가 filter_provider와 todo_list_provider를 가지고 와서 데이터를 가공한 이후 combine_watch.dart 파일에서 UI를 관리하니까 거기에 데이터를 뿌려주는 작업임
2개의 공급자에게 접근할수있는 이유는 ref가 존재하기 때문에 가능함

근데 여기서 중요한 개념이 한가지 등장함 
유독 유심히 봐야하는 파일이 있는데 todo_list_provider.dart임
StateNotiferProvider :  관리자 역할 (싱글톤으로 상태를 관리)
StateNotifier : 상태를 변경, 삭제, 추가 하는 역할을 함(싱글톤으로 관리된 상태를 변경, 삭제, 추가하는 작업)

진행하면서 특이한 코드
```
final todoList = ref.read(todoListProvider.notifier);
-> 이 코드의 해석은 'todoListProvider가 관리하는 상태를 변경 및 추가, 삭제를 하고싶어'
-> 그래서인지 todoList.addTodo, todoList.toggleCompleted ... 
이런식으로 상태를 변경하는 메서드를 다 사용할수있음 (todo_list_provider.dart 참고)
``` 
# Modifier(수식어 : family, autoDispose -> lib / lab_3 참고하기)
_family 의 역할_ : 창고 관리자를 사용하게 될때에 매개변수를 받을수 있고,
그 매개변수를 창고로 이동시켜서 내게 필요한 데이터로 재가공할수있다.
(동적으로 값을 변경 시킬수있음)
_autoDispose 의 역할_ : 창고 관리자가 더 이상 사용되어지지 않을때, 자원의 누유를 막도록 자동 삭제를 함 
```
final counterProvider =
    StateNotifierProvider.autoDispose.family<CounterNotifier, Counter, String>(
  (ref, messageId) {
    ref.onDispose(() {
      print('CounterProvider with messageId $messageId disposed');
    });
    return CounterNotifier(messageId);
  },
);
```

# ProviderObserver(lib / lab_4 참고하기)
어떠한 provider가 생성이 되었고 동작을 하는지 로고를 띄우는거임
provider의 종류가 상태관리를 진행하다 보면 굉장히 복잡하게 이루어져서 되었느지 감도 안올때 로고문을 보고 식별이 가능하도록 만들어 둔거 같음
근데 그 기능을 구사하기가 굉장히 심플해서 참 편리하다.
창고관리자, 창고가 동작을 하는지 안하는지에 대한 관찰이 필요할때 이를 쓰면 더욱 빨리 수정이 가능하지 않을까 ?

_사용방법_
1. void main()  코드 안에서 ProviderScope의 매개변수 observers를 사용하여 값을 넣어주면 자동적으로 인식하게 된다.
단 observers 객체를 만들어 주어야하는데 그 파일은 my_observer.dart 파일을 참고하면된다.

2. ProviderObserver에는 종류가 3가지가있다. (상태관리자를 통해서 업데이트 되었을때, 상태관리자가 생성되었을때, 상태관리자가 종료되었을때)
옵저버 객체 만든 이후 void main()의 ProviderScope의 매개변수로 넣어주면 끝

3. 근데, 필요이상으로 너무 많은 로고문이 띄우면 복잡해서 오히려 해가 되는 상황이 될수도 있으니 잘 고려해서 상황에 맞게 사용하자 ! 
---
# Provider의 종류
![alt text](providers.png)