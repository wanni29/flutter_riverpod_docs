import 'package:flutter_provider_lab/lab_1/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<User>((ref) => User('Jake', 32));
