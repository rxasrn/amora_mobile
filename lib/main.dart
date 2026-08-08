import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AmoraDaffodilsApp());
}

class AmoraDaffodilsApp extends StatelessWidget {
  const AmoraDaffodilsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = GoogleFonts.plusJakartaSansTextTheme();
    return MaterialApp(
      title: 'Amora Daffodils',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.lightBg,
        primaryColor: AppColors.primaryPink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPink,
          primary: AppColors.primaryPink,
          surface: AppColors.lightBg,
        ),
        textTheme: base.apply(
          bodyColor: AppColors.textDark,
          displayColor: AppColors.textDark,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: AppColors.textDark.withValues(alpha: 0.92),
        ),
      ),
      home: const MainNavigationWrapper(),
    );
  }
}

// Global Color Palette matching the design exactly
class AppColors {
  static const Color primaryPink = Color(0xFFFF3377);
  static const Color lightBg = Color(0xFFFFF9F9);
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color starYellow = Color(0xFFFFC107);
  static const Color softBorder = Color(0xFFFFD6E5);

  static Color glassFill([double alpha = 0.55]) =>
      Colors.white.withValues(alpha: alpha);
  static Color glassBorder([double alpha = 0.45]) =>
      Colors.white.withValues(alpha: alpha);
}

class AppTextStyles {
  static TextStyle heading(
    double size, {
    FontWeight weight = FontWeight.w700,
    Color? color,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.textDark,
    letterSpacing: -0.3,
  );

  static TextStyle body(
    double size, {
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.textMuted,
    height: height,
  );

  static TextStyle label(
    double size, {
    FontWeight weight = FontWeight.w600,
    Color? color,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.textDark,
  );
}

/// Frosted glass container used across the app.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.blur = 12,
    this.fillAlpha = 0.55,
    this.borderAlpha = 0.65,
    this.padding,
    this.margin,
    this.borderColor,
    this.gradient,
    this.boxShadow,
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final double fillAlpha;
  final double borderAlpha;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: AppColors.primaryPink.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: gradient,
              color: gradient == null ? AppColors.glassFill(fillAlpha) : null,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? AppColors.glassBorder(borderAlpha),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Animated gradient background with soft pink orbs.
class PremiumBackground extends StatefulWidget {
  const PremiumBackground({super.key, required this.child});

  final Widget child;

  @override
  State<PremiumBackground> createState() => _PremiumBackgroundState();
}

class _PremiumBackgroundState extends State<PremiumBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFF9F9),
                    Color(0xFFFFF0F5),
                    Color(0xFFFFE8F0),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -60 + t * 20,
              right: -40,
              child: _GlowOrb(
                size: 220,
                color: AppColors.primaryPink.withValues(alpha: 0.12 + t * 0.04),
              ),
            ),
            Positioned(
              top: 280 - t * 30,
              left: -80,
              child: _GlowOrb(
                size: 180,
                color: const Color(0xFFFFC2D6).withValues(alpha: 0.18),
              ),
            ),
            Positioned(
              bottom: 120 + t * 25,
              right: -20,
              child: _GlowOrb(
                size: 140,
                color: AppColors.softBorder.withValues(alpha: 0.25),
              ),
            ),
            // Sparkles overlay
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _SparklesPainter(t)),
              ),
            ),
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}

class _SparklesPainter extends CustomPainter {
  _SparklesPainter(this.t) : super();
  final double t; // animation value 0..1

  static const _positions = [
    Offset(0.12, 0.18),
    Offset(0.28, 0.07),
    Offset(0.45, 0.25),
    Offset(0.7, 0.12),
    Offset(0.9, 0.22),
    Offset(0.18, 0.6),
    Offset(0.34, 0.5),
    Offset(0.6, 0.48),
    Offset(0.8, 0.6),
    Offset(0.15, 0.85),
    Offset(0.5, 0.82),
    Offset(0.78, 0.92),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < _positions.length; i++) {
      final pos = Offset(
        _positions[i].dx * size.width,
        _positions[i].dy * size.height,
      );
      final phase = (i * 0.13) % 1.0;
      final flicker = (0.5 + 0.5 * (math.sin((t + phase) * 2 * math.pi))).clamp(
        0.0,
        1.0,
      );
      final radius = 2.0 + flicker * 3.5;
      final alpha = (80 + flicker * 160).toInt().clamp(0, 255);
      paint.color = Color.fromARGB(alpha, 255, 245, 255);
      // subtle glow
      canvas.drawCircle(
        pos,
        radius + 3.0 * flicker,
        paint..color = paint.color.withValues(alpha: 0.12),
      );
      paint.color = Color.fromARGB(alpha, 255, 220, 235);
      canvas.drawCircle(pos, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklesPainter oldDelegate) =>
      oldDelegate.t != t;
}

/// Shimmer sweep for premium banners.
class ShimmerOverlay extends StatefulWidget {
  const ShimmerOverlay({
    super.key,
    required this.child,
    this.borderRadius = 20,
  });

  final Widget child;
  final double borderRadius;

  @override
  State<ShimmerOverlay> createState() => _ShimmerOverlayState();
}

class _ShimmerOverlayState extends State<ShimmerOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(-1.5 + _controller.value * 3, 0),
              end: Alignment(-0.5 + _controller.value * 3, 0),
              colors: [
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0.18),
                Colors.white.withValues(alpha: 0),
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.icon, this.size = 24, this.onTap});

  final IconData icon;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: GlassContainer(
          borderRadius: 12,
          blur: 10,
          fillAlpha: 0.5,
          padding: const EdgeInsets.all(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          child: Icon(icon, color: AppColors.textMuted, size: size),
        ),
      ),
    );
  }
}

class _FlowerProduct {
  const _FlowerProduct({
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.category = 'flowers',
  });

  final String name;
  final String price;
  final String rating;
  final String imageUrl;
  final String category;
}

const List<_FlowerProduct> _flowerProducts = [
  _FlowerProduct(
    name: 'Daisy',
    price: 'Php. 125.00',
    rating: '4.5',
    imageUrl: 'https://images.unsplash.com/photo-1560717845-968823efbee1?w=300',
    category: 'flower',
  ),
  _FlowerProduct(
    name: 'Sunflower',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=300',
    category: 'sunflower',
  ),
  _FlowerProduct(
    name: 'Tulips',
    price: 'Php. 125.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=300',
    category: 'tulip',
  ),
  _FlowerProduct(
    name: 'Red Rose',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl:
        'https://cdn.florista.ph/uploads/product/floristaph/JAN2026/9091-1769665216452.webp',
    category: 'rose',
  ),
  _FlowerProduct(
    name: 'Stargazer Lilies',
    price: 'Php. 125.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1582794543139-8ac9cb0f7b11?w=300',
    category: 'lily',
  ),
  _FlowerProduct(
    name: 'Lavander',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1528722828814-77b9b83aafb2?w=300',
    category: 'lavender',
  ),
];

const List<_HomeMetric> _homeMetrics = [
  _HomeMetric(
    icon: Icons.local_shipping_outlined,
    value: 'Same-day',
    label: 'delivery in Metro Manila',
  ),
  _HomeMetric(
    icon: Icons.verified_outlined,
    value: 'Fresh',
    label: 'hand-picked stems only',
  ),
  _HomeMetric(
    icon: Icons.support_agent_rounded,
    value: '24/7',
    label: 'order support',
  ),
];

class _HomeMetric {
  const _HomeMetric({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;
}

void _openFlowerOverview(
  BuildContext context, {
  required String name,
  required String price,
  required String imageUrl,
  required String rating,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(
        name: name,
        price: price,
        imageUrl: imageUrl,
        rating: rating,
      ),
    ),
  );
}

// ==========================================
// SCREEN 1: Home Screen (iPhone 17 - 1)
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _trendingKey = GlobalKey();
  late List<_FlowerProduct> _filteredProducts;
  String? _activeCategory;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List<_FlowerProduct>.from(_flowerProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<_FlowerProduct> _filterProducts(String query) {
    final normalized = query.trim().toLowerCase();
    return _flowerProducts.where((product) {
      final matchesName = product.name.toLowerCase().contains(normalized);
      final matchesCategory = product.category.toLowerCase().contains(
        normalized,
      );
      final matchesActiveCategory =
          _activeCategory == null || product.category == _activeCategory;
      return (normalized.isEmpty || matchesName || matchesCategory) &&
          matchesActiveCategory;
    }).toList();
  }

  void _updateSearch(String value) {
    setState(() {
      _filteredProducts = _filterProducts(value);
    });
  }

  void _updateCategory(String? category) {
    setState(() {
      _activeCategory = category;
      _filteredProducts = _filterProducts(_searchController.text);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _updateSearch('');
  }

  void _scrollToTrending() {
    final targetContext = _trendingKey.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
        alignment: 0.05,
      );
    }
  }

  void _openCart() {
    final product = _filteredProducts.isNotEmpty
        ? _filteredProducts.first
        : _flowerProducts.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          name: product.name,
          price: product.price,
          imageUrl: product.imageUrl,
          quantity: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    _SparkleActionButton(
                      label: 'Explore',
                      onTap: () {
                        _clearSearch();
                        _updateCategory(null);
                        _scrollToTrending();
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GlassContainer(
                        borderRadius: 22,
                        blur: 14,
                        fillAlpha: 0.62,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 44,
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: AppColors.textMuted.withValues(
                                  alpha: 0.9,
                                ),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  textInputAction: TextInputAction.search,
                                  onChanged: _updateSearch,
                                  cursorColor: AppColors.primaryPink,
                                  style: AppTextStyles.body(
                                    13,
                                    color: AppColors.textDark,
                                    weight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search flowers here',
                                    hintStyle: AppTextStyles.body(
                                      13,
                                      color: AppColors.textMuted,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () =>
                                    _updateSearch(_searchController.text),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFF3377),
                                        Color(0xFFFF5C8A),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryPink.withValues(
                                          alpha: 0.35,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.search_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    _GlassIconButton(
                      icon: Icons.notifications_none_rounded,
                      size: 26,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No new notifications')),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _GlassIconButton(
                      icon: Icons.shopping_cart_outlined,
                      size: 24,
                      onTap: _openCart,
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                GlassContainer(
                  borderRadius: 22,
                  blur: 12,
                  fillAlpha: 0.58,
                  borderColor: AppColors.primaryPink.withValues(alpha: 0.18),
                  padding: const EdgeInsets.all(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryPink.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 116,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFFF3377),
                                              Color(0xFFFF7CA5),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: const Icon(
                                          Icons.auto_awesome_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Fresh picks, polished presentation',
                                          style: AppTextStyles.label(13),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Tap the cards, explore the categories, and jump straight into checkout.',
                                    style: AppTextStyles.body(
                                      11,
                                      color: AppColors.textMuted,
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: _homeMetrics
                                        .map(
                                          (metric) => _MiniMetricChip(
                                            metric: metric,
                                            onTap: _scrollToTrending,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 92,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFFFF0F5),
                                            Color(0xFFFFD5E3),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 8,
                                    left: 10,
                                    child: _SparkleCluster(compact: true),
                                  ),
                                  Positioned(
                                    right: 8,
                                    bottom: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.75),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.local_florist_rounded,
                                        color: AppColors.primaryPink,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      _CategoryPill(
                        label: 'Seasonal',
                        icon: Icons.local_florist_rounded,
                        isHighlighted: true,
                        onTap: () {
                          _updateCategory(null);
                          _clearSearch();
                        },
                      ),
                      const SizedBox(width: 10),
                      _CategoryPill(
                        label: 'Bouquets',
                        icon: Icons.favorite_border_rounded,
                        onTap: () => _updateCategory('rose'),
                      ),
                      const SizedBox(width: 10),
                      _CategoryPill(
                        label: 'Events',
                        icon: Icons.celebration_rounded,
                        onTap: () => _updateCategory('lily'),
                      ),
                      const SizedBox(width: 10),
                      _CategoryPill(
                        label: 'Gifts',
                        icon: Icons.card_giftcard_rounded,
                        onTap: () => _updateCategory('flower'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),
                ShimmerOverlay(
                  child: GlassContainer(
                    borderRadius: 24,
                    blur: 8,
                    fillAlpha: 0.35,
                    borderAlpha: 0.5,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFE3EC),
                        Color(0xFFFFC2D6),
                        Color(0xFFFFB8CF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPink.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    child: SizedBox(
                      width: double.infinity,
                      height: 178,
                      child: Stack(
                        children: [
                          const Positioned(top: 12, left: 12, child: _SparkleCluster()),
                          const Positioned(bottom: 14, right: 12, child: _SparkleCluster(compact: true)),
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Amora Special', style: AppTextStyles.heading(22)),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Customisable flower arrangements with cleaner spacing, softer motion, and faster access to checkout.',
                                          style: AppTextStyles.body(
                                            11,
                                            color: AppColors.textDark,
                                            height: 1.35,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 14),
                                        _PrimaryActionButton(
                                          label: 'Shop Now',
                                          icon: Icons.chevron_right_rounded,
                                          onTap: _scrollToTrending,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  SizedBox(
                                    width: 112,
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(22),
                                            child: ReliableNetworkImage(
                                              imageUrl:
                                                  'https://images.unsplash.com/photo-1563241527-3004b7be0ffd?w=300',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(alpha: 0.8),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.auto_awesome_rounded,
                                              color: AppColors.primaryPink,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final isActive = index == 0;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      margin: EdgeInsets.only(right: index < 2 ? 4 : 0),
                      width: isActive ? 22 : 10,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: isActive
                            ? const LinearGradient(
                                colors: [Color(0xFFFF3377), Color(0xFFFF6B9D)],
                              )
                            : null,
                        color: isActive ? null : const Color(0xFFFFD1E1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),
                Container(key: _trendingKey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Trending Flowers', style: AppTextStyles.heading(16)),
                    GestureDetector(
                      onTap: _clearSearch,
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: AppTextStyles.body(
                              12,
                              color: AppColors.textMuted,
                              weight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: AppColors.textMuted.withValues(alpha: 0.8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                if (_filteredProducts.isEmpty)
                  GlassContainer(
                    borderRadius: 20,
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_outlined,
                          color: AppColors.textMuted.withValues(alpha: 0.8),
                          size: 36,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'No flowers match that search yet.',
                          style: AppTextStyles.body(
                            13,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 400 + index * 80),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(opacity: value, child: child),
                          );
                        },
                        child: _buildFlowerCard(
                          context,
                          name: product.name,
                          price: product.price,
                          rating: product.rating,
                          imageUrl: product.imageUrl,
                          onTap: () => _openFlowerOverview(
                            context,
                            name: product.name,
                            price: product.price,
                            imageUrl: product.imageUrl,
                            rating: product.rating,
                          ),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 2: Search Results (iPhone 17 - 2)
// ==========================================
class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key, this.initialQuery = ''});

  final String initialQuery;

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late final TextEditingController _searchController;
  late final FocusNode _focusNode;
  late List<_FlowerProduct> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _focusNode = FocusNode();
    _filteredProducts = _filterProducts(widget.initialQuery);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<_FlowerProduct> _filterProducts(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return List<_FlowerProduct>.from(_flowerProducts);
    }

    return _flowerProducts.where((product) {
      final matchesName = product.name.toLowerCase().contains(normalized);
      final matchesCategory = product.category.toLowerCase().contains(
        normalized,
      );
      return matchesName || matchesCategory;
    }).toList();
  }

  void _updateQuery(String value) {
    setState(() {
      _filteredProducts = _filterProducts(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    GlassContainer(
                      borderRadius: 999,
                      blur: 10,
                      fillAlpha: 0.5,
                      padding: EdgeInsets.zero,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(999),
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.primaryPink,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GlassContainer(
                        borderRadius: 18,
                        blur: 14,
                        fillAlpha: 0.62,
                        borderColor: AppColors.primaryPink.withValues(
                          alpha: 0.25,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 44,
                          child: Row(
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: AppColors.textMuted.withValues(
                                  alpha: 0.9,
                                ),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  focusNode: _focusNode,
                                  autofocus: true,
                                  textInputAction: TextInputAction.search,
                                  onChanged: _updateQuery,
                                  cursorColor: AppColors.primaryPink,
                                  style: AppTextStyles.body(
                                    14,
                                    color: AppColors.textDark,
                                    weight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search flowers',
                                    hintStyle: AppTextStyles.body(
                                      13,
                                      color: AppColors.textMuted,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              if (_searchController.text.isNotEmpty) ...[
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    _updateQuery('');
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: AppColors.textMuted.withValues(
                                      alpha: 0.8,
                                    ),
                                    size: 18,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF3377), Color(0xFFFF5C8A)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPink.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.tune_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Filter',
                                  style: AppTextStyles.label(
                                    11,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInOutCubic,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.04),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _filteredProducts.isEmpty
                        ? Center(
                            key: const ValueKey('empty'),
                            child: GlassContainer(
                              borderRadius: 24,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 28,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off_outlined,
                                    size: 42,
                                    color: AppColors.textMuted.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'No flowers match that search yet.',
                                    style: AppTextStyles.body(
                                      13,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GridView.builder(
                            key: ValueKey(_searchController.text),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemCount: _filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: Duration(
                                  milliseconds: 350 + index * 60,
                                ),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Transform.scale(
                                      scale: 0.92 + value * 0.08,
                                      child: child,
                                    ),
                                  );
                                },
                                child: _buildFlowerCard(
                                  context,
                                  name: product.name,
                                  price: product.price,
                                  rating: product.rating,
                                  imageUrl: product.imageUrl,
                                  onTap: () => _openFlowerOverview(
                                    context,
                                    name: product.name,
                                    price: product.price,
                                    imageUrl: product.imageUrl,
                                    rating: product.rating,
                                  ),
                                ),
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
}

// ==========================================
// SCREEN 3: Product Details (iPhone 17 - 4)
// ==========================================
class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  final String name;
  final String price;
  final String imageUrl;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.7, 1.0],
                      ).createShader(bounds),
                      blendMode: BlendMode.dstIn,
                      child: ReliableNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 44,
                      left: 16,
                      right: 16,
                      child: GlassContainer(
                        borderRadius: 16,
                        blur: 16,
                        fillAlpha: 0.45,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(999),
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: AppColors.primaryPink,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GlassContainer(
                                borderRadius: 10,
                                blur: 8,
                                fillAlpha: 0.7,
                                borderColor: AppColors.primaryPink.withValues(
                                  alpha: 0.4,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                boxShadow: const [],
                                child: Text(
                                  name,
                                  style: AppTextStyles.label(12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            _DetailActionButton(
                              icon: Icons.shopping_cart_outlined,
                              label: 'Cart',
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartScreen(
                                    name: name,
                                    price: price,
                                    imageUrl: imageUrl,
                                    quantity: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.heading(24)),
                      const SizedBox(height: 8),
                      Text(
                        'A clean, hand-tied arrangement ready for checkout.',
                        style: AppTextStyles.body(
                          12,
                          color: AppColors.textMuted,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFFFF3377), Color(0xFFFF6B9D)],
                        ).createShader(bounds),
                        child: Text(
                          price,
                          style: AppTextStyles.heading(22, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 18),
                      GlassContainer(
                        borderRadius: 18,
                        blur: 10,
                        fillAlpha: 0.65,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About $name', style: AppTextStyles.label(14)),
                            const SizedBox(height: 8),
                            Text(
                              'Brighten any space with their graceful petals and stunning variety of colors. Perfect for gifts, home decor, or special occasions, these timeless blooms add a touch of charm and sophistication wherever they are displayed.',
                              style: AppTextStyles.body(12, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Product Description',
                        style: AppTextStyles.label(13),
                      ),
                      const SizedBox(height: 14),
                      GlassContainer(
                        borderRadius: 18,
                        blur: 10,
                        fillAlpha: 0.6,
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.primaryPink
                                      .withValues(alpha: 0.12),
                                  child: const Icon(
                                    Icons.person_outline_rounded,
                                    size: 18,
                                    color: AppColors.primaryPink,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'J*********o',
                                  style: AppTextStyles.label(12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Variation: Orange',
                              style: AppTextStyles.body(10),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Depende kung 3 yan...................',
                              style: AppTextStyles.body(
                                11,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: List.generate(
                                3,
                                (index) => Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.softBorder.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                                  ),
                                  child: const ReliableNetworkImage(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=150',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      _QuantityActionCard(
                        name: name,
                        price: price,
                        imageUrl: imageUrl,
                      ),
                      const SizedBox(height: 22),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Trigger for Bottom Sheet Flow Sequence
  void _showVariantBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VariationBottomSheet(),
    );
  }
}

// ==========================================
// SCREEN 4 & 5: Bottom Sheet Flow (iPhone 17 - 5 & iPhone 17 - 3)
// ==========================================
class VariationBottomSheet extends StatefulWidget {
  const VariationBottomSheet({super.key});

  @override
  State<VariationBottomSheet> createState() => _VariationBottomSheetState();
}

class _VariationBottomSheetState extends State<VariationBottomSheet> {
  String selectedColor = 'Orange';
  int quantity = 3;
  int selectedBoxIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.7),
                    width: 1.2,
                  ),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.softBorder,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPink.withValues(
                                alpha: 0.15,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=200',
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Choose Color', style: AppTextStyles.label(13)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Orange', 'Red', 'Blue', 'Pink'].map((color) {
                      final isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFFFFF0F5),
                                      Color(0xFFFFE3EC),
                                    ],
                                  )
                                : null,
                            color: isSelected
                                ? null
                                : Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryPink
                                  : AppColors.softBorder.withValues(alpha: 0.8),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Text(
                            color,
                            style: AppTextStyles.label(
                              11,
                              color: isSelected
                                  ? AppColors.primaryPink
                                  : AppColors.textMuted,
                              weight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 22),
                  Text('Quantity', style: AppTextStyles.label(13)),
                  const SizedBox(height: 12),
                  GlassContainer(
                    borderRadius: 12,
                    blur: 8,
                    fillAlpha: 0.55,
                    padding: EdgeInsets.zero,
                    boxShadow: const [],
                    child: SizedBox(
                      width: 110,
                      height: 36,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                              child: Icon(
                                Icons.remove_rounded,
                                color: AppColors.textMuted.withValues(
                                  alpha: 0.8,
                                ),
                                size: 18,
                              ),
                            ),
                          ),
                          Text(
                            '$quantity',
                            style: AppTextStyles.label(
                              14,
                              color: AppColors.primaryPink,
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => setState(() => quantity++),
                              child: Icon(
                                Icons.add_rounded,
                                color: AppColors.textMuted.withValues(
                                  alpha: 0.8,
                                ),
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: _DetailActionButton(
                          icon: Icons.shopping_cart_outlined,
                          label: 'Add to Cart',
                          onTap: () => _showAddedToCartBottomSheet(
                            context,
                            name: 'Product',
                            price: 'Php. 0.00',
                            imageUrl:
                                'https://images.unsplash.com/photo-1526047932273-341f2a7631f9?w=200',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF3377), Color(0xFFFF5C8A)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryPink.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(0, 44),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Proceed to Check Out',
                                    style: AppTextStyles.label(
                                      10,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text('Flower Box', style: AppTextStyles.body(11)),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(3, (index) {
                      final isSelected = selectedBoxIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedBoxIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          margin: const EdgeInsets.only(right: 12),
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withValues(
                              alpha: isSelected ? 0.8 : 0.5,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryPink
                                  : AppColors.softBorder.withValues(alpha: 0.7),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppColors.primaryPink.withValues(
                                        alpha: 0.15,
                                      ),
                                      blurRadius: 10,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: index == 0
                                ? Colors.pink.shade200
                                : (index == 1 ? Colors.black : Colors.grey),
                            size: 32,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// SHARED COMPONENTS & NAVIGATION WRAPPER
// ==========================================
class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    _PlaceholderTab(title: 'Wishlist', icon: Icons.favorite_rounded),
    _PlaceholderTab(title: 'Orders', icon: Icons.inventory_2_outlined),
    _PlaceholderTab(title: 'Me', icon: Icons.person_outline_rounded),
  ];

  static const _navItems = [
    (Icons.home_rounded, 'Home'),
    (Icons.favorite_border_rounded, 'Wishlist'),
    (Icons.inventory_2_outlined, 'Orders'),
    (Icons.person_outline_rounded, 'Me'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: GlassContainer(
          borderRadius: 24,
          blur: 20,
          fillAlpha: 0.68,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_navItems.length, (index) {
              final isSelected = _selectedIndex == index;
              final (icon, label) = _navItems[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedIndex = index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 14 : 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFFFF3377), Color(0xFFFF5C8A)],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryPink.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        size: 22,
                        color: isSelected ? Colors.white : AppColors.textMuted,
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: AppTextStyles.label(11, color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return PremiumBackground(
      child: Center(
        child: GlassContainer(
          borderRadius: 24,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.primaryPink.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 12),
              Text(title, style: AppTextStyles.heading(18)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeMetricCard extends StatelessWidget {
  const _HomeMetricCard({required this.metric, this.onTap});

  final _HomeMetric metric;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: GlassContainer(
          borderRadius: 18,
          blur: 8,
          fillAlpha: 0.66,
          borderColor: AppColors.primaryPink.withValues(alpha: 0.12),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(metric.icon, color: AppColors.primaryPink, size: 18),
              const SizedBox(height: 10),
              Text(
                metric.value,
                style: AppTextStyles.label(12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                metric.label,
                style: AppTextStyles.body(
                  10,
                  color: AppColors.textMuted,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.label,
    required this.icon,
    this.isHighlighted = false,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isHighlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: isHighlighted
                ? const LinearGradient(
                    colors: [Color(0xFFFF3377), Color(0xFFFF5C8A)],
                  )
                : null,
            color: isHighlighted ? null : Colors.white.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: isHighlighted
                  ? Colors.transparent
                  : AppColors.primaryPink.withValues(alpha: 0.14),
            ),
            boxShadow: [
              BoxShadow(
                color: isHighlighted
                    ? AppColors.primaryPink.withValues(alpha: 0.22)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isHighlighted ? Colors.white : AppColors.primaryPink,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.label(
                  11,
                  color: isHighlighted ? Colors.white : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SparkleActionButton extends StatelessWidget {
  const _SparkleActionButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF3377), Color(0xFFFF7CA5)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPink.withValues(alpha: 0.22),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Stack(
            children: [
              Positioned(top: 8, left: 8, child: Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18)),
              Positioned(bottom: 6, right: 6, child: Icon(Icons.spa_rounded, color: Colors.white70, size: 8)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF1E1E1E), Color(0xFF3A3A3A)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: AppTextStyles.label(10, color: Colors.white),
                ),
                const SizedBox(width: 4),
                Icon(icon, size: 14, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SparkleCluster extends StatelessWidget {
  const _SparkleCluster({this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final baseSize = compact ? 12.0 : 16.0;
    return SizedBox(
      width: compact ? 42 : 60,
      height: compact ? 42 : 60,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 6,
            child: Icon(Icons.auto_awesome_rounded, size: baseSize, color: Colors.white),
          ),
          Positioned(
            right: 4,
            top: 10,
            child: Icon(Icons.brightness_1_rounded, size: compact ? 5 : 6, color: Colors.white70),
          ),
          Positioned(
            bottom: 2,
            left: compact ? 18 : 22,
            child: Container(
              width: compact ? 5 : 6,
              height: compact ? 5 : 6,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMetricChip extends StatelessWidget {
  const _MiniMetricChip({required this.metric, this.onTap});

  final _HomeMetric metric;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: AppColors.primaryPink.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(metric.icon, size: 13, color: AppColors.primaryPink),
              const SizedBox(width: 6),
              Text(
                metric.value,
                style: AppTextStyles.label(10, color: AppColors.textDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuantityActionCard extends StatefulWidget {
  const _QuantityActionCard({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String name;
  final String price;
  final String imageUrl;

  @override
  State<_QuantityActionCard> createState() => _QuantityActionCardState();
}

class _QuantityActionCardState extends State<_QuantityActionCard> {
  int _quantity = 1;

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(
          name: widget.name,
          price: widget.price,
          imageUrl: widget.imageUrl,
          quantity: _quantity,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 18,
      blur: 10,
      fillAlpha: 0.66,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.primaryPink,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text('Choose quantity', style: AppTextStyles.label(13)),
              const Spacer(),
              Text(
                '${widget.price} each',
                style: AppTextStyles.body(10, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GlassContainer(
                borderRadius: 12,
                blur: 8,
                fillAlpha: 0.58,
                padding: EdgeInsets.zero,
                boxShadow: const [],
                child: SizedBox(
                  width: 116,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _quantity > 1
                              ? () => setState(() => _quantity--)
                              : null,
                          child: const Center(
                            child: Icon(
                              Icons.remove_rounded,
                              size: 18,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '$_quantity',
                        style: AppTextStyles.label(
                          14,
                          color: AppColors.primaryPink,
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _quantity++),
                          child: const Center(
                            child: Icon(
                              Icons.add_rounded,
                              size: 18,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _DetailActionButton(
                  icon: Icons.shopping_cart_outlined,
                  label: 'Add to Cart',
                  outlined: true,
                  onTap: _openCart,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: _PrimaryActionButton(
              label: 'Buy Now',
              icon: Icons.chevron_right_rounded,
              onTap: _openCart,
            ),
          ),
        ],
      ),
    );
  }
}

class ReliableNetworkImage extends StatelessWidget {
  const ReliableNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFE0EA), Color(0xFFFFC0D3)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.local_florist_rounded,
              color: AppColors.primaryPink,
              size: 26,
            ),
          ),
        );
      },
    );
  }
}

class _DetailActionButton extends StatelessWidget {
  const _DetailActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.outlined = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: outlined
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: outlined
                  ? AppColors.primaryPink.withValues(alpha: 0.5)
                  : AppColors.softBorder.withValues(alpha: 0.6),
            ),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 14, color: AppColors.primaryPink),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: AppTextStyles.label(
                      11,
                      color: AppColors.primaryPink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Reusable Flower Item Card
Widget _buildFlowerCard(
  BuildContext context, {
  required String name,
  required String price,
  required String rating,
  required String imageUrl,
  VoidCallback? onTap,
}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      splashColor: AppColors.primaryPink.withValues(alpha: 0.08),
      child: GlassContainer(
        borderRadius: 20,
        blur: 14,
        fillAlpha: 0.62,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: ReliableNetworkImage(
                    imageUrl: imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: GlassContainer(
                    borderRadius: 999,
                    blur: 8,
                    fillAlpha: 0.6,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    boxShadow: const [],
                    child: Text(
                      'Tap to view',
                      style: AppTextStyles.label(9, color: AppColors.primaryPink),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.label(12)),
                  const SizedBox(height: 6),
                  Text(
                    'Fresh cut and ready to open.',
                    style: AppTextStyles.body(10, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 8),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFFF3377), Color(0xFFFF6B9D)],
                    ).createShader(bounds),
                    child: Text(
                      price,
                      style: AppTextStyles.label(12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void _showAddedToCartBottomSheet(
  BuildContext context, {
  required String name,
  required String price,
  required String imageUrl,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlassContainer(
          borderRadius: 16,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ReliableNetworkImage(
                      imageUrl: imageUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.label(
                            14,
                            weight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          price,
                          style: AppTextStyles.label(
                            12,
                            color: AppColors.primaryPink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryPink,
                        side: BorderSide(
                          color: AppColors.primaryPink.withValues(alpha: 0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Continue shopping',
                        style: AppTextStyles.label(
                          12,
                          color: AppColors.primaryPink,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.push(
                          ctx,
                          MaterialPageRoute(
                            builder: (_) => CartScreen(
                              name: name,
                              price: price,
                              imageUrl: imageUrl,
                              quantity: 1,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'View Cart',
                        style: AppTextStyles.label(12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });
  final String name;
  final String price;
  final String imageUrl;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.textDark),
        title: Text('Your Cart', style: AppTextStyles.heading(16)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GlassContainer(
              padding: const EdgeInsets.all(12),
              borderRadius: 12,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ReliableNetworkImage(
                      imageUrl: imageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: AppTextStyles.label(
                            14,
                            weight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Quantity: $quantity',
                          style: AppTextStyles.body(
                            11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    price,
                    style: AppTextStyles.label(
                      14,
                      color: AppColors.primaryPink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Text(
                  'More items will appear here',
                  style: AppTextStyles.body(12, color: AppColors.textMuted),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPink,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Proceed to Checkout',
                style: AppTextStyles.label(14, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
