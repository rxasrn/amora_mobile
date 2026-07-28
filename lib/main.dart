import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const AmoraDaffodilsApp());
}

class AmoraDaffodilsApp extends StatelessWidget {
  const AmoraDaffodilsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amora Daffodils',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFFFF9F9),
        primaryColor: const Color(0xFFFF3377),
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
    imageUrl: 'https://images.unsplash.com/photo-1597848212624-a19eb35e2651?w=300',
    category: 'sunflower',
  ),
  _FlowerProduct(
    name: 'Tulips',
    price: 'Php. 125.00',
    rating: '4.5',
    imageUrl: 'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=300',
    category: 'tulip',
  ),
  _FlowerProduct(
    name: 'Red Rose',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=300',
    category: 'rose',
  ),
  _FlowerProduct(
    name: 'Stargazer Lilies',
    price: 'Php. 125.00',
    rating: '4.5',
    imageUrl: 'https://images.unsplash.com/photo-1582794543139-8ac9cb0f7b11?w=300',
    category: 'lily',
  ),
  _FlowerProduct(
    name: 'Lavander',
    price: 'Php. 135.00',
    rating: '4.5',
    imageUrl: 'https://images.unsplash.com/photo-1528722828814-77b9b83aafb2?w=300',
    category: 'lavender',
  ),
];

void _openFlowerOverview(BuildContext context, {required String name, required String price, required String imageUrl, required String rating}) {
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
  late List<_FlowerProduct> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = List<_FlowerProduct>.from(_flowerProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_FlowerProduct> _filterProducts(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return List<_FlowerProduct>.from(_flowerProducts);
    }

    return _flowerProducts.where((product) {
      final matchesName = product.name.toLowerCase().contains(normalized);
      final matchesCategory = product.category.toLowerCase().contains(normalized);
      return matchesName || matchesCategory;
    }).toList();
  }

  void _updateSearch(String value) {
    setState(() {
      _filteredProducts = _filterProducts(value);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _updateSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD8E4),
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1526047932273-341f2a7631f9?w=150'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.textMuted, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              textInputAction: TextInputAction.search,
                              onChanged: _updateSearch,
                              cursorColor: AppColors.primaryPink,
                              style: const TextStyle(color: AppColors.textDark, fontSize: 13),
                              decoration: const InputDecoration(
                                hintText: 'Search flowers here',
                                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _updateSearch(_searchController.text),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.primaryPink,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.search, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.notifications_none_outlined, color: AppColors.textMuted, size: 26),
                  const SizedBox(width: 8),
                  const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textMuted, size: 24),
                ],
              ),

              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFE3EC), Color(0xFFFFC2D6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 20,
                      top: 25,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Amora ',
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                                ),
                                TextSpan(
                                  text: 'Special',
                                  style: TextStyle(fontSize: 22, fontStyle: FontStyle.italic, color: AppColors.primaryPink),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Customisable flower\narrangements!',
                            style: TextStyle(fontSize: 11, color: AppColors.textDark, height: 1.3),
                          ),
                          const SizedBox(height: 14),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.textDark,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Row(
                              children: const [
                                Text('Shop Now', style: TextStyle(fontSize: 10, color: Colors.white)),
                                SizedBox(width: 4),
                                Icon(Icons.chevron_right, size: 12, color: Colors.white),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      bottom: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1563241527-3004b7be0ffd?w=300',
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 20, height: 4, decoration: BoxDecoration(color: AppColors.primaryPink, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  Container(width: 12, height: 4, decoration: BoxDecoration(color: const Color(0xFFFFD1E1), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 4),
                  Container(width: 12, height: 4, decoration: BoxDecoration(color: const Color(0xFFFFD1E1), borderRadius: BorderRadius.circular(2))),
                ],
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Flowers',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  GestureDetector(
                    onTap: _clearSearch,
                    child: Row(
                      children: const [
                        Text('View All', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              if (_filteredProducts.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.search_off_outlined, color: AppColors.textMuted, size: 32),
                      SizedBox(height: 8),
                      Text('No flowers match that search yet.', style: TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                )
              else
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    for (final product in _filteredProducts)
                      _buildFlowerCard(
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
                  ],
                ),
              const SizedBox(height: 20),
            ],
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
      final matchesCategory = product.category.toLowerCase().contains(normalized);
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
      backgroundColor: AppColors.lightBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back, color: AppColors.primaryPink),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primaryPink.withValues(alpha: 0.25), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: AppColors.textMuted, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              autofocus: true,
                              textInputAction: TextInputAction.search,
                              onChanged: _updateQuery,
                              cursorColor: AppColors.primaryPink,
                              style: const TextStyle(color: AppColors.textDark, fontSize: 14),
                              decoration: const InputDecoration(
                                hintText: 'Search flowers',
                                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
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
                              child: const Icon(Icons.close, color: AppColors.textMuted, size: 18),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.filter_list, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text('Filter', style: TextStyle(color: Colors.white, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInOutCubic,
                  child: _filteredProducts.isEmpty
                      ? Container(
                          key: const ValueKey('empty'),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.search_off_outlined, size: 40, color: AppColors.textMuted),
                              SizedBox(height: 10),
                              Text('No flowers match that search yet.', style: TextStyle(color: AppColors.textMuted)),
                            ],
                          ),
                        )
                      : GridView.count(
                          key: ValueKey(_searchController.text),
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          children: [
                            for (final product in _filteredProducts)
                              _buildFlowerCard(
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
                          ],
                        ),
                ),
              ),
            ],
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
  const ProductDetailsScreen({super.key, required this.name, required this.price, required this.imageUrl, required this.rating});

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
                // Top Image Container with translucent search overlay
                Stack(
                  children: [
                    Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                    // Glassmorphic Top Bar Overlay
                    Positioned(
                      top: 40,
                      left: 16,
                      right: 16,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.white.withValues(alpha: 0.3),
                            child: Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(999),
                                    onTap: () => Navigator.pop(context),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.arrow_back, color: AppColors.primaryPink),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: AppColors.primaryPink),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(name, style: const TextStyle(fontSize: 12, color: AppColors.textDark)),
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

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          ...List.generate(4, (_) => const Icon(Icons.star, color: AppColors.starYellow, size: 16)),
                          const Icon(Icons.star_half, color: AppColors.starYellow, size: 16),
                          const SizedBox(width: 6),
                          Text(rating, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                          const Text(' (232 reviews)', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        price,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryPink),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'About $name',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Brighten any space with their graceful petals and stunning variety of colors. Perfect for gifts, home decor, or special occasions, these timeless blooms add a touch of charm and sophistication wherever they are displayed.',
                        style: TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.4),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Color(0xFFF0F0F0)),
                      const SizedBox(height: 10),
                      const Text('Product Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      const SizedBox(height: 16),

                      // User Review Item
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primaryPink.withValues(alpha: 0.1),
                            child: const Icon(Icons.person_outline, size: 16, color: AppColors.primaryPink),
                          ),
                          const SizedBox(width: 8),
                          const Text('J*********o', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (_) => const Icon(Icons.star, color: AppColors.starYellow, size: 12)),
                      ),
                      const SizedBox(height: 2),
                      const Text('Variation: Orange', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                      const SizedBox(height: 6),
                      const Text('Depende kung 3 yan...................', style: TextStyle(fontSize: 11, color: AppColors.textDark)),
                      const SizedBox(height: 8),

                      // Review Thumbnails
                      Row(
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: NetworkImage('https://images.unsplash.com/photo-1520763185298-1b434c919102?w=150'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100), // Spacing for bottom bar
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Translucent Bottom Action Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.white.withValues(alpha: 0.75),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chat is ready to start.'))),
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.send_outlined, size: 14, color: AppColors.primaryPink),
                                      SizedBox(width: 4),
                                      Text('Chat Now', style: TextStyle(fontSize: 11, color: AppColors.primaryPink, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart.'))),
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.primaryPink),
                              ),
                              child: const Center(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.shopping_cart_outlined, size: 14, color: AppColors.primaryPink),
                                      SizedBox(width: 4),
                                      Text('Add to Cart', style: TextStyle(fontSize: 11, color: AppColors.primaryPink, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showVariantBottomSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPink,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.shopping_bag_outlined, size: 14, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text('Buy Now', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
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
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected Flower Thumbnail Section (iPhone 17 - 5 View)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1520763185298-1b434c919102?w=200',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Color Selection
          const Text('Choose Color', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Orange', 'Red', 'Blue', 'Pink'].map((color) {
              final isSelected = selectedColor == color;
              return GestureDetector(
                onTap: () => setState(() => selectedColor = color),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFF0F5) : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: isSelected ? AppColors.primaryPink : Colors.grey.shade300),
                  ),
                  child: Text(
                    color,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? AppColors.primaryPink : AppColors.textMuted,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Quantity Adjuster
          const Text('Quantity', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(height: 10),
          Container(
            width: 100,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                    child: const Center(child: Text('-', style: TextStyle(color: AppColors.textMuted))),
                  ),
                ),
                Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryPink, fontSize: 13)),
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => quantity++),
                    child: const Center(child: Text('+', style: TextStyle(color: AppColors.textMuted))),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons inside Bottom Sheet
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 14, color: AppColors.primaryPink),
                          SizedBox(width: 4),
                          Text('Add to Cart', style: TextStyle(fontSize: 11, color: AppColors.primaryPink, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    minimumSize: const Size(0, 42),
                  ),
                  child: const Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.shopping_bag, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Proceed to Check Out', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Text('Flower Box', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
          const SizedBox(height: 8),

          // Flower Box Selection Thumbnails
          Row(
            children: List.generate(3, (index) {
              final isSelected = selectedBoxIndex == index;
              return GestureDetector(
                onTap: () => setState(() => selectedBoxIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryPink : Colors.grey.shade300,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: index == 0 ? Colors.pink.shade200 : (index == 1 ? Colors.black : Colors.grey),
                    size: 32,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
        ],
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
    Center(child: Text('Wishlist')),
    Center(child: Text('Orders')),
    Center(child: Text('Me')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryPink,
        unselectedItemColor: AppColors.textMuted,
        selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _selectedIndex == 0 ? AppColors.primaryPink : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.home_rounded,
                color: _selectedIndex == 0 ? Colors.white : AppColors.textMuted,
              ),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          const BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Orders'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Me'),
        ],
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF2E8EC), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Heart Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, size: 14, color: AppColors.primaryPink),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.starYellow, size: 12),
                      const SizedBox(width: 2),
                      Text(rating, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      const Text(' (232 reviews)', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(price, style: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}