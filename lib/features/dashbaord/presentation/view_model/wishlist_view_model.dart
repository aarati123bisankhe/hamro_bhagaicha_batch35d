import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/wishlist_state.dart';

final wishlistViewModelProvider =
    NotifierProvider<WishlistViewModel, List<WishlistItem>>(
      WishlistViewModel.new,
    );

class WishlistViewModel extends Notifier<List<WishlistItem>> {
  @override
  List<WishlistItem> build() => [];

  bool isWishlisted(String itemId) {
    return state.any((item) => item.id == itemId);
  }

  void toggleItem(WishlistItem item) {
    if (isWishlisted(item.id)) {
      state = state.where((savedItem) => savedItem.id != item.id).toList();
      return;
    }

    state = [...state, item];
  }

  void remove(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }
}
