import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef HomeNotifier = AsyncNotifierProvider<HomeProvider, void>;

final homeProvider = HomeNotifier(HomeProvider.new);

class HomeProvider extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    await Future.delayed(const Duration(seconds: 2));
    state = const AsyncValue.data(null);
  }
}
