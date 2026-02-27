import 'package:flutter/foundation.dart';

enum WishlistItemType { plant, pot, combo }

@immutable
class WishlistItem {
  final String id;
  final String imagePath;
  final String name;
  final int price;
  final WishlistItemType type;

  const WishlistItem({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.type,
  });
}
