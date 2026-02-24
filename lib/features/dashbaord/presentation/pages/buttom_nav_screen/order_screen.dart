import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/order_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/order_view_model.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  String _deliveryLabel(DeliveryOption option) {
    return option == DeliveryOption.homeDelivery ? 'Home Delivery' : 'Pick Up';
  }

  String _paymentLabel(PaymentOption option) {
    return option == PaymentOption.cashOnDelivery
        ? 'Cash on Delivery'
        : 'eSewa';
  }

  Future<void> _cancelPlacedOrder(
    BuildContext context,
    WidgetRef ref,
    OrderEntity order,
  ) async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Placed Order'),
        content: Text('Do you want to cancel Order #${order.id}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (shouldCancel != true || !context.mounted) return;

    ref.read(orderViewModelProvider.notifier).cancelOrder(order.id);
    SnackbarUtils.showInfo(context, 'Order #${order.id} has been cancelled.');
  }

  Widget _buildOrderCard(
    BuildContext context,
    WidgetRef ref,
    OrderEntity order, {
    bool showCancelAction = false,
  }) {
    final orderedAt = DateFormat('yyyy-MM-dd hh:mm a').format(order.orderedAt);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order #${order.id}',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text('Placed on: $orderedAt'),
          Text('Items: ${order.itemCount}'),
          Text('Delivery: ${_deliveryLabel(order.deliveryOption)}'),
          Text('Payment: ${_paymentLabel(order.paymentOption)}'),
          const SizedBox(height: 8),
          ...order.items
              .take(3)
              .map(
                (item) => Text(
                  '- ${item.name} x${item.quantity}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          if (order.items.length > 3)
            Text('and ${order.items.length - 3} more item(s)'),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Customer: ${order.customerInfo.name}'),
              Text(
                'NRP ${order.total}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (showCancelAction) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () => _cancelPlacedOrder(context, ref, order),
                child: const Text('Cancel Order'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderViewModelProvider);
    final activeOrders = orders
        .where((order) => order.status != OrderStatus.cancelled)
        .toList();
    final cancelledOrders = orders
        .where((order) => order.status == OrderStatus.cancelled)
        .toList();

    return Scaffold(
      backgroundColor: isDarkMode(context)
          ? const Color(0xFF111827)
          : const Color(0xFFF4FAEF),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Text(
                    'My Orders',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (orders.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No orders yet.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Active Orders',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (activeOrders.isEmpty)
                      const Text(
                        'No active orders.',
                        style: TextStyle(color: Colors.black54),
                      )
                    else
                      ...activeOrders.map(
                        (order) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildOrderCard(
                            context,
                            ref,
                            order,
                            showCancelAction: true,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    const Text(
                      'Cancelled Orders',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (cancelledOrders.isEmpty)
                      const Text(
                        'No cancelled orders.',
                        style: TextStyle(color: Colors.black54),
                      )
                    else
                      ...cancelledOrders.map(
                        (order) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildOrderCard(context, ref, order),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
