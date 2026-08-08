import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AmoraDaffodilsApp());
}

class AmoraDaffodilsApp extends StatelessWidget {
  const AmoraDaffodilsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = GoogleFonts.poppinsTextTheme();
    return MaterialApp(
      title: 'Amora Daffodils',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primaryPink,
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: base.apply(
          bodyColor: AppColors.textDark,
          displayColor: AppColors.textDark,
        ),
      ),
      home: const PremiumBackground(child: MainNavigationWrapper()),
    );
  }
}

// ------------------
// Colors & Data
// ------------------
class AppColors {
  static const Color primaryPink = Color(0xFFFF3377);
  static const Color lightBg = Color(0xFFFFF9F9);
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1E1E1E);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color starYellow = Color(0xFFFFC107);
  static const Color softBorder = Color(0xFFFFD6E5);

  static Color glassFill([double alpha = 0.6]) =>
      Colors.white.withValues(alpha: alpha);
  static Color glassBorder([double alpha = 0.55]) =>
      Colors.white.withValues(alpha: alpha);
  static const Color secondaryPink = Color(0xFFFF9BC0);
  static LinearGradient pinkGradient([double a = 1.0, double b = 1.0]) =>
      LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryPink.withValues(alpha: a),
          secondaryPink.withValues(alpha: b),
        ],
      );
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
    imageUrl: 'https://images.unsplash.com/photo-1560717845-968823efbee1?w=800',
    category: 'flower',
  ),
  _FlowerProduct(
    name: 'Sunflower',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=800',
    category: 'sunflower',
  ),
  _FlowerProduct(
    name: 'Tulips',
    price: 'Php. 125.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=800',
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
        'https://images.unsplash.com/photo-1582794543139-8ac9cb0f7b11?w=800',
    category: 'lily',
  ),
  _FlowerProduct(
    name: 'Lavender',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl:
        'https://images.unsplash.com/photo-1528722828814-77b9b83aafb2?w=800',
    category: 'lavender',
  ),
];

// ------------------
// Visual helpers
// ------------------
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding,
    this.margin,
  });
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.glassFill(0.62),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: AppColors.glassBorder(0.5), width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPink.withValues(alpha: 0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

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
      duration: const Duration(seconds: 9),
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
              decoration: BoxDecoration(
                gradient: AppColors.pinkGradient(0.06, 0.02),
              ),
            ),
            Positioned(
              top: -80 + 40 * t,
              right: -40,
              child: _GlowOrb(
                size: 260,
                color: AppColors.primaryPink.withValues(alpha: 0.12 + t * 0.05),
              ),
            ),
            Positioned(
              top: 240 - 50 * t,
              left: -100,
              child: _GlowOrb(
                size: 220,
                color: const Color(0xFFFFC2D6).withValues(alpha: 0.16),
              ),
            ),
            Positioned(
              bottom: -20 + 50 * t,
              right: -30,
              child: _GlowOrb(
                size: 140,
                color: AppColors.softBorder.withValues(alpha: 0.2),
              ),
            ),
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
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}

class _SparklesPainter extends CustomPainter {
  _SparklesPainter(this.t);

  final double t;

  static const _positions = [
    Offset(0.12, 0.18),
    Offset(0.32, 0.08),
    Offset(0.48, 0.24),
    Offset(0.68, 0.14),
    Offset(0.88, 0.22),
    Offset(0.16, 0.62),
    Offset(0.42, 0.52),
    Offset(0.72, 0.48),
    Offset(0.84, 0.72),
    Offset(0.22, 0.86),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var i = 0; i < _positions.length; i++) {
      final pos = Offset(
        _positions[i].dx * size.width,
        _positions[i].dy * size.height,
      );
      final phase = (i * 0.17) % 1.0;
      final flicker = (0.5 + 0.5 * math.sin((t + phase) * 2 * math.pi));
      final radius = 1.8 + flicker * 2.8;
      paint.color = Colors.white.withValues(alpha: 0.08 + flicker * 0.12);
      canvas.drawCircle(pos, radius + 2.0 * flicker, paint);
      paint.color = Colors.white.withValues(alpha: 0.45 + flicker * 0.35);
      canvas.drawCircle(pos, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklesPainter oldDelegate) =>
      oldDelegate.t != t;
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
              colors: [Color(0xFFFFF0F5), Color(0xFFFFD5E3)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.primaryPink,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}

// ------------------
// Navigation
// ------------------
class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});
  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    Center(child: Text('Wishlist')),
    Center(child: Text('Orders')),
    Center(child: Text('Me')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: GlassContainer(
          borderRadius: 28,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: EdgeInsets.symmetric(
                    horizontal: _selectedIndex == 0 ? 14 : 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: _selectedIndex == 0
                        ? const LinearGradient(
                            colors: [Color(0xFFFF3377), Color(0xFFFF9BC0)],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        size: 20,
                        color: _selectedIndex == 0
                            ? Colors.white
                            : AppColors.textMuted,
                      ),
                      if (_selectedIndex == 0) ...[
                        const SizedBox(width: 8),
                        Text('Home', style: TextStyle(color: Colors.white)),
                      ],
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 1),
                child: Icon(
                  Icons.favorite_border,
                  color: _selectedIndex == 1
                      ? AppColors.primaryPink
                      : AppColors.textMuted,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 2),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: _selectedIndex == 2
                      ? AppColors.primaryPink
                      : AppColors.textMuted,
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = 3),
                child: Icon(
                  Icons.person_outline,
                  color: _selectedIndex == 3
                      ? AppColors.primaryPink
                      : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // old nav icon helper removed; using custom pill-style navigation
}

// ------------------
// Home Screen
// ------------------
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

  @override
  void initState() {
    super.initState();
    _filteredProducts = List<_FlowerProduct>.from(_flowerProducts);
    _searchController.addListener(() => _updateSearch(_searchController.text));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<_FlowerProduct> _filterProducts(String q) {
    final normalized = q.trim().toLowerCase();
    if (normalized.isEmpty) return List<_FlowerProduct>.from(_flowerProducts);
    return _flowerProducts
        .where(
          (p) =>
              p.name.toLowerCase().contains(normalized) ||
              p.category.toLowerCase().contains(normalized),
        )
        .toList();
  }

  void _updateSearch(String q) =>
      setState(() => _filteredProducts = _filterProducts(q));

  void _scrollToTrending() {
    final target = _trendingKey.currentContext;
    if (target != null) {
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 320),
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

  void _openDetails(_FlowerProduct p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(
          name: p.name,
          price: p.price,
          imageUrl: p.imageUrl,
          rating: p.rating,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _SparkleActionButton(
                    onTap: () {
                      _searchController.clear();
                      _updateSearch('');
                      _scrollToTrending();
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GlassContainer(
                      borderRadius: 28,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      child: SizedBox(
                        height: 42,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: AppColors.textMuted,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                textInputAction: TextInputAction.search,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Search flowers',
                                  hintStyle: TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 14,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: AppColors.textDark,
                                    fontSize: 14,
                                  ),
                                ),
                                cursorColor: AppColors.primaryPink,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryPink,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _GlassActionIcon(
                    icon: Icons.notifications_none_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _GlassActionIcon(
                    icon: Icons.shopping_cart_outlined,
                    onTap: _openCart,
                  ),
                ],
              ),

              const SizedBox(height: 18),
              GestureDetector(
                onTap: _scrollToTrending,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  height: 188,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFE3EC), Color(0xFFFFC2D6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryPink.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      const Positioned(top: 12, left: 12, child: _SparkleCluster()),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Amora Special',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Clean layout, soft motion, and faster shopping.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textDark,
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 14),
                            ElevatedButton(
                              onPressed: _scrollToTrending,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.textDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Shop Now',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 14,
                                    color: Colors.white,
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
              ),

              const SizedBox(height: 10),
              // carousel indicator
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.primaryPink,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 18,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Flowers',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _updateSearch(''),
                    child: Row(
                      children: const [
                        Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(key: _trendingKey),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  for (final p in _filteredProducts)
                    _buildFlowerCard(p, onTap: () => _openDetails(p)),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------
// Product Details
// ------------------
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // hero image
                Stack(
                  children: [
                    Hero(
                      tag: name,
                      child: ReliableNetworkImage(
                        imageUrl: imageUrl,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 16,
                      right: 16,
                      child: GlassContainer(
                        borderRadius: 10,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(999),
                                onTap: () => Navigator.pop(context),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppColors.primaryPink,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                name,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _GlassActionIcon(
                              icon: Icons.shopping_cart_outlined,
                              onTap: () {
                                Navigator.push(
                                  context,
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
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A clean, hand-tied arrangement with soft motion and easy checkout.',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                            height: 1.4,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),
                      Text(
                        price,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryPink,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        'About $name',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Brighten any space with their graceful petals and stunning variety of colors. Perfect for gifts, home decor, or special occasions.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 18),
                      _QuantityPurchasePanel(
                        name: name,
                        price: price,
                        imageUrl: imageUrl,
                      ),
                      const SizedBox(height: 24),
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
}

// ------------------
// Flower card builder
// ------------------
Widget _buildFlowerCard(_FlowerProduct p, {VoidCallback? onTap}) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeOutCubic,
    builder: (context, t, child) => Opacity(
      opacity: t,
      child: Transform.translate(offset: Offset(0, (1 - t) * 8), child: child),
    ),
    child: _HoverCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.glassFill(0.72),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.softBorder.withValues(alpha: 0.7),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Hero(
                        tag: p.name,
                        child: ReliableNetworkImage(
                          imageUrl: p.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.82),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Tap to view',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 9,
                              color: AppColors.primaryPink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Fresh cut and ready to open.',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textMuted,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.price,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: AppColors.primaryPink,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
      ),
    ),
  );
}

class _HoverCard extends StatefulWidget {
  const _HoverCard({required this.child});
  final Widget child;
  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard>
    with SingleTickerProviderStateMixin {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    return MouseRegion(
      onEnter: (_) {
        if (isWeb) setState(() => _hover = true);
      },
      onExit: (_) {
        if (isWeb) setState(() => _hover = false);
      },
      child: AnimatedScale(
        scale: _hover ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              transform: Matrix4.translationValues(
                0.0,
                _hover ? -6.0 : 0.0,
                0.0,
              ),
              child: widget.child,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 260),
                  opacity: _hover ? 1.0 : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryPink.withValues(alpha: 0.06),
                          Colors.transparent,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: AppColors.primaryPink.withValues(alpha: 0.04),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparkleActionButton extends StatelessWidget {
  const _SparkleActionButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF3377), Color(0xFFFF9BC0)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPink.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}

class _GlassActionIcon extends StatelessWidget {
  const _GlassActionIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: GlassContainer(
          borderRadius: 12,
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: AppColors.textMuted, size: 20),
        ),
      ),
    );
  }
}

class _QuantityPurchasePanel extends StatefulWidget {
  const _QuantityPurchasePanel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  final String name;
  final String price;
  final String imageUrl;

  @override
  State<_QuantityPurchasePanel> createState() => _QuantityPurchasePanelState();
}

class _QuantityPurchasePanelState extends State<_QuantityPurchasePanel> {
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
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_bag_outlined,
                  color: AppColors.primaryPink, size: 18),
              const SizedBox(width: 8),
              Text('Choose quantity', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              GlassContainer(
                borderRadius: 12,
                padding: EdgeInsets.zero,
                child: SizedBox(
                  width: 104,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _quantity > 1 ? () => setState(() => _quantity--) : null,
                          child: const Center(child: Icon(Icons.remove_rounded, size: 18, color: AppColors.textMuted)),
                        ),
                      ),
                      Text('$_quantity', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryPink)),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _quantity++),
                          child: const Center(child: Icon(Icons.add_rounded, size: 18, color: AppColors.textMuted)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _openCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Add to Cart', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _openCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textDark,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Buy Now', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
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
        title: const Text('Your Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GlassContainer(
          borderRadius: 18,
          padding: const EdgeInsets.all(12),
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
                    Text(name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('Quantity: $quantity', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted)),
                    const SizedBox(height: 4),
                    Text(price, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryPink)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
