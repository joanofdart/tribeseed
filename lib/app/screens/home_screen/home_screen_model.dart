import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreenModel extends StateNotifier<AsyncValue<bool>> {
  HomeScreenModel() : super(AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = AsyncValue.data(true);
  }
}
