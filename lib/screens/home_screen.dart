import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';
import '../widgets/cart_button.dart';

class HomeScreen extends StatelessWidget {
  final Function(Product) onProductTap;
  final VoidCallback onCatalogTap;
  final int cartCount;
  final VoidCallback onCartTap;

  const HomeScreen({
    super.key,
    required this.onProductTap,
    required this.onCatalogTap,
    required this.cartCount,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  const Icon(Icons.location_on, color: red),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lokasi Anda',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          'Kab. Cianjur, Jawa Barat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none),
                  ),
                  CartButton(count: cartCount, onTap: onCartTap),
                ],
              ),

              const SizedBox(height: 18),

              // BANNER PROMO
              Container(
                height: 165,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB71C1C), Color(0xFFEF5350)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      left: 18,
                      top: 23,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PitStop',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Servis & Sparepart\nTerlengkap',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Diskon hingga 30%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      right: 15,
                      bottom: 15,
                      child: Icon(
                        Icons.two_wheeler,
                        color: Colors.white,
                        size: 105,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SEARCH
              TextField(
                onSubmitted: (_) => onCatalogTap(),
                decoration: InputDecoration(
                  hintText: 'Cari sparepart, oli, ban, dan lainnya...',
                  prefixIcon: const Icon(Icons.search, color: red),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // REWARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFFFFF1D6),
                      child: Icon(Icons.stars, color: Colors.orange),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PitStop Rewards',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Kumpulkan poin setiap transaksi',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '0 Poin',
                      style: TextStyle(
                        color: red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // KATEGORI
              SectionTitle(
                title: 'Kategori Layanan',
                action: 'Lihat Semua',
                onTap: onCatalogTap,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _category(Icons.build, 'Servis', onCatalogTap),
                  _category(Icons.settings, 'Sparepart', onCatalogTap),
                  _category(Icons.local_offer, 'Promo', onCatalogTap),
                  _category(Icons.card_giftcard, 'Voucher', onCatalogTap),
                ],
              ),

              // REKOMENDASI
              SectionTitle(
                title: 'Rekomendasi Produk',
                onTap: onCatalogTap,
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = AppData.products[index];

                  return ProductCard(
                    product: product,
                    onTap: () => onProductTap(product),
                  );
                },
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _category(IconData icon, String name, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: const Color(0xFFB71C1C), size: 27),
          ),
          const SizedBox(height: 7),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}