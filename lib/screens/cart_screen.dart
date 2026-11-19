import 'package:flutter/material.dart';
import '../widgets/product_image.dart';
import '../data/app_data.dart';
import '../models/product.dart';

class CartScreen extends StatefulWidget {
  /// Map productId -> quantity (referensi yang sama dengan di MainScreen)
  final Map<int, int> cart;
  final void Function(int productId, int delta) onChangeQty;
  final void Function(int productId) onRemove;
  final VoidCallback onCheckout;

  const CartScreen({
    super.key,
    required this.cart,
    required this.onChangeQty,
    required this.onRemove,
    required this.onCheckout,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const red = Color(0xFFB71C1C);

  String formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    )}';
  }

  Product _productOf(int id) =>
      AppData.products.firstWhere((p) => p.id == id);

  int get totalItems =>
      widget.cart.values.fold(0, (sum, qty) => sum + qty);

  int get totalPrice => widget.cart.entries.fold(
        0,
        (sum, e) => sum + _productOf(e.key).price * e.value,
      );

  @override
  Widget build(BuildContext context) {
    final entries = widget.cart.entries.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Keranjang Saya',
          style: TextStyle(color: red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: red,
        elevation: 0,
      ),
      body: entries.isEmpty ? _buildEmpty() : _buildList(entries),
      bottomNavigationBar: entries.isEmpty ? null : _buildCheckoutBar(),
    );
  }

  Widget _buildList(List<MapEntry<int, int>> entries) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final product = _productOf(entries[index].key);
        final qty = entries[index].value;

        return Dismissible(
          key: ValueKey(product.id),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.only(right: 24),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: red,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.delete_outline, color: Colors.white),
          ),
          onDismissed: (_) {
            widget.onRemove(product.id);
            setState(() {});
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ProductImage(path: product.image, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.onRemove(product.id);
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        product.category,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              formatPrice(product.price * qty),
                              style: const TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _qtyStepper(product, qty),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _qtyStepper(Product product, int qty) {
    Widget btn(IconData icon, VoidCallback? onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: onTap == null ? Colors.grey.shade200 : const Color(0xFFFFEBEE),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
            color: onTap == null ? Colors.grey : red,
          ),
        ),
      );
    }

    return Row(
      children: [
        btn(
          Icons.remove,
          qty > 1
              ? () {
                  widget.onChangeQty(product.id, -1);
                  setState(() {});
                }
              : null,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$qty',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        btn(Icons.add, () {
          widget.onChangeQty(product.id, 1);
          setState(() {});
        }),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total ($totalItems barang)',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatPrice(totalPrice),
                    style: const TextStyle(
                      color: red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: widget.onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.all(26),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBEE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 56,
              color: red,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Keranjang masih kosong',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          const Text(
            'Yuk, tambahkan sparepart favoritmu',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Belanja Sekarang'),
          ),
        ],
      ),
    );
  }
}