import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/furniture_item.dart';

class ARViewScreen extends StatefulWidget {
  final FurnitureItem furniture;
  const ARViewScreen({super.key, required this.furniture});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  bool _autoRotate = true;
  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    final item = widget.furniture;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: Column(
        children: [
          // ── 3D Viewer (takes all space above the bottom card) ──
          Expanded(
            child: Stack(
              children: [
                // Full-area Model Viewer
                Positioned.fill(
                  child: ModelViewer(
                    backgroundColor: const Color(0xFFFAF7F2),
                    src: 'assets/models/${item.modelFileName}',
                    alt: '3D model of ${item.name}',
                    ar: true,
                    arModes: const ['scene-viewer', 'webxr', 'quick-look'],
                    autoRotate: _autoRotate,
                    cameraControls: true,
                    disableZoom: false,
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                  ),
                ),

                // Top bar floating over viewer
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back
                        _CircleBtn(
                          icon: Icons.arrow_back_rounded,
                          onTap: () => Navigator.pop(context),
                        ),
                        // Auto-rotate toggle
                        _CircleBtn(
                          icon: _autoRotate
                              ? Icons.sync_rounded
                              : Icons.sync_disabled_rounded,
                          onTap: () =>
                              setState(() => _autoRotate = !_autoRotate),
                          isActive: _autoRotate,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom info card (always visible, never overlapping) ──
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 24,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + category row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: Color(0xFF2C1810),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.category.label,
                                style: const TextStyle(
                                  color: Color(0xFF9E8678),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Price
                        Text(
                          '₹${item.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFFC97B4B),
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Dimensions chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0E8DF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.straighten_rounded,
                              size: 14, color: Color(0xFF7D6B5E)),
                          const SizedBox(width: 6),
                          Text(
                            item.dimensions,
                            style: const TextStyle(
                              color: Color(0xFF7D6B5E),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Action row: Info + Place in Room
                    Row(
                      children: [
                        // Info button
                        GestureDetector(
                          onTap: () => _showInfoSheet(context, item),
                          child: Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0E8DF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.info_outline_rounded,
                              color: Color(0xFF475569),
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Place in Room button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _webViewController?.runJavaScript(
                                "document.querySelector('model-viewer').activateAR()",
                              );
                            },
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC97B4B),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFC97B4B)
                                        .withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.view_in_ar_rounded,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 10),
                                  Text(
                                    'Place in Your Room',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  void _showInfoSheet(BuildContext context, FurnitureItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE5DC),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text(
              'Description',
              style: TextStyle(
                color: Color(0xFF2C1810),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.description,
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 14,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Floating circle button ──
class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const _CircleBtn({
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFC97B4B) : Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : const Color(0xFF3D2B1F),
          size: 20,
        ),
      ),
    );
  }
}
