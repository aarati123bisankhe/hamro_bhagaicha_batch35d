import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/app/settings/shake_to_exit_provider.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/account_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/cart_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/home_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/order_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/scan_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final int initialIndex;
  const DashboardScreen({super.key, this.initialIndex = 0});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  static const double _strongShakeThreshold = 2.8;
  static const Duration _shakeWindow = Duration(milliseconds: 1200);
  static const Duration _shakeEventGap = Duration(milliseconds: 350);
  static const Duration _startupIgnoreDuration = Duration(seconds: 4);

  late int _selectedIndex;
  StreamSubscription<UserAccelerometerEvent>? _accelerometerSubscription;
  DateTime? _lastShakeAt;
  DateTime? _lastForceAt;
  DateTime? _shakeDetectionEnabledAt;
  int _shakeCount = 0;
  bool _isHandlingShake = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _shakeDetectionEnabledAt = DateTime.now().add(_startupIgnoreDuration);
    _startShakeListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSessionService = ref.read(userSessionServiceProvider);
      ref
          .read(authViewModelProvider.notifier)
          .getCurrentUser(userId: userSessionService.getCurrentUserId() ?? '');
    });
  }

  void _startShakeListener() {
    _accelerometerSubscription = userAccelerometerEventStream().listen((event) {
      final isEnabled = ref.read(shakeToExitEnabledProvider);
      if (!isEnabled) {
        return;
      }

      final detectionStartsAt = _shakeDetectionEnabledAt;
      if (detectionStartsAt != null &&
          DateTime.now().isBefore(detectionStartsAt)) {
        return;
      }

      final magnitude = math.sqrt(
        (event.x * event.x) + (event.y * event.y) + (event.z * event.z),
      );
      final now = DateTime.now();
      final withinGap =
          _lastForceAt != null &&
          now.difference(_lastForceAt!) < _shakeEventGap;

      if (magnitude < _strongShakeThreshold || withinGap || _isHandlingShake) {
        return;
      }

      if (_lastShakeAt == null ||
          now.difference(_lastShakeAt!) > _shakeWindow) {
        _shakeCount = 1;
        _lastShakeAt = now;
        _lastForceAt = now;
        return;
      }

      _shakeCount++;
      _lastForceAt = now;

      if (_shakeCount >= 2) {
        _shakeCount = 0;
        _lastShakeAt = null;
        _handleStrongShake();
      }
    });
  }

  Future<void> _handleStrongShake() async {
    if (!mounted) {
      return;
    }

    _isHandlingShake = true;
    try {
      await SystemNavigator.pop();
    } finally {
      _isHandlingShake = false;
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  List<Widget> _lstBottomScreen(AuthEntity userEntity) {
    return [
      const DashboardHomeScreen(),
      const OrderScreen(),
      const ScanScreen(),
      const CartScreen(),
      AccountScreen(userEntity: userEntity),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'An error occurred')),
        );
      }
    });

    if (authState.authEntity == null) {
      return const Scaffold(body: Center(child: Text("No user data found")));
    }

    final userEntity = authState.authEntity;
    final screens = _lstBottomScreen(userEntity!);

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Order'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],

        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
