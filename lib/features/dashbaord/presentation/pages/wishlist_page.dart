import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/wishlist_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/wishlist_view_model.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 28 : 16),
            child: Column(
              children: [
                SizedBox(height: isTablet ? 14 : 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                      'Wishlist',
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
                if (wishlistItems.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        'No items in wishlist yet.',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF325442),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: wishlistItems.length,
                      padding: EdgeInsets.only(bottom: isTablet ? 20 : 12),
                      itemBuilder: (context, index) {
                        final item = wishlistItems[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: isTablet ? 14 : 10),
                          padding: EdgeInsets.all(isTablet ? 14 : 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFF4FBF0), Color(0xFFE3F1DC)],
                            ),
                            border: Border.all(
                              color: const Color(0xFFB8D7B9),
                              width: 1.1,
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.imagePath,
                                  width: isTablet ? 84 : 68,
                                  height: isTablet ? 84 : 68,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: isTablet ? 14 : 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTablet ? 18 : 14,
                                        color: const Color(0xFF0E2B18),
                                      ),
                                    ),
                                    SizedBox(height: isTablet ? 8 : 6),
                                    Text(
                                      _typeLabel(item.type),
                                      style: TextStyle(
                                        fontSize: isTablet ? 14 : 12,
                                        color: const Color(0xFF486457),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: isTablet ? 6 : 4),
                                    Text(
                                      'NRP ${item.price}',
                                      style: TextStyle(
                                        fontSize: isTablet ? 16 : 13,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(wishlistViewModelProvider.notifier)
                                      .remove(item.id);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _typeLabel(WishlistItemType type) {
    switch (type) {
      case WishlistItemType.plant:
        return 'Plant';
      case WishlistItemType.pot:
        return 'Pot';
      case WishlistItemType.combo:
        return 'Combo';
    }
  }
}
