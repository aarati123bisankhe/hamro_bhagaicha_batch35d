import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/plant_section_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/wishlist_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/wishlist_view_model.dart';

enum PlantCategory { indoor, outdoor }

enum PlantFilter { all, indoor, outdoor }

class PlantItem {
  final String imagePath;
  final String name;
  final String description;
  final int price;
  final int rating;
  final PlantCategory category;

  const PlantItem({
    required this.imagePath,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });
}

class PlantScreen extends ConsumerStatefulWidget {
  const PlantScreen({super.key});

  @override
  ConsumerState<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends ConsumerState<PlantScreen> {
  PlantFilter _selectedFilter = PlantFilter.all;
  String _searchQuery = '';

  static const List<PlantItem> _allPlants = [
    PlantItem(
      imagePath: 'assets/images/moneyplant.png',
      name: 'Money Plant',
      description: 'Easy to care for',
      price: 400,
      rating: 4,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/snakeplant.png',
      name: 'Snake Plant',
      description: 'Evergreen perennial typically grown as a houseplant',
      price: 350,
      rating: 3,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/rose.png',
      name: 'Rose Plant',
      description: 'A woody perennial flowering plant of the genus Rosa.',
      price: 500,
      rating: 5,
      category: PlantCategory.outdoor,
    ),
    PlantItem(
      imagePath: 'assets/images/pathosplant.png',
      name: 'Pothos Plant',
      description: 'Genus of Plants',
      price: 500,
      rating: 4,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/spiderplant.png',
      name: 'Spider Plant',
      description: 'Easy to care',
      price: 350,
      rating: 4,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/rubberplant.png',
      name: 'Rubber Plant',
      description: 'Easy-to-care-for plant',
      price: 300,
      rating: 3,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/catpam.png',
      name: 'Cat Palm',
      description: 'Cat palms grow best in bright, indirect light.',
      price: 500,
      rating: 5,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/tradescantta plant.png',
      name: 'Tradescantta Plant',
      description:
          'An easy-to-grow, trailing plant that is great for beginners',
      price: 800,
      rating: 4,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/ruberplant.png',
      name: 'Rubber Plant',
      description:
          'Fertilize every two weeks when actively growing from spring through fall',
      price: 670,
      rating: 5,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/castironplant.png',
      name: 'Cast iron Plant',
      description: 'A good choice for dimly lit rooms.',
      price: 670,
      rating: 5,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/peacelilyplant.png',
      name: 'Peace Lily Plant',
      description:
          'Pure white spathes surrounding creamy white flower spikes bloom',
      price: 670,
      rating: 5,
      category: PlantCategory.indoor,
    ),
    PlantItem(
      imagePath: 'assets/images/marigoldplant.png',
      name: 'Marigold Plant',
      description: 'A hardy flowering plant that blooms all summer.',
      price: 300,
      rating: 4,
      category: PlantCategory.outdoor,
    ),
    PlantItem(
      imagePath: 'assets/images/sunflowerplant.png',
      name: 'Sunflower Plant',
      description: 'Tall, bright flowers that thrive in full sunlight.',
      price: 450,
      rating: 5,
      category: PlantCategory.outdoor,
    ),
    PlantItem(
      imagePath: 'assets/images/hibiscusplant.png',
      name: 'Hibiscus Plant',
      description: 'Large, colorful blooms that grow well outdoors.',
      price: 600,
      rating: 4,
      category: PlantCategory.outdoor,
    ),
    PlantItem(
      imagePath: 'assets/images/jasminplant.png',
      name: 'Jasmine Plant',
      description: 'Fragrant flowers perfect for gardens and balconies.',
      price: 550,
      rating: 5,
      category: PlantCategory.outdoor,
    ),
  ];

  List<PlantItem> get _filteredPlants {
    final query = _searchQuery.trim().toLowerCase();

    final categoryFiltered = switch (_selectedFilter) {
      PlantFilter.indoor =>
        _allPlants
            .where((plant) => plant.category == PlantCategory.indoor)
            .toList(),
      PlantFilter.outdoor =>
        _allPlants
            .where((plant) => plant.category == PlantCategory.outdoor)
            .toList(),
      PlantFilter.all => _allPlants,
    };

    if (query.isEmpty) return categoryFiltered;

    return categoryFiltered
        .where(
          (plant) =>
              plant.name.toLowerCase().contains(query) ||
              plant.description.toLowerCase().contains(query),
        )
        .toList();
  }

  String get _activeResultKey => '${_selectedFilter.name}::$_searchQuery';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final filteredPlants = _filteredPlants;
    final wishlistState = ref.watch(wishlistViewModelProvider);

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
                      'Plants',
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
                        'Healthy Plants Collection',
                        style: TextStyle(
                          fontSize: isTablet ? 28 : 20,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0D2F1B),
                        ),
                      ),
                      SizedBox(height: isTablet ? 8 : 6),
                      Text(
                        'Explore indoor and outdoor varieties selected for every space and season.',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 13,
                          height: 1.35,
                          color: const Color(0xFF325442),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: isTablet ? 12 : 10),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for a specific plant...',
                          prefixIcon: Icon(
                            Icons.search,
                            size: isTablet ? 30 : 20,
                          ),
                          hintStyle: TextStyle(fontSize: isTablet ? 18 : 13),
                          filled: true,
                          fillColor: const Color(0xFFF2FBE9),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: isTablet ? 18 : 12,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              isTablet ? 24 : 16,
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(
                        label: 'All',
                        selected: _selectedFilter == PlantFilter.all,
                        onTap: () =>
                            setState(() => _selectedFilter = PlantFilter.all),
                        isTablet: isTablet,
                      ),
                      _buildFilterChip(
                        label: 'Indoor Plants',
                        selected: _selectedFilter == PlantFilter.indoor,
                        onTap: () => setState(
                          () => _selectedFilter = PlantFilter.indoor,
                        ),
                        isTablet: isTablet,
                      ),
                      _buildFilterChip(
                        label: 'Outdoor Plants',
                        selected: _selectedFilter == PlantFilter.outdoor,
                        onTap: () => setState(
                          () => _selectedFilter = PlantFilter.outdoor,
                        ),
                        isTablet: isTablet,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 10),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(0.03, 0),
                        end: Offset.zero,
                      ).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: slideAnimation,
                          child: child,
                        ),
                      );
                    },
                    child: filteredPlants.isEmpty
                        ? Center(
                            key: ValueKey(_activeResultKey),
                            child: Text(
                              'No plants found for "$_searchQuery".',
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        : GridView.builder(
                            key: ValueKey(_activeResultKey),
                            padding: EdgeInsets.only(
                              bottom: isTablet ? 20 : 12,
                            ),
                            itemCount: filteredPlants.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isTablet ? 3 : 2,
                                  mainAxisSpacing: isTablet ? 18 : 12,
                                  crossAxisSpacing: isTablet ? 18 : 12,
                                  childAspectRatio: isTablet ? 0.66 : 0.58,
                                ),
                            itemBuilder: (context, index) {
                              final plant = filteredPlants[index];
                              return PlantCard(
                                imagePath: plant.imagePath,
                                name: plant.name,
                                description: plant.description,
                                price: plant.price,
                                rating: plant.rating,
                                isWishlisted: wishlistState.any(
                                  (item) =>
                                      item.id ==
                                      'plant-${plant.name}-${plant.imagePath}',
                                ),
                                onToggleWishlist: () => _toggleWishlist(plant),
                                onAdd: () => _addToCart(plant),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required bool isTablet,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 22 : 14,
          vertical: isTablet ? 10 : 6,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1B5E20) : Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 24 : 12),
          border: Border.all(color: const Color(0xFF1B5E20)),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1B5E20).withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 18 : 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : const Color(0xFF1B5E20),
          ),
        ),
      ),
    );
  }

  void _addToCart(PlantItem plant) {
    ref
        .read(cartViewModelProvider.notifier)
        .addItem(
          CartItem(
            id: 'plant-${plant.name}-${plant.imagePath}',
            imagePath: plant.imagePath,
            name: plant.name,
            price: plant.price,
          ),
        );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen(initialIndex: 3)),
    );
  }

  void _toggleWishlist(PlantItem plant) {
    ref
        .read(wishlistViewModelProvider.notifier)
        .toggleItem(
          WishlistItem(
            id: 'plant-${plant.name}-${plant.imagePath}',
            imagePath: plant.imagePath,
            name: plant.name,
            price: plant.price,
            type: WishlistItemType.plant,
          ),
        );
  }
}
