import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/services/storage/user_session_service.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/domain/entities/auth_entity.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/state/auth_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/account_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/cart_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/home_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/order_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/buttom_nav_screen/scan_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userSessionService = ref.read(userSessionServiceProvider);
      ref.
        read(authViewModelProvider.notifier)
        .getCurrentUser(userId: userSessionService.getCurrentUserId() ?? '');
    });
  }

  List<Widget>_lstBottomScreen(AuthEntity userEntity){
    return  [
    const DashboardHomeScreen(),
    const OrderScreen(),
    const ScanScreen(),
    const CartScreen(),
    AccountScreen(userEntity : userEntity),
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

    if(authState.authEntity == null){
      return const Scaffold(body: Center(child: Text("No user data found"),),);
    }

    final userEntity = authState.authEntity;
    final screens = _lstBottomScreen(userEntity!);
    
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        type: BottomNavigationBarType.fixed,
        items: const [
          
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory),label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner, ),label: 'Scanner'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Account'),
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