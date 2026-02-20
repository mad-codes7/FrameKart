import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../models/furniture_item.dart';

class ARViewScreen extends StatefulWidget {
  final FurnitureItem furniture;
  const ARViewScreen({super.key, required this.furniture});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  @override
  Widget build(BuildContext context) {
    final item = widget.furniture;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: Stack(
        children: [
          // 3D Model Viewer with AR support
          ModelViewer(
            backgroundColor: const Color(0xFF0D0D1A),
            src: 'assets/models/${item.modelFileName}',
            alt: '3D model of ${item.name}',
            ar: true,
            arModes: const ['scene-viewer', 'webxr', 'quick-look'],
            autoRotate: true,
            cameraControls: true,
            disableZoom: false,
          ),

          // --- Top Bar ---
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  _buildCircleButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: item.cardColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item.icon,
                            size: 16, color: item.cardColor),
                        const SizedBox(width: 6),
                        Text(
                          item.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  _buildCircleButton(
                    icon: Icons.info_outline_rounded,
                    onTap: _showInfoSheet,
                  ),
                ],
              ),
            ),
          ),

          // --- Bottom hint ---
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.view_in_ar_rounded,
                        size: 16,
                        color: item.cardColor),
                    const SizedBox(width: 8),
                    const Text(
                      'Tap the AR icon to place in your room',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────
  //  UI Helpers
  // ────────────────────────────────────────────────

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.5),
          border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  void _showInfoSheet() {
    final item = widget.furniture;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A2E),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: item.cardColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(item.icon,
                      color: item.cardColor, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.dimensions,
                        style: TextStyle(
                          color: item.cardColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              item.description,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '💡 How to use AR',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Rotate the 3D model by dragging\n'
                    '• Pinch to zoom in/out\n'
                    '• Tap the AR icon to place in your room\n'
                    '• Move phone slowly to detect surfaces',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
