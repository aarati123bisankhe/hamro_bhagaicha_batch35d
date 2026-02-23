import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';

final cartViewModelProvider = NotifierProvider<CartViewModel, List<CartItem>>(
  CartViewModel.new,
);

class CartViewModel extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addItem(CartItem newItem) {
    final existingIndex = state.indexWhere((item) => item.id == newItem.id);
    if (existingIndex == -1) {
      state = [...state, newItem];
      return;
    }

    final updatedItem = state[existingIndex].copyWith(
      quantity: state[existingIndex].quantity + 1,
    );
    final updatedList = [...state];
    updatedList[existingIndex] = updatedItem;
    state = updatedList;
  }

  void increment(String itemId) {
    state = state
        .map(
          (item) => item.id == itemId
              ? item.copyWith(quantity: item.quantity + 1)
              : item,
        )
        .toList();
  }

  void decrement(String itemId) {
    final matchingItems = state.where((element) => element.id == itemId);
    if (matchingItems.isEmpty) return;
    final item = matchingItems.first;

    if (item.quantity <= 1) {
      remove(itemId);
      return;
    }

    state = state
        .map(
          (cartItem) => cartItem.id == itemId
              ? cartItem.copyWith(quantity: cartItem.quantity - 1)
              : cartItem,
        )
        .toList();
  }

  void remove(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  int get totalItems => state.fold(0, (total, item) => total + item.quantity);

  int get totalPrice =>
      state.fold(0, (total, item) => total + (item.price * item.quantity));
}
