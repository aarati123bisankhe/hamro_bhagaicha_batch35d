import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/order_confirmation_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/order_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  DeliveryOption _deliveryOption = DeliveryOption.homeDelivery;
  PaymentOption _paymentOption = PaymentOption.cashOnDelivery;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authViewModelProvider).authEntity;
    _nameController = TextEditingController(text: user?.fullname ?? '');
    _addressController = TextEditingController(text: user?.address ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _requiredField(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final requiredValidation = _requiredField(value, 'Email');
    if (requiredValidation != null) return requiredValidation;

    final normalized = value!.trim();
    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailPattern.hasMatch(normalized)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final requiredValidation = _requiredField(value, 'Phone');
    if (requiredValidation != null) return requiredValidation;

    final normalized = value!.replaceAll(RegExp(r'[^0-9+]'), '');
    final phonePattern = RegExp(r'^(\+?[0-9]{7,15})$');
    if (!phonePattern.hasMatch(normalized)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartViewModelProvider);
    final registeredPhoneNumber =
        ref.watch(authViewModelProvider).authEntity?.phoneNumber ?? '';

    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: const Center(
          child: Text('Your cart is empty. Add items before checkout.'),
        ),
      );
    }

    final subtotal = cartItems.fold<int>(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
    final deliveryCharge = _deliveryOption == DeliveryOption.homeDelivery
        ? 100
        : 0;
    final total = subtotal + deliveryCharge;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredField(value, 'Name'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => _requiredField(value, 'Address'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
              ),
              const SizedBox(height: 20),
              const Text(
                'Delivery Option',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<DeliveryOption>(
                initialValue: _deliveryOption,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(
                    value: DeliveryOption.homeDelivery,
                    child: Text('Home Delivery (NRP 100)'),
                  ),
                  DropdownMenuItem(
                    value: DeliveryOption.pickUp,
                    child: Text('Pick Up (NRP 0)'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _deliveryOption = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<PaymentOption>(
                initialValue: _paymentOption,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(
                    value: PaymentOption.cashOnDelivery,
                    child: Text('Cash on Delivery'),
                  ),
                  DropdownMenuItem(
                    value: PaymentOption.eSewa,
                    child: Text('eSewa (Online Payment)'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _paymentOption = value;
                  });
                },
              ),
              const Divider(height: 28),
              Text(
                'Subtotal: NRP $subtotal',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Delivery: NRP $deliveryCharge',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'Total: NRP $total',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!(_formKey.currentState?.validate() ?? false)) {
                      return;
                    }

                    final orderDraft = OrderDraft(
                      items: cartItems
                          .map((item) => item.copyWith(quantity: item.quantity))
                          .toList(),
                      customerInfo: CheckoutCustomerInfo(
                        name: _nameController.text.trim(),
                        address: _addressController.text.trim(),
                        email: _emailController.text.trim(),
                        phone: _phoneController.text.trim(),
                      ),
                      deliveryOption: _deliveryOption,
                      paymentOption: _paymentOption,
                      smsPhoneNumber: _phoneController.text.trim().isNotEmpty
                          ? _phoneController.text.trim()
                          : registeredPhoneNumber,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            OrderConfirmationScreen(orderDraft: orderDraft),
                      ),
                    );
                  },
                  child: const Text('Review Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
