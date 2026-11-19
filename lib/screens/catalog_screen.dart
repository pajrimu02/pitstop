import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  final Function(Product) onProductTap;

  const CatalogScreen({
    super.key,
    required this.onProductTap,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String selectedCategory = 'Semua';
  String searchQuery = '';

  final categories = ['Semua', 'Oli', 'Ban', 'Rem', 'Aki'];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = AppData.products.where((product) {
      final categoryMatch = selectedCategory == 'Semua' ||
          product.category == selectedCategory;

      final searchMatch =
          product.name.toLowerCase().contains(searchQuery.toLowerCase());

      return categoryMatch && searchMatch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Katalog Sparepart',
          style: TextStyle(
            color: Color(0xFFB71C1C),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
              decoration: InputDecoration(
                hintText: 'Cari produk sparepart...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFB71C1C),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = selectedCategory == category;

                  return ChoiceChip(
                    label: Text(category),
                    selected: selected,
                    selectedColor: const Color(0xFFB71C1C),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                    onSelected: (_) {
                      setState(() => selectedCategory = category);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(
                      child: Text('Produk tidak ditemukan'),
                    )
                  : GridView.builder(
                      itemCount: filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return ProductCard(
                          product: product,
                          onTap: () => widget.onProductTap(product),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}