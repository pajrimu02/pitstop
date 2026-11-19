import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/order.dart';
import '../models/product.dart';
import '../widgets/curved_bottom_nav.dart';
import '../screens/home_screen.dart';
import '../screens/activity_screen.dart';
import '../screens/catalog_screen.dart';
import 'profile/profile_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  /// productId -> jumlah
  final Map<int, int> cart = {};

  void openProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
          onAddToCart: addToCart,
        ),
      ),
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          cart: cart,
          onChangeQty: changeQty,
          onRemove: removeFromCart,
          onCheckout: checkout,
        ),
      ),
    );
  }

  void addToCart(Product product, int quantity) {
    setState(() {
      cart[product.id] = (cart[product.id] ?? 0) + quantity;
    });
  }

  void changeQty(int productId, int delta) {
    setState(() {
      final newQty = (cart[productId] ?? 0) + delta;
      if (newQty <= 0) {
        cart.remove(productId);
      } else {
        cart[productId] = newQty;
      }
    });
  }

  void removeFromCart(int productId) {
    setState(() => cart.remove(productId));
  }

  String _today() {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    final now = DateTime.now();
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  void checkout() {
    if (cart.isEmpty) return;

    for (final entry in cart.entries) {
      final product = AppData.products.firstWhere((p) => p.id == entry.key);
      final qty = entry.value;

      AppData.orders.insert(
        0,
        Order(
          name: qty > 1 ? '${product.name} (x$qty)' : product.name,
          date: _today(),
          price: product.price * qty,
          status: 'Masih di PO',
          image: product.image,
        ),
      );
    }

    setState(() {
      cart.clear();
      selectedIndex = 1; // pindah ke tab Aktivitas
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Pesanan berhasil dibuat!')),
      );
  }

  int get cartCount {
    return cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        onProductTap: openProduct,
        onCatalogTap: () => changePage(2),
        cartCount: cartCount,
        onCartTap: openCart,
      ),
      ActivityScreen(),
      CatalogScreen(
        onProductTap: openProduct,
        onAddToCart: addToCart,
        cartCount: cartCount,
        onCartTap: openCart,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: CurvedBottomNav(
        currentIndex: selectedIndex,
        onTap: changePage,
        activeColor: const Color(0xFFB71C1C),
        items: const [
          CurvedNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: 'Beranda',
          ),
          CurvedNavItem(
            icon: Icons.receipt_long_outlined,
            activeIcon: Icons.receipt_long_rounded,
            label: 'Aktivitas',
          ),
          CurvedNavItem(
            icon: Icons.storefront_outlined,
            activeIcon: Icons.storefront_rounded,
            label: 'Katalog',
          ),
          CurvedNavItem(
            icon: Icons.person_outline_rounded,
            activeIcon: Icons.person_rounded,
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
