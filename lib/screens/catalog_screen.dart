import 'package:flutter/material.dart';
import '../widgets/product_image.dart';
import '../data/app_data.dart';
import '../models/product.dart';
import '../widgets/cart_button.dart';

class CatalogScreen extends StatefulWidget {
  final Function(Product) onProductTap;
  final void Function(Product, int) onAddToCart;
  final int cartCount;
  final VoidCallback onCartTap;

  const CatalogScreen({
    super.key,
    required this.onProductTap,
    required this.onAddToCart,
    required this.cartCount,
    required this.onCartTap,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static const red = Color(0xFFB71C1C);

  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'Semua';
  String searchQuery = '';
  String sortBy = 'Terbaru';

  final categories = const [
    {'name': 'Semua', 'icon': Icons.apps},
    {'name': 'Oli', 'icon': Icons.opacity},
    {'name': 'Ban', 'icon': Icons.trip_origin},
    {'name': 'Rem', 'icon': Icons.speed},
    {'name': 'Aki', 'icon': Icons.battery_charging_full},
    {'name': 'Busi', 'icon': Icons.flash_on},
    {'name': 'Filter', 'icon': Icons.filter_alt},
    {'name': 'Rantai', 'icon': Icons.link},
    {'name': 'Lampu', 'icon': Icons.lightbulb_outline},
  ];

  final sortOptions = const ['Terbaru', 'Harga Terendah', 'Harga Tertinggi'];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  List<Product> get filteredProducts {
    final list = AppData.products.where((product) {
      final categoryMatch =
          selectedCategory == 'Semua' || product.category == selectedCategory;
      final searchMatch =
          product.name.toLowerCase().contains(searchQuery.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();

    if (sortBy == 'Harga Terendah') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'Harga Tertinggi') {
      list.sort((a, b) => b.price.compareTo(a.price));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final products = filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Katalog Sparepart',
          style: TextStyle(color: red, fontWeight: FontWeight.bold),
        ),
        actions: [
          CartButton(count: widget.cartCount, onTap: widget.onCartTap),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        children: [
          // ===== HEADER TETAP (tidak ikut scroll) =====
          _buildFixedHeader(),

          // ===== INFO JUMLAH + URUTKAN =====
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${products.length} produk ditemukan',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  initialValue: sortBy,
                  onSelected: (value) => setState(() => sortBy = value),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (_) => sortOptions
                      .map((e) => PopupMenuItem(value: e, child: Text(e)))
                      .toList(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.swap_vert, size: 18, color: red),
                        const SizedBox(width: 4),
                        Text(
                          sortBy,
                          style: const TextStyle(
                            fontSize: 12,
                            color: red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== DAFTAR PRODUK (hanya bagian ini yang scroll) =====
          Expanded(
            child: products.isEmpty
                ? _buildEmpty()
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductItem(product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) => setState(() => searchQuery = value),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Cari produk sparepart...',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: red),
              suffixIcon: searchQuery.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () {
                        searchController.clear();
                        setState(() => searchQuery = '');
                      },
                    ),
              filled: true,
              fillColor: const Color(0xFFF3F3F3),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final name = categories[index]['name'] as String;
                final icon = categories[index]['icon'] as IconData;
                final selected = selectedCategory == name;

                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: selected ? red : const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 16,
                          color: selected ? Colors.white : Colors.grey[700],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _quickAdd(Product product) {
    widget.onAddToCart(product, 1);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Text('${product.name} ditambahkan ke keranjang'),
          action: SnackBarAction(
            label: 'Lihat',
            textColor: Colors.white,
            onPressed: widget.onCartTap,
          ),
        ),
      );
  }

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () => widget.onProductTap(product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: ProductImage(path: product.image, fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          formatPrice(product.price),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _quickAdd(product),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_off, size: 48, color: red),
          ),
          const SizedBox(height: 16),
          const Text(
            'Produk tidak ditemukan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            selectedCategory != 'Semua'
                ? 'Tidak ada hasil di kategori $selectedCategory'
                : 'Coba kata kunci atau kategori lain',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          if (selectedCategory != 'Semua') ...[
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () => setState(() => selectedCategory = 'Semua'),
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cari di semua kategori'),
            ),
          ],
        ],
      ),
    );
  }
}