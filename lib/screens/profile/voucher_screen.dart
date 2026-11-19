import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);

    final vouchers = [
      {
        'title': 'Diskon Servis Berkala 30%',
        'desc': 'Maksimal potongan Rp50.000 untuk semua paket servis rutin.',
        'code': 'PITSTOP30',
        'valid': 'Berlaku s/d 31 Des 2026',
      },
      {
        'title': 'Potongan Ganti Oli Rp15.000',
        'desc': 'Minimal pembelian oli mesin Rp75.000 di seluruh bengkel.',
        'code': 'OLIHUMAT15',
        'valid': 'Berlaku s/d 30 Nov 2026',
      },
      {
        'title': 'Gratis Cek Kelistrikan & Rem',
        'desc': 'Khusus pengguna baru aplikasi PitStop.',
        'code': 'NEWPITSTOP',
        'valid': 'Berlaku s/d 31 Des 2026',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Voucher Saya',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vouchers.length,
        itemBuilder: (context, index) {
          final item = vouchers[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFFFCDD2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.card_giftcard, color: red),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item['desc']!,
                  style: const TextStyle(fontSize: 12.5, color: Colors.black54),
                ),
                const Divider(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kode: ${item['code']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: red,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          item['valid']!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: item['code']!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Kode ${item['code']} disalin!'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Salin',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}