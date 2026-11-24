import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';
import '../widgets/cart_button.dart';
import '../screens/promo_screen.dart';
import '../screens/voucher.dart';
import '../screens/qr_screen.dart';
import '../screens/wallet_data.dart';
import 'profile/pitstop_pay_screen.dart';
import 'profile/points_screen.dart';

class HomeScreen extends StatefulWidget {
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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color _red = Color(0xFFB71C1C);
  static const Color _bg = Color(0xFFF7F7F7);

  void _openPromo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PromoScreen()),
    );
  }

  void _openVoucher() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VoucherClaimScreen()),
    );
  }

  void _openQr() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const QrPayScreen()),
    );
  }

  void _openPay() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PitStopPayScreen()),
    );
  }

  void _openPoints() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PointsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendCount = math.min(4, AppData.products.length);

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER: lokasi + bantuan + notifikasi + keranjang
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 8, 12),
                child: _buildHeader(),
              ),

              // 2. BANNER PROMO (1 saja, tetap) + KOLOM PENCARIAN
              _buildBannerWithSearch(),

              // jarak untuk pencarian yang menjorok keluar banner
              const SizedBox(height: 44),

              // 3. KARTU POIN / REWARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListenableBuilder(
                  listenable: WalletData.instance,
                  builder: (context, _) => _buildRewardCard(),
                ),
              ),

              const SizedBox(height: 18),

              // 4. KATEGORI + 5. REKOMENDASI SPAREPART
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      title: 'Kategori Layanan',
                      onTap: widget.onCatalogTap,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _category(
                            Icons.settings, 'Sparepart', widget.onCatalogTap),
                        _category(Icons.local_offer, 'Promo', _openPromo),
                        _category(Icons.card_giftcard, 'Voucher', _openVoucher),
                      ],
                    ),
                    SectionTitle(
                      title: 'Rekomendasi Sparepart',
                      onTap: widget.onCatalogTap,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recommendCount,
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
                          onTap: () => widget.onProductTap(product),
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HEADER
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Row(
      children: [
        // Pill lokasi
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, color: _red, size: 22),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Kab. Cianjur, Jawa Barat',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6),
        _circleIcon(Icons.help_outline, onTap: () {}),
        _circleIcon(Icons.notifications, onTap: () {}),
        CartButton(count: widget.cartCount, onTap: widget.onCartTap),
      ],
    );
  }

  Widget _circleIcon(IconData icon, {required VoidCallback onTap}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: _red),
    );
  }

  // ---------------------------------------------------------------------------
  // BANNER (tetap, 1 saja) + PENCARIAN
  // ---------------------------------------------------------------------------
  Widget _buildBannerWithSearch() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // banner = anak biasa (punya ukuran), jadi Stack tidak error
        _buildBanner(),
        // pencarian menjorok keluar dari bawah banner
        Positioned(
          left: 16,
          right: 16,
          bottom: -26,
          child: _buildSearch(),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 190,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB71C1C), Color(0xFFEF5350)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: 10,
            child: Icon(
              Icons.two_wheeler,
              size: 150,
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 44),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bayar Lebih Hemat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Cicil Sekarang!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pembayaran via QRIS & kartu kredit\nsesuai ketentuan bank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // KOLOM PENCARIAN
  // ---------------------------------------------------------------------------
  Widget _buildSearch() {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(14),
      shadowColor: Colors.black26,
      child: TextField(
        onSubmitted: (_) => widget.onCatalogTap(),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Cari sparepart, oli, ban, dan lainnya...',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: _red, size: 28),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // KARTU REWARD: PitStop Pay | Level + Poin | Scan QR + strip voucher
  // ---------------------------------------------------------------------------
  Widget _buildRewardCard() {
    final wallet = WalletData.instance;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // baris atas
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // PitStop Pay (tap -> halaman PitStop Pay)
                  InkWell(
                    onTap: _openPay,
                    borderRadius: BorderRadius.circular(8),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_balance_wallet,
                              color: _red, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'PitStop Pay',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        wallet.payActive ? wallet.saldoText : 'Aktifkan',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Level + poin
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Level',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(width: 18),
                              Icon(Icons.chevron_right,
                                  color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: _openPoints,
                          child: Row(
                          children: [
                            CircleAvatar(
                              radius: 11,
                              backgroundColor: _red,
                              child: Icon(Icons.stars,
                                  color: Colors.white, size: 14),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${wallet.points} Poin',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // garis pemisah
                  Container(
                    width: 1,
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),

                  // Scan QR -> halaman QR Bayar
                  InkWell(
                    onTap: _openQr,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner, color: _red, size: 34),
                          SizedBox(height: 4),
                          Text(
                            'Scan QR',
                            style: TextStyle(color: _red, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // strip merah: klaim voucher
          InkWell(
            onTap: _openVoucher,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC62828), Color(0xFFB71C1C)],
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.confirmation_number,
                      color: Color(0xFFFFCA28), size: 22),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Klaim rewards voucher menarik disini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_double_arrow_right,
                      color: Colors.white, size: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ITEM KATEGORI
  // ---------------------------------------------------------------------------
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
            child: Icon(icon, color: _red, size: 27),
          ),
          const SizedBox(height: 7),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
