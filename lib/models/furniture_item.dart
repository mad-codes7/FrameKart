import 'package:flutter/material.dart';

enum FurnitureCategory {
  chair,
  door,
  table,
  window,
  desk,
  shelf,
  gate,
  lamp,
  sofa;

  String get label {
    switch (this) {
      case FurnitureCategory.chair: return 'Chairs';
      case FurnitureCategory.door: return 'Doors';
      case FurnitureCategory.table: return 'Tables';
      case FurnitureCategory.window: return 'Windows';
      case FurnitureCategory.desk: return 'Desks';
      case FurnitureCategory.shelf: return 'Storage Shelves';
      case FurnitureCategory.gate: return 'Gates';
      case FurnitureCategory.lamp: return 'Lamps';
      case FurnitureCategory.sofa: return 'Sofas';
    }
  }

  String get singular {
    switch (this) {
      case FurnitureCategory.chair: return 'Chair';
      case FurnitureCategory.door: return 'Door';
      case FurnitureCategory.table: return 'Table';
      case FurnitureCategory.window: return 'Window';
      case FurnitureCategory.desk: return 'Desk';
      case FurnitureCategory.shelf: return 'Shelf';
      case FurnitureCategory.gate: return 'Gate';
      case FurnitureCategory.lamp: return 'Lamp';
      case FurnitureCategory.sofa: return 'Sofa';
    }
  }

  IconData get icon {
    switch (this) {
      case FurnitureCategory.chair: return Icons.chair_rounded;
      case FurnitureCategory.door: return Icons.door_front_door_rounded;
      case FurnitureCategory.table: return Icons.table_restaurant_rounded;
      case FurnitureCategory.window: return Icons.window_rounded;
      case FurnitureCategory.desk: return Icons.desktop_mac_rounded;
      case FurnitureCategory.shelf: return Icons.shelves;
      case FurnitureCategory.gate: return Icons.fence_rounded;
      case FurnitureCategory.lamp: return Icons.light_rounded;
      case FurnitureCategory.sofa: return Icons.weekend_rounded;
    }
  }

  /// Curated Unsplash image for the category tile
  String get categoryImageUrl {
    switch (this) {
      case FurnitureCategory.chair:
        return 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=600&q=80';
      case FurnitureCategory.door:
        return 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80';
      case FurnitureCategory.table:
        return 'https://images.unsplash.com/photo-1549187774-b4e9b0445b41?w=600&q=80';
      case FurnitureCategory.window:
        return 'https://images.unsplash.com/photo-1604578762246-41134e37f9f5?w=600&q=80';
      case FurnitureCategory.desk:
        return 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=600&q=80';
      case FurnitureCategory.shelf:
        return 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80';
      case FurnitureCategory.gate:
        return 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=600&q=80';
      case FurnitureCategory.lamp:
        return 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600&q=80';
      case FurnitureCategory.sofa:
        return 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80';
    }
  }
}

class FurnitureItem {
  final String name;
  final String modelFileName;
  final IconData icon;
  final String dimensions;
  final String description;
  final Color cardColor;
  final double scale;
  final FurnitureCategory category;
  final double price;
  final String imageUrl;

  const FurnitureItem({
    required this.name,
    required this.modelFileName,
    required this.icon,
    required this.dimensions,
    required this.description,
    required this.cardColor,
    required this.scale,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  String get heroTag => 'furniture_hero_$name';

  static const primaryBlue = Color(0xFFC97B4B);

  static const List<FurnitureItem> items = [
    // â”€â”€ Chairs â”€â”€
    FurnitureItem(
      name: 'Modern Chair',
      modelFileName: 'chair/modern_chair.glb',
      icon: Icons.chair_rounded,
      dimensions: '50 Ã— 50 Ã— 80 cm',
      description: 'Sleek modern chair with clean lines and ergonomic design. Perfect for living rooms and offices.',
      cardColor: primaryBlue,
      scale: 0.5,
      category: FurnitureCategory.chair,
      price: 12999,
      imageUrl: 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Gaming Chair',
      modelFileName: 'chair/gaming_chair.glb',
      icon: Icons.chair_rounded,
      dimensions: '70 Ã— 70 Ã— 130 cm',
      description: 'Ergonomic gaming chair with high backrest and lumbar support for long sessions.',
      cardColor: primaryBlue,
      scale: 0.3,
      category: FurnitureCategory.chair,
      price: 24999,
      imageUrl: 'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Accent Chair',
      modelFileName: 'chair/accent_chair.glb',
      icon: Icons.chair_rounded,
      dimensions: '60 Ã— 65 Ã— 85 cm',
      description: 'Elegant accent chair upholstered in premium velvet. A bold focal point for any room.',
      cardColor: primaryBlue,
      scale: 0.45,
      category: FurnitureCategory.chair,
      price: 18499,
      imageUrl: 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Lounge Chair',
      modelFileName: 'chair/lounge_chair.glb',
      icon: Icons.chair_rounded,
      dimensions: '80 Ã— 75 Ã— 90 cm',
      description: 'Deeply cushioned lounge chair for ultimate relaxation. A statement piece for any space.',
      cardColor: primaryBlue,
      scale: 0.45,
      category: FurnitureCategory.chair,
      price: 32999,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Wooden Chair',
      modelFileName: 'chair/wooden_chair.glb',
      icon: Icons.chair_rounded,
      dimensions: '45 Ã— 45 Ã— 90 cm',
      description: 'Classic solid wooden chair with a hand-carved backrest. Rustic charm meets durability.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.5,
      category: FurnitureCategory.chair,
      price: 8499,
      imageUrl: 'https://images.unsplash.com/photo-1592078615290-033ee584e267?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Plastic Chair',
      modelFileName: 'chair/plastic_chair.glb',
      icon: Icons.chair_rounded,
      dimensions: '42 Ã— 42 Ã— 82 cm',
      description: 'Lightweight stackable plastic chair. Weather-resistant, ideal for indoors and outdoors.',
      cardColor: const Color(0xFF64B5F6),
      scale: 0.5,
      category: FurnitureCategory.chair,
      price: 1999,
      imageUrl: 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=600&q=80',
    ),

    // â”€â”€ Doors â”€â”€
    FurnitureItem(
      name: 'Solid Wood Door',
      modelFileName: 'door/solid_wood_door.glb',
      icon: Icons.door_front_door_rounded,
      dimensions: '90 Ã— 5 Ã— 210 cm',
      description: 'Premium teak solid wood door with polished brass hardware. Timeless and sturdy.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.25,
      category: FurnitureCategory.door,
      price: 35999,
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Glass Panel Door',
      modelFileName: 'door/glass_panel_door.glb',
      icon: Icons.door_front_door_rounded,
      dimensions: '90 Ã— 5 Ã— 210 cm',
      description: 'Frosted glass panel door with aluminium frame. Lets light flow between spaces.',
      cardColor: const Color(0xFF64B5F6),
      scale: 0.25,
      category: FurnitureCategory.door,
      price: 29999,
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=600&q=80',
    ),

    // â”€â”€ Tables â”€â”€
    FurnitureItem(
      name: 'Coffee Table',
      modelFileName: 'table/coffee_table.glb',
      icon: Icons.table_bar_rounded,
      dimensions: '100 Ã— 60 Ã— 45 cm',
      description: 'Minimalist coffee table with a glass top and walnut wooden legs.',
      cardColor: primaryBlue,
      scale: 0.35,
      category: FurnitureCategory.table,
      price: 8999,
      imageUrl: 'https://images.unsplash.com/photo-1549187774-b4e9b0445b41?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Dining Table',
      modelFileName: 'table/dining_table.glb',
      icon: Icons.table_restaurant_rounded,
      dimensions: '180 Ã— 90 Ã— 76 cm',
      description: 'Solid oak 6-seater dining table. Built to last and crafted for family moments.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.2,
      category: FurnitureCategory.table,
      price: 52999,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
    ),

    // â”€â”€ Windows â”€â”€
    FurnitureItem(
      name: 'Bay Window',
      modelFileName: 'window/bay_window.glb',
      icon: Icons.window_rounded,
      dimensions: '120 Ã— 10 Ã— 150 cm',
      description: 'Contemporary bay window with double-glazed panels. Maximises natural light.',
      cardColor: const Color(0xFF64B5F6),
      scale: 0.3,
      category: FurnitureCategory.window,
      price: 42000,
      imageUrl: 'https://images.unsplash.com/photo-1604578762246-41134e37f9f5?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Sliding Window',
      modelFileName: 'window/sliding_window.glb',
      icon: Icons.window_rounded,
      dimensions: '150 Ã— 8 Ã— 120 cm',
      description: 'UPVC sliding window with mosquito mesh. Energy-efficient and easy to operate.',
      cardColor: const Color(0xFF64B5F6),
      scale: 0.3,
      category: FurnitureCategory.window,
      price: 18500,
      imageUrl: 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?w=600&q=80',
    ),

    // â”€â”€ Desks â”€â”€
    FurnitureItem(
      name: 'Standing Desk',
      modelFileName: 'desk/standing_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '140 Ã— 70 Ã— 72â€“120 cm',
      description: 'Height-adjustable electric standing desk. Sit-stand for better posture and productivity.',
      cardColor: primaryBlue,
      scale: 0.3,
      category: FurnitureCategory.desk,
      price: 38999,
      imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Study Desk',
      modelFileName: 'desk/study_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '120 Ã— 60 Ã— 75 cm',
      description: 'Clean minimal study desk with cable management. Perfect for home office setups.',
      cardColor: primaryBlue,
      scale: 0.35,
      category: FurnitureCategory.desk,
      price: 14999,
      imageUrl: 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Computer Desk',
      modelFileName: 'desk/computer_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '120 Ã— 55 Ã— 75 cm',
      description: 'Spacious computer desk with monitor shelf and keyboard tray. Built for productivity.',
      cardColor: primaryBlue,
      scale: 0.35,
      category: FurnitureCategory.desk,
      price: 19999,
      imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Metal Desk',
      modelFileName: 'desk/metal_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '130 Ã— 65 Ã— 75 cm',
      description: 'Industrial-style metal frame desk. Durable, modern, and great for small spaces.',
      cardColor: const Color(0xFF546E7A),
      scale: 0.35,
      category: FurnitureCategory.desk,
      price: 11999,
      imageUrl: 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Modern Desk',
      modelFileName: 'desk/modern_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '140 Ã— 60 Ã— 75 cm',
      description: 'Sleek modern desk with floating design. Pairs well with any contemporary interior.',
      cardColor: primaryBlue,
      scale: 0.35,
      category: FurnitureCategory.desk,
      price: 22999,
      imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Office Desk',
      modelFileName: 'desk/office_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '150 Ã— 70 Ã— 75 cm',
      description: 'Professional office desk with side drawers. Keeps your workspace neat and organised.',
      cardColor: primaryBlue,
      scale: 0.3,
      category: FurnitureCategory.desk,
      price: 27999,
      imageUrl: 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Wooden Office Desk',
      modelFileName: 'desk/wooden_office_desk.glb',
      icon: Icons.desktop_mac_rounded,
      dimensions: '160 Ã— 70 Ã— 75 cm',
      description: 'Executive wooden office desk with a warm oak finish. Timeless and commanding.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.28,
      category: FurnitureCategory.desk,
      price: 42999,
      imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=600&q=80',
    ),

    // â”€â”€ Storage Shelves â”€â”€
    FurnitureItem(
      name: 'Bookshelf',
      modelFileName: 'shelf/bookshelf.glb',
      icon: Icons.shelves,
      dimensions: '80 Ã— 35 Ã— 180 cm',
      description: 'Spacious bookshelf with 5 tiers, natural pine finish. Ideal for books and decor.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.25,
      category: FurnitureCategory.shelf,
      price: 15999,
      imageUrl: 'https://images.unsplash.com/photo-1578500351865-d6c3706f46bc?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Floating Shelf Set',
      modelFileName: 'shelf/floating_shelf.glb',
      icon: Icons.shelves,
      dimensions: '60 Ã— 20 Ã— 4 cm (each)',
      description: 'Set of 3 wall-mounted floating shelves. Minimalist display storage for any room.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.4,
      category: FurnitureCategory.shelf,
      price: 4999,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Display Shelf',
      modelFileName: 'shelf/display_shelf.glb',
      icon: Icons.shelves,
      dimensions: '90 Ã— 30 Ã— 120 cm',
      description: 'Open display shelf with geometric compartments. A stylish way to showcase dÃ©cor.',
      cardColor: const Color(0xFF8B5E3C),
      scale: 0.3,
      category: FurnitureCategory.shelf,
      price: 11499,
      imageUrl: 'https://images.unsplash.com/photo-1578500351865-d6c3706f46bc?w=600&q=80',
    ),

    // â”€â”€ Gates â”€â”€
    FurnitureItem(
      name: 'Wrought Iron Gate',
      modelFileName: 'gate/wrought_iron_gate.glb',
      icon: Icons.fence_rounded,
      dimensions: '300 Ã— 5 Ã— 180 cm',
      description: 'Ornate wrought iron gate with powder-coat finish. Security meets elegance.',
      cardColor: const Color(0xFF546E7A),
      scale: 0.2,
      category: FurnitureCategory.gate,
      price: 85000,
      imageUrl: 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Sliding Steel Gate',
      modelFileName: 'gate/sliding_steel_gate.glb',
      icon: Icons.fence_rounded,
      dimensions: '400 Ã— 5 Ã— 180 cm',
      description: 'Motor-ready sliding steel gate. Contemporary design for residential driveways.',
      cardColor: const Color(0xFF546E7A),
      scale: 0.18,
      category: FurnitureCategory.gate,
      price: 120000,
      imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Garden Gate',
      modelFileName: 'gate/garden_gate.glb',
      icon: Icons.fence_rounded,
      dimensions: '120 Ã— 4 Ã— 150 cm',
      description: 'Charming wrought iron garden gate with scroll detailing. Perfect for garden entrances.',
      cardColor: const Color(0xFF546E7A),
      scale: 0.25,
      category: FurnitureCategory.gate,
      price: 32000,
      imageUrl: 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=600&q=80',
    ),

    // â”€â”€ Lamps â”€â”€
    FurnitureItem(
      name: 'Floor Lamp',
      modelFileName: 'lamp/floor_lamp.glb',
      icon: Icons.light_rounded,
      dimensions: '30 Ã— 30 Ã— 160 cm',
      description: 'Contemporary arc floor lamp with adjustable brightness. Adds warmth to any room.',
      cardColor: const Color(0xFFF59E0B),
      scale: 0.4,
      category: FurnitureCategory.lamp,
      price: 5999,
      imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Pendant Lamp',
      modelFileName: 'lamp/pendant_lamp.glb',
      icon: Icons.light_rounded,
      dimensions: '40 cm Ã˜ Ã— 120 cm drop',
      description: 'Rattan woven pendant lamp that casts beautiful warm patterns on your ceiling.',
      cardColor: const Color(0xFFF59E0B),
      scale: 0.4,
      category: FurnitureCategory.lamp,
      price: 3499,
      imageUrl: 'https://images.unsplash.com/photo-1524484485831-a92ffc0de03f?w=600&q=80',
    ),
    FurnitureItem(
      name: 'Bedside Lamp',
      modelFileName: 'lamp/bedside_lamp.glb',
      icon: Icons.light_rounded,
      dimensions: '20 Ã— 20 Ã— 45 cm',
      description: 'Compact bedside table lamp with a linen shade and warm glow. Perfect for bedrooms.',
      cardColor: const Color(0xFFF59E0B),
      scale: 0.5,
      category: FurnitureCategory.lamp,
      price: 2299,
      imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600&q=80',
    ),

    // â”€â”€ Sofas â”€â”€
    FurnitureItem(
      name: 'Sofa',
      modelFileName: 'sofa/sofa_3seater.glb',
      icon: Icons.weekend_rounded,
      dimensions: '200 Ã— 90 Ã— 85 cm',
      description: 'Plush 3-seater sofa with premium fabric upholstery. Ultimate comfort for your living space.',
      cardColor: primaryBlue,
      scale: 0.2,
      category: FurnitureCategory.sofa,
      price: 45999,
      imageUrl: 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=600&q=80',
    ),
    FurnitureItem(
      name: 'L-Shape Sofa',
      modelFileName: 'sofa/sofa_lshape.glb',
      icon: Icons.weekend_rounded,
      dimensions: '280 Ã— 180 Ã— 85 cm',
      description: 'Luxurious L-shaped sectional sofa with chaise. Transforms any living room.',
      cardColor: primaryBlue,
      scale: 0.15,
      category: FurnitureCategory.sofa,
      price: 89999,
      imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
    ),
  ];

  /// Items filtered by category
  static List<FurnitureItem> byCategory(FurnitureCategory cat) =>
      items.where((i) => i.category == cat).toList();
}
