import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/combo_set_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/wishlist_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/wishlist_view_model.dart';

class ComboSetScreen extends ConsumerWidget {
  const ComboSetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final wishlistState = ref.watch(wishlistViewModelProvider);

    void addToCart({
      required String name,
      required String imagePath,
      required int price,
    }) {
      ref
          .read(cartViewModelProvider.notifier)
          .addItem(
            CartItem(
              id: 'combo-$name-$imagePath',
              imagePath: imagePath,
              name: name,
              price: price,
            ),
          );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(initialIndex: 3),
        ),
      );
    }

    void toggleWishlist({
      required String name,
      required String imagePath,
      required int price,
    }) {
      ref
          .read(wishlistViewModelProvider.notifier)
          .toggleItem(
            WishlistItem(
              id: 'combo-$name-$imagePath',
              imagePath: imagePath,
              name: name,
              price: price,
              type: WishlistItemType.combo,
            ),
          );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 28 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isTablet ? 14 : 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DashboardScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/icons/arrow icon.png',
                          height: isTablet ? 26 : 22,
                          width: isTablet ? 26 : 22,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Combos',
                      style: TextStyle(
                        fontSize: isTablet ? 34 : 24,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF0A2515),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: isTablet ? 42 : 38),
                  ],
                ),
                SizedBox(height: isTablet ? 20 : 14),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isTablet ? 18 : 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withValues(alpha: 0.74),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.94),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF244935).withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Plant + Pot Combo Collection',
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0D2F1B),
                        ),
                      ),
                      SizedBox(height: isTablet ? 8 : 6),
                      Text(
                        'Hand-picked starter bundles to make your garden setup simple and beautiful.',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 13,
                          height: 1.35,
                          color: const Color(0xFF325442),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 12),
                Text(
                  'Featured Bundles',
                  style: TextStyle(
                    fontSize: isTablet ? 23 : 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF143624),
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 10),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: isTablet ? 20 : 12),
                    children: [
                      ComboSetCard(
                        imagePath: 'assets/images/combo1.png',
                        name:
                            'Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,',
                        price: 1000,
                        rating: 4,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'combo-Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,-assets/images/combo1.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              'Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,',
                          imagePath: 'assets/images/combo1.png',
                          price: 1000,
                        ),
                        onAdd: () => addToCart(
                          name:
                              'Kraft Seeds 10 Inch Pack of 6 Flower Pots for Garden with Bottom Plate & Drainage Hole,Plastic Pot for Plants,',
                          imagePath: 'assets/images/combo1.png',
                          price: 1000,
                        ),
                      ),
                      ComboSetCard(
                        imagePath: 'assets/images/combo2.png',
                        name:
                            'Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant',
                        price: 2500,
                        rating: 5,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'combo-Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant-assets/images/combo2.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              'Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant',
                          imagePath: 'assets/images/combo2.png',
                          price: 2500,
                        ),
                        onAdd: () => addToCart(
                          name:
                              'Set of 4 Indoor Plants: Spider Plant, Peace Lily, Snake Plant, & Money Plant',
                          imagePath: 'assets/images/combo2.png',
                          price: 2500,
                        ),
                      ),
                      ComboSetCard(
                        imagePath: 'assets/images/combo3.png',
                        name:
                            'Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots',
                        price: 3500,
                        rating: 4,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'combo-Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots-assets/images/combo3.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              'Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots',
                          imagePath: 'assets/images/combo3.png',
                          price: 3500,
                        ),
                        onAdd: () => addToCart(
                          name:
                              'Set of 6 live Adenium Obesum (Desert Rose) plants, ready for transplanting into your preferred containers, delivered with 4 pots',
                          imagePath: 'assets/images/combo3.png',
                          price: 3500,
                        ),
                      ),
                      ComboSetCard(
                        imagePath: 'assets/images/combo4.png',
                        name:
                            'Spider Plant, Snake Plant & Money Plant Combo – Set of 3 ',
                        price: 1500,
                        rating: 3,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'combo-Spider Plant, Snake Plant & Money Plant Combo – Set of 3 -assets/images/combo4.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              'Spider Plant, Snake Plant & Money Plant Combo – Set of 3 ',
                          imagePath: 'assets/images/combo4.png',
                          price: 1500,
                        ),
                        onAdd: () => addToCart(
                          name:
                              'Spider Plant, Snake Plant & Money Plant Combo – Set of 3 ',
                          imagePath: 'assets/images/combo4.png',
                          price: 1500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
