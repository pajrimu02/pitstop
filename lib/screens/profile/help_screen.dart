import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);

    final faqs = [
      {
        'q': 'Bagaimana cara booking servis motor di PitStop?',
        'a':
            'Pilih menu Katalog di navigasi bawah, pilih layanan servis atau sparepart yang dibutuhkan, masukkan ke keranjang, lalu lakukan checkout.',
      },
      {
        'q': 'Bagaimana cara menggunakan kode voucher?',
        'a':
            'Buka menu Profil > Voucher Saya, tekan tombol Salin pada voucher yang tersedia, lalu gunakan saat transaksi.',
      },
      {
        'q': 'Apakah pesanan sparepart bisa dibatalkan?',
        'a':
            'Pesanan dengan status "Masih di PO" dapat dibatalkan dengan menghubungi layanan pelanggan PitStop.',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pertanyaan yang Sering Diajukan (FAQ)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 12),
          ...faqs.map(
            (faq) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                iconColor: red,
                collapsedIconColor: Colors.grey,
                title: Text(
                  faq['q']!,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      faq['a']!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Menghubungkan ke CS PitStop (0800-1-748786)...'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.headset_mic_outlined),
              label: const Text('Hubungi Customer Service'),
            ),
          ),
        ],
      ),
    );
  }
}