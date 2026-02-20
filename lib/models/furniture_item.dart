import 'package:flutter/material.dart';

class FurnitureItem {
  final String name;
  final String modelFileName;
  final IconData icon;
  final String dimensions;
  final String description;
  final Color cardColor;
  final double scale;

  const FurnitureItem({
    required this.name,
    required this.modelFileName,
    required this.icon,
    required this.dimensions,
    required this.description,
    required this.cardColor,
    required this.scale,
  });

  static const List<FurnitureItem> items = [
    FurnitureItem(
      name: 'Modern Chair',
      modelFileName: 'modern_chair.glb',
      icon: Icons.chair,
      dimensions: '50 x 50 x 80 cm',
      description:
          'A sleek modern chair with clean lines and ergonomic design. Perfect for living rooms and offices.',
      cardColor: Color(0xFF6C63FF),
      scale: 0.5,
    ),
    FurnitureItem(
      name: 'Dining Table',
      modelFileName: 'gaming_chair.glb',
      icon: Icons.table_restaurant,
      dimensions: '140 x 80 x 75 cm',
      description:
          'Elegant dining table crafted for family meals. Seats up to 6 comfortably.',
      cardColor: Color(0xFFFF6584),
      scale: 0.3,
    ),
    FurnitureItem(
      name: 'Floor Lamp',
      modelFileName: 'modern_chair.glb',
      icon: Icons.light,
      dimensions: '30 x 30 x 160 cm',
      description:
          'Contemporary floor lamp with adjustable brightness. Adds warmth to any room.',
      cardColor: Color(0xFFFFB347),
      scale: 0.4,
    ),
    FurnitureItem(
      name: 'Bookshelf',
      modelFileName: 'modern_chair.glb',
      icon: Icons.shelves,
      dimensions: '80 x 35 x 180 cm',
      description:
          'Spacious bookshelf with 5 tiers. Ideal for books, decor, and storage.',
      cardColor: Color(0xFF43B581),
      scale: 0.25,
    ),
    FurnitureItem(
      name: 'Sofa',
      modelFileName: 'modern_chair.glb',
      icon: Icons.weekend,
      dimensions: '200 x 90 x 85 cm',
      description:
          'Plush 3-seater sofa with premium fabric upholstery. Ultimate comfort for your living space.',
      cardColor: Color(0xFFE84393),
      scale: 0.2,
    ),
    FurnitureItem(
      name: 'Coffee Table',
      modelFileName: 'modern_chair.glb',
      icon: Icons.table_bar,
      dimensions: '100 x 60 x 45 cm',
      description:
          'Minimalist coffee table with a glass top and wooden legs. A stylish centerpiece.',
      cardColor: Color(0xFF00CEC9),
      scale: 0.35,
    ),
  ];
}
