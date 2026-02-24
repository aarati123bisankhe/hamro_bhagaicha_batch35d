import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';

enum DeliveryOption { homeDelivery, pickUp }

enum PaymentOption { cashOnDelivery, eSewa }

class CheckoutCustomerInfo {
  final String name;
  final String address;
  final String email;
  final String phone;

  const CheckoutCustomerInfo({
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });
}

class OrderDraft {
  final List<CartItem> items;
  final CheckoutCustomerInfo customerInfo;
  final DeliveryOption deliveryOption;
  final PaymentOption paymentOption;
  final String smsPhoneNumber;

  const OrderDraft({
    required this.items,
    required this.customerInfo,
    required this.deliveryOption,
    required this.paymentOption,
    required this.smsPhoneNumber,
  });

  int get itemCount => items.fold<int>(0, (sum, item) => sum + item.quantity);

  int get subtotal =>
      items.fold<int>(0, (sum, item) => sum + (item.price * item.quantity));

  int get deliveryCharge =>
      deliveryOption == DeliveryOption.homeDelivery ? 100 : 0;

  int get total => subtotal + deliveryCharge;
}

class OrderEntity {
  final String id;
  final DateTime orderedAt;
  final List<CartItem> items;
  final CheckoutCustomerInfo customerInfo;
  final DeliveryOption deliveryOption;
  final PaymentOption paymentOption;
  final String smsPhoneNumber;

  const OrderEntity({
    required this.id,
    required this.orderedAt,
    required this.items,
    required this.customerInfo,
    required this.deliveryOption,
    required this.paymentOption,
    required this.smsPhoneNumber,
  });

  int get itemCount => items.fold<int>(0, (sum, item) => sum + item.quantity);

  int get subtotal =>
      items.fold<int>(0, (sum, item) => sum + (item.price * item.quantity));

  int get deliveryCharge =>
      deliveryOption == DeliveryOption.homeDelivery ? 100 : 0;

  int get total => subtotal + deliveryCharge;
}
