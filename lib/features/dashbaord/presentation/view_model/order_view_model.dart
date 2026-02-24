import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/order_state.dart';

final orderViewModelProvider =
    NotifierProvider<OrderViewModel, List<OrderEntity>>(OrderViewModel.new);

class OrderViewModel extends Notifier<List<OrderEntity>> {
  @override
  List<OrderEntity> build() => [];

  void addOrder(OrderEntity order) {
    state = [order, ...state];
  }

  void cancelOrder(String orderId) {
    state = state
        .map(
          (order) => order.id == orderId
              ? order.copyWith(status: OrderStatus.cancelled)
              : order,
        )
        .toList();
  }
}
