import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_client.dart';
import 'package:hamro_bhagaicha_batch35d/core/api/api_endpoint.dart';
import 'package:hamro_bhagaicha_batch35d/core/utils/snackbar_utils.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/order_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/order_view_model.dart';

class OrderConfirmationScreen extends ConsumerStatefulWidget {
  final OrderDraft orderDraft;

  const OrderConfirmationScreen({super.key, required this.orderDraft});

  @override
  ConsumerState<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState
    extends ConsumerState<OrderConfirmationScreen> {
  bool _isSubmitting = false;

  String _deliveryLabel(DeliveryOption option) {
    return option == DeliveryOption.homeDelivery ? 'Home Delivery' : 'Pick Up';
  }

  String _paymentLabel(PaymentOption option) {
    return option == PaymentOption.cashOnDelivery
        ? 'Cash on Delivery'
        : 'eSewa';
  }

  String _buildSmsMessage(OrderEntity order) {
    return 'Order ${order.id} confirmed. Total NRP ${order.total}. '
        'Delivery: ${_deliveryLabel(order.deliveryOption)}. '
        'Payment: ${_paymentLabel(order.paymentOption)}.';
  }

  String _toE164Phone(String rawPhone) {
    final digitsOnly = rawPhone.replaceAll(RegExp(r'[^0-9+]'), '');

    if (digitsOnly.startsWith('+')) {
      final normalizedPlus = '+${digitsOnly.substring(1).replaceAll('+', '')}';
      if (RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(normalizedPlus)) {
        return normalizedPlus;
      }
      throw const FormatException('Phone must be valid E.164 format.');
    }

    // 00977XXXXXXXXXX -> +977XXXXXXXXXX
    if (digitsOnly.startsWith('00')) {
      final converted = '+${digitsOnly.substring(2)}';
      if (RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(converted)) {
        return converted;
      }
    }

    // 977XXXXXXXXXX -> +977XXXXXXXXXX
    if (digitsOnly.startsWith('977') && digitsOnly.length >= 11) {
      final converted = '+$digitsOnly';
      if (RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(converted)) {
        return converted;
      }
    }

    // Nepal local: 98XXXXXXXX or 97XXXXXXXX
    if (digitsOnly.length == 10 &&
        (digitsOnly.startsWith('98') || digitsOnly.startsWith('97'))) {
      return '+977$digitsOnly';
    }

    // Nepal local with leading 0: 098XXXXXXXX or 097XXXXXXXX
    if (digitsOnly.length == 11 &&
        digitsOnly.startsWith('0') &&
        (digitsOnly.substring(1).startsWith('98') ||
            digitsOnly.substring(1).startsWith('97'))) {
      return '+977${digitsOnly.substring(1)}';
    }

    throw const FormatException(
      'Invalid phone number. Use +97798XXXXXXXX or 98XXXXXXXX format.',
    );
  }

  Future<void> _sendOrderConfirmationSms(OrderEntity order) async {
    final phoneNumber = _toE164Phone(order.smsPhoneNumber);
    final apiClient = ref.read(apiClientProvider);

    await apiClient.post(
      ApiEndpoints.sendOrderConfirmationSms,
      data: {
        'to': phoneNumber,
        'orderId': order.id,
        'customerName': order.customerInfo.name,
        'totalAmount': order.total,
        'currency': 'NPR',
        'message': _buildSmsMessage(order),
      },
    );
  }

  Future<void> _confirmOrder() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 600));

    final createdOrder = OrderEntity(
      id: const Uuid().v4().substring(0, 8).toUpperCase(),
      orderedAt: DateTime.now(),
      items: widget.orderDraft.items,
      customerInfo: widget.orderDraft.customerInfo,
      deliveryOption: widget.orderDraft.deliveryOption,
      paymentOption: widget.orderDraft.paymentOption,
      smsPhoneNumber: widget.orderDraft.smsPhoneNumber,
    );

    ref.read(orderViewModelProvider.notifier).addOrder(createdOrder);
    ref.read(cartViewModelProvider.notifier).clearCart();

    if (!mounted) return;

    SnackbarUtils.showSuccess(context, 'Order confirmed successfully.');

    try {
      await _sendOrderConfirmationSms(createdOrder);
      if (mounted) {
        SnackbarUtils.showSuccess(
          context,
          'Confirmation SMS sent to ${_toE164Phone(createdOrder.smsPhoneNumber)}.',
        );
      }
    } on FormatException catch (e) {
      if (mounted) {
        SnackbarUtils.showWarning(context, e.message);
      }
    } on DioException catch (e) {
      if (mounted) {
        final responseMessage = e.response?.data is Map<String, dynamic>
            ? (e.response?.data['message']?.toString())
            : null;
        SnackbarUtils.showWarning(
          context,
          responseMessage ?? 'Order placed, but SMS could not be sent.',
        );
      }
    } catch (_) {
      if (mounted) {
        SnackbarUtils.showWarning(
          context,
          'Order placed, but SMS could not be sent.',
        );
      }
    }

    if (!mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const DashboardScreen(initialIndex: 1)),
      (route) => false,
    );
  }

  Future<void> _cancelDraftOrder() async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Do you want to cancel this order and return to your cart?',
        ),
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

    if (shouldCancel != true || !mounted) return;

    SnackbarUtils.showInfo(context, 'Order cancelled.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final orderDraft = widget.orderDraft;
    final orderedAt = DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: const Text('Order Confirmation')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Order Summary',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Date: $orderedAt'),
            const SizedBox(height: 12),
            ...orderDraft.items.map(
              (item) => Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      item.imagePath,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item.name),
                  subtitle: Text('Qty: ${item.quantity} x NRP ${item.price}'),
                  trailing: Text('NRP ${item.price * item.quantity}'),
                ),
              ),
            ),
            const Divider(height: 24),
            Text(
              'Customer Details',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text('Name: ${orderDraft.customerInfo.name}'),
            Text('Address: ${orderDraft.customerInfo.address}'),
            Text('Email: ${orderDraft.customerInfo.email}'),
            Text('Phone: ${orderDraft.customerInfo.phone}'),
            const SizedBox(height: 12),
            Text('Delivery: ${_deliveryLabel(orderDraft.deliveryOption)}'),
            Text('Payment: ${_paymentLabel(orderDraft.paymentOption)}'),
            const SizedBox(height: 14),
            Text(
              'Subtotal: NRP ${orderDraft.subtotal}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              'Delivery Charge: NRP ${orderDraft.deliveryCharge}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              'Total: NRP ${orderDraft.total}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isSubmitting ? null : _cancelDraftOrder,
                    child: const Text('Cancel Order'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _confirmOrder,
                    child: Text(_isSubmitting ? 'Processing...' : 'Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
