import 'dart:math' as math;
import 'package:flutter/material.dart';

class CurvedNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const CurvedNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class CurvedBottomNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CurvedNavItem> items;
  final Color activeColor;
  final Color? barColor;

  const CurvedBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.activeColor = const Color(0xFFB71C1C),
    this.barColor,
  });

  @override
  State<CurvedBottomNav> createState() => _CurvedBottomNavState();
}

class _CurvedBottomNavState extends State<CurvedBottomNav>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 440),
    );
    _positionAnimation = AlwaysStoppedAnimation<double>(
      widget.currentIndex.toDouble(),
    );
  }

  @override
  void didUpdateWidget(covariant CurvedBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      final start = _positionAnimation.value;
      final end = widget.currentIndex.toDouble();

      _positionAnimation = Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Cubic(0.22, 1.08, 0.36, 1.0),
        ),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resolvedBarColor =
        widget.barColor ?? (isDark ? const Color(0xFF1E1E1E) : Colors.white);
    final inactiveColor =
        isDark ? const Color(0xFFB0B0B0) : const Color(0xFF616161);

    final bottomPadding = MediaQuery.of(context).padding.bottom;
    const double barHeight = 68.0;
    const double bumpRadius = 28.0;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(
        16,
        0,
        16,
        bottomPadding > 0 ? bottomPadding : 12,
      ),
      child: SizedBox(
        height: barHeight + bumpRadius,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final animatedIndex = _controller.isAnimating
                ? _positionAnimation.value
                : widget.currentIndex.toDouble();

            final morphProgress = _controller.isAnimating
                ? math.sin(_controller.value * math.pi)
                : 0.0;

            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                if (width <= 0) return const SizedBox.shrink();

                final itemWidth = width / widget.items.length;
                final centerX = (animatedIndex + 0.5) * itemWidth;

                final circleWidth = 50.0 + (morphProgress * 14.0);
                final circleHeight = 50.0 - (morphProgress * 4.0);
                final topOffset = 4.0 + (morphProgress * 3.0);

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: barHeight,
                      child: CustomPaint(
                        painter: _CurvedNavPainter(
                          centerX: centerX,
                          barColor: resolvedBarColor,
                          isDark: isDark,
                          morphStretch: morphProgress,
                        ),
                      ),
                    ),
                    Positioned(
                      left: centerX - (circleWidth / 2),
                      top: topOffset,
                      child: Container(
                        width: circleWidth,
                        height: circleHeight,
                        decoration: BoxDecoration(
                          color: resolvedBarColor,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: widget.activeColor,
                            width: 3.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.45 : 0.20,
                              ),
                              blurRadius: 12,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                            BoxShadow(
                              color: widget.activeColor.withValues(alpha: 0.25),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            switchInCurve: Curves.easeOutBack,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, anim) {
                              return ScaleTransition(
                                scale: anim,
                                child: FadeTransition(
                                  opacity: anim,
                                  child: child,
                                ),
                              );
                            },
                            child: Icon(
                              widget.items[widget.currentIndex].activeIcon,
                              key: ValueKey<int>(widget.currentIndex),
                              color: widget.activeColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: barHeight,
                      child: Row(
                        children: List.generate(widget.items.length, (index) {
                          final isSelected = index == widget.currentIndex;
                          final item = widget.items[index];

                          final distance = (animatedIndex - index).abs();
                          final iconFactor = distance.clamp(0.0, 1.0);

                          return Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => widget.onTap(index),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 26,
                                    child: Opacity(
                                      opacity: iconFactor,
                                      child: Transform.scale(
                                        scale: 0.65 + (0.35 * iconFactor),
                                        child: Icon(
                                          item.icon,
                                          color: inactiveColor,
                                          size: 23,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 240),
                                    curve: Curves.easeOutCubic,
                                    style: TextStyle(
                                      fontSize: isSelected ? 11.8 : 11.2,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? widget.activeColor
                                          : inactiveColor,
                                    ),
                                    child: Text(
                                      item.label,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 11),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CurvedNavPainter extends CustomPainter {
  final double centerX;
  final Color barColor;
  final bool isDark;
  final double morphStretch;

  _CurvedNavPainter({
    required this.centerX,
    required this.barColor,
    required this.isDark,
    required this.morphStretch,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double cornerRadius = 22.0;
    final double notchRadius = 32.0 + (morphStretch * 7.0);
    final double notchDepth = 26.0 - (morphStretch * 3.5);

    final clampedCenter = centerX.clamp(
      cornerRadius + notchRadius + 4,
      size.width - cornerRadius - notchRadius - 4,
    );

    final path = Path();
    path.moveTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    path.lineTo(clampedCenter - notchRadius - 12, 0);

    path.cubicTo(
      clampedCenter - notchRadius + 2,
      0,
      clampedCenter - notchRadius + 4,
      notchDepth,
      clampedCenter,
      notchDepth,
    );

    path.cubicTo(
      clampedCenter + notchRadius - 4,
      notchDepth,
      clampedCenter + notchRadius - 2,
      0,
      clampedCenter + notchRadius + 12,
      0,
    );

    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    path.lineTo(size.width, size.height - cornerRadius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );
    path.lineTo(cornerRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);
    path.close();

    final ambientShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: isDark ? 0.35 : 0.14)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(path, ambientShadowPaint);

    final dropShadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: isDark ? 0.45 : 0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawPath(path.shift(const Offset(0, 4)), dropShadowPaint);

    final fillPaint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    final borderPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.12)
          : Colors.black.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _CurvedNavPainter oldDelegate) {
    return oldDelegate.centerX != centerX ||
        oldDelegate.barColor != barColor ||
        oldDelegate.isDark != isDark ||
        oldDelegate.morphStretch != morphStretch;
  }
}