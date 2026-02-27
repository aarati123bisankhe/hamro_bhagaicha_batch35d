import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/pot_section_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/plant_section.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/wishlist_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/wishlist_view_model.dart';

class PotSectionScreen extends ConsumerWidget {
  const PotSectionScreen({super.key});

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
              id: 'pot-$name-$imagePath',
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
              id: 'pot-$name-$imagePath',
              imagePath: imagePath,
              name: name,
              price: price,
              type: WishlistItemType.pot,
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
                      'Pots',
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
                SizedBox(height: isTablet ? 18 : 12),
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
                        'Beautiful Pots Collection',
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0D2F1B),
                        ),
                      ),
                      SizedBox(height: isTablet ? 8 : 6),
                      Text(
                        'Choose ceramic, hanging, and nursery pots to style your green space perfectly.',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 13,
                          height: 1.35,
                          color: const Color(0xFF325442),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isTablet ? 12 : 10),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PlantScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.filter_alt_outlined),
                        label: const Text('Browse Plant Section'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 10),
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.only(bottom: isTablet ? 20 : 12),
                    crossAxisCount: 2,
                    mainAxisSpacing: isTablet ? 18 : 12,
                    crossAxisSpacing: isTablet ? 18 : 12,
                    childAspectRatio: isTablet ? 0.66 : 0.58,
                    children: [
                      PotSectionCard(
                        imagePath: 'assets/images/pot1.png',
                        name: '9 Inch Wall Hanging Half Round Planter/Flower',
                        price: 250,
                        rating: 4,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-9 Inch Wall Hanging Half Round Planter/Flower-assets/images/pot1.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name: '9 Inch Wall Hanging Half Round Planter/Flower',
                          imagePath: 'assets/images/pot1.png',
                          price: 250,
                        ),
                        onAdd: () => addToCart(
                          name: '9 Inch Wall Hanging Half Round Planter/Flower',
                          imagePath: 'assets/images/pot1.png',
                          price: 250,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot2.jpeg',
                        name: '5 pics Beautiful 5 Inch Table Decor Flower pot',
                        price: 300,
                        rating: 4,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-5 pics Beautiful 5 Inch Table Decor Flower pot-assets/images/pot2.jpeg',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              '5 pics Beautiful 5 Inch Table Decor Flower pot',
                          imagePath: 'assets/images/pot2.jpeg',
                          price: 300,
                        ),
                        onAdd: () => addToCart(
                          name:
                              '5 pics Beautiful 5 Inch Table Decor Flower pot',
                          imagePath: 'assets/images/pot2.jpeg',
                          price: 300,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot3.png',
                        name: 'Small White Bonsai Bowl Planter',
                        price: 1000,
                        rating: 2,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-Small White Bonsai Bowl Planter-assets/images/pot3.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name: 'Small White Bonsai Bowl Planter',
                          imagePath: 'assets/images/pot3.png',
                          price: 1000,
                        ),
                        onAdd: () => addToCart(
                          name: 'Small White Bonsai Bowl Planter',
                          imagePath: 'assets/images/pot3.png',
                          price: 1000,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot4.png',
                        name: 'Cute Ceramic Succulent Pot (4 Inch)',
                        price: 2400,
                        rating: 5,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-Cute Ceramic Succulent Pot (4 Inch)-assets/images/pot4.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name: 'Cute Ceramic Succulent Pot (4 Inch)',
                          imagePath: 'assets/images/pot4.png',
                          price: 2400,
                        ),
                        onAdd: () => addToCart(
                          name: 'Cute Ceramic Succulent Pot (4 Inch)',
                          imagePath: 'assets/images/pot4.png',
                          price: 2400,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot5.png',
                        name:
                            '8 Inch White Cylindrical Ceramic Pot For Indoor ',
                        price: 1200,
                        rating: 4,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-8 Inch White Cylindrical Ceramic Pot For Indoor -assets/images/pot5.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              '8 Inch White Cylindrical Ceramic Pot For Indoor ',
                          imagePath: 'assets/images/pot5.png',
                          price: 1200,
                        ),
                        onAdd: () => addToCart(
                          name:
                              '8 Inch White Cylindrical Ceramic Pot For Indoor ',
                          imagePath: 'assets/images/pot5.png',
                          price: 1200,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot6.png',
                        name: 'Cute Ceramic Succulent Planter For Indoor',
                        price: 1500,
                        rating: 3,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-Cute Ceramic Succulent Planter For Indoor-assets/images/pot6.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name: 'Cute Ceramic Succulent Planter For Indoor',
                          imagePath: 'assets/images/pot6.png',
                          price: 1500,
                        ),
                        onAdd: () => addToCart(
                          name: 'Cute Ceramic Succulent Planter For Indoor',
                          imagePath: 'assets/images/pot6.png',
                          price: 1500,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot7.png',
                        name: 'Reusable 104 Holes Seedling Tray (Set of 3)',
                        price: 2000,
                        rating: 5,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-Reusable 104 Holes Seedling Tray (Set of 3)-assets/images/pot7.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name: 'Reusable 104 Holes Seedling Tray (Set of 3)',
                          imagePath: 'assets/images/pot7.png',
                          price: 2000,
                        ),
                        onAdd: () => addToCart(
                          name: 'Reusable 104 Holes Seedling Tray (Set of 3)',
                          imagePath: 'assets/images/pot7.png',
                          price: 2000,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot8.png',
                        name:
                            '5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot',
                        price: 900,
                        rating: 3,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot-assets/images/pot8.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name:
                              '5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot',
                          imagePath: 'assets/images/pot8.png',
                          price: 900,
                        ),
                        onAdd: () => addToCart(
                          name:
                              '5Pcs 6 Inch Multicolor Hooked Hanging Flower Pot',
                          imagePath: 'assets/images/pot8.png',
                          price: 900,
                        ),
                      ),
                      PotSectionCard(
                        imagePath: 'assets/images/pot9.png',
                        name: '10 Pcs 6 Inch Soft Flexible Nursery Planter',
                        price: 500,
                        rating: 4,
                        isWishlisted: wishlistState.any(
                          (item) =>
                              item.id ==
                              'pot-10 Pcs 6 Inch Soft Flexible Nursery Planter-assets/images/pot9.png',
                        ),
                        onToggleWishlist: () => toggleWishlist(
                          name: '10 Pcs 6 Inch Soft Flexible Nursery Planter',
                          imagePath: 'assets/images/pot9.png',
                          price: 500,
                        ),
                        onAdd: () => addToCart(
                          name: '10 Pcs 6 Inch Soft Flexible Nursery Planter',
                          imagePath: 'assets/images/pot9.png',
                          price: 500,
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
