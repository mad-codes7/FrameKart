import 'package:flutter/material.dart';
import '../models/furniture_item.dart';
import 'ar_view_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: CustomScrollView(
        slivers: [
          // --- Gradient App Bar ---
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: const Color(0xFF0D1117),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'AR Furniture',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A1A2E),
                      Color(0xFF16213E),
                      Color(0xFF0F3460),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -40,
                      right: -30,
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 60,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.03),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 52,
                      left: 20,
                      child: Text(
                        'Visualize furniture in your space',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- Section Header ---
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Choose Furniture',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${FurnitureItem.items.length} items',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Furniture Grid ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.82,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = FurnitureItem.items[index];
                  return _FurnitureCard(item: item);
                },
                childCount: FurnitureItem.items.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────
//  Furniture Card Widget
// ──────────────────────────────────────────────────
class _FurnitureCard extends StatefulWidget {
  final FurnitureItem item;
  const _FurnitureCard({required this.item});

  @override
  State<_FurnitureCard> createState() => _FurnitureCardState();
}

class _FurnitureCardState extends State<_FurnitureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        setState(() => _hovering = true);
      },
      onTapUp: (_) {
        _controller.reverse();
        setState(() => _hovering = false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ARViewScreen(furniture: item),
          ),
        );
      },
      onTapCancel: () {
        _controller.reverse();
        setState(() => _hovering = false);
      },
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
            child: child,
          );
        },
        child: _buildCard(item),
      ),
    );
  }

  Widget _buildCard(FurnitureItem item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: item.cardColor.withValues(alpha: 0.12),
        border: Border.all(
          color: _hovering
              ? item.cardColor.withValues(alpha: 0.6)
              : item.cardColor.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: item.cardColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: item.cardColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                item.icon,
                color: item.cardColor,
                size: 28,
              ),
            ),
            const Spacer(),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.straighten_rounded,
                  size: 13,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item.dimensions,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: item.cardColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.view_in_ar_rounded,
                    size: 13,
                    color: item.cardColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'View in AR',
                    style: TextStyle(
                      fontSize: 11,
                      color: item.cardColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple AnimatedWidget wrapper for inline use.
class AnimatedBuilder extends AnimatedWidget {
  final Widget? child;
  final TransitionBuilder builder;

  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}
