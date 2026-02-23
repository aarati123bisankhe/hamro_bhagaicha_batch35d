class CartItem {
  final String id;
  final String imagePath;
  final String name;
  final int price;
  final int quantity;

  const CartItem({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({
    String? id,
    String? imagePath,
    String? name,
    int? price,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
