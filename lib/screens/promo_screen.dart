import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  static const Color _red = Color(0xFFB71C1C);

  // Data contoh. Nanti bisa diganti dengan data dari web / database.
  static const List<_Promo> _promos = [
    _Promo(
      title: 'Diskon Oli Mesin',
      desc: 'Potongan hingga 30% untuk semua oli mesin pilihan.',
      badge: '30%',
      period: 'Berlaku sampai 31 Des 2026',
      code: 'OLI30',
    ),
    _Promo(
      title: 'Gratis Ongkir',
      desc: 'Gratis ongkir untuk pembelian minimal Rp100.000.',
      badge: 'FREE',
      period: 'Berlaku sampai 15 Des 2026',
      code: 'ONGKIRGRATIS',
    ),
    _Promo(
      title: 'Paket Ganti Ban',
      desc: 'Beli 2 ban tubeless, hemat Rp50.000.',
      badge: '50RB',
      period: 'Berlaku sampai 20 Des 2026',
      code: 'BAN50',
    ),
    _Promo(
      title: 'Cashback Aki',
      desc: 'Cashback 10% untuk pembelian aki motor.',
      badge: '10%',
      period: 'Berlaku sampai 10 Jan 2027',
      code: 'AKI10',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: _red,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Promo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _promos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) => _promoCard(context, _promos[i]),
      ),
    );
  }

  Widget _promoCard(BuildContext context, _Promo p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Badge diskon
          Container(
            width: 92,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB71C1C), Color(0xFFEF5350)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_offer, color: Colors.white70, size: 20),
                const SizedBox(height: 6),
                Text(
                  p.badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.desc,
                    style: const TextStyle(
                      color: Color(0xFF616161),
                      fontSize: 12.5,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p.period,
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          p.code,
                          style: const TextStyle(
                            color: _red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: p.code));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Kode ${p.code} disalin'),
                              backgroundColor: _red,
                            ),
                          );
                        },
                        child: const Text(
                          'Salin Kode',
                          style: TextStyle(
                            color: _red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _Promo {
  final String title;
  final String desc;
  final String badge;
  final String period;
  final String code;

  const _Promo({
    required this.title,
    required this.desc,
    required this.badge,
    required this.period,
    required this.code,
  });
}
