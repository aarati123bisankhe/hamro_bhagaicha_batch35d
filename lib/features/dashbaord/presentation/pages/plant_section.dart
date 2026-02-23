import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/core/widget/plant_section_card.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/pages/dashboard_screen.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/cart_state.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/view_model/cart_view_model.dart';

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

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isTablet ? 100 : 80),
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
                  child: Image.asset(
                    'assets/icons/arrow icon.png',
                    height: isTablet ? 40 : 28,
                    width: isTablet ? 40 : 28,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Hamro Bhagaicha 🌿',
                      style: TextStyle(
                        fontSize: isTablet ? 34 : 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isTablet ? 60 : 30),
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search for a specific plant...',
                prefixIcon: Icon(Icons.search, size: isTablet ? 35 : 24),
                hintStyle: TextStyle(fontSize: isTablet ? 20 : 14),
                filled: true,
                fillColor: const Color.fromARGB(255, 242, 251, 233),
                contentPadding: EdgeInsets.symmetric(
                  vertical: isTablet ? 19 : 12,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 40 : 20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: isTablet ? 45 : 25),
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
                    onTap: () =>
                        setState(() => _selectedFilter = PlantFilter.indoor),
                    isTablet: isTablet,
                  ),
                  _buildFilterChip(
                    label: 'Outdoor Plants',
                    selected: _selectedFilter == PlantFilter.outdoor,
                    onTap: () =>
                        setState(() => _selectedFilter = PlantFilter.outdoor),
                    isTablet: isTablet,
                  ),
                ],
              ),
            ),
            SizedBox(height: isTablet ? 45 : 26),
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
                        padding: EdgeInsets.zero,
                        itemCount: filteredPlants.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 3 : 2,
                          mainAxisSpacing: isTablet ? 20 : 15,
                          crossAxisSpacing: isTablet ? 20 : 15,
                          childAspectRatio: isTablet ? 0.8 : 0.65,
                        ),
                        itemBuilder: (context, index) {
                          final plant = filteredPlants[index];
                          return PlantCard(
                            imagePath: plant.imagePath,
                            name: plant.name,
                            description: plant.description,
                            price: plant.price,
                            rating: plant.rating,
                            onAdd: () => _addToCart(plant),
                          );
                        },
                      ),
              ),
            ),
          ],
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
          horizontal: isTablet ? 25 : 15,
          vertical: isTablet ? 11 : 6,
        ),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 25 : 10),
          border: Border.all(color: Colors.green),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isTablet ? 20 : 14,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.green,
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
}
