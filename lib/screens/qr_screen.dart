import 'package:flutter/material.dart';

/// Halaman QR Bayar: menampilkan gambar QR (PNG) milik kamu.
class QrPayScreen extends StatelessWidget {
  const QrPayScreen({super.key});

  static const Color _red = Color(0xFFB71C1C);

  /// Lokasi file QR. Ganti jika nama / foldernya berbeda.
  /// Pastikan folder ini sudah didaftarkan di pubspec.yaml (bagian assets).
  static const String qrAsset = 'assets/images/qr/qr_bayar.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: _red,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'QR Bayar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Scan QR di bawah ini untuk membayar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    qrAsset,
                    width: 270,
                    height: 270,
                    fit: BoxFit.contain,
                    // Kalau file belum ada, tampilkan pengganti (tidak crash)
                    errorBuilder: (context, error, stack) => Container(
                      width: 270,
                      height: 270,
                      color: const Color(0xFFF2F2F2),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.qr_code_2, size: 80, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            'Gambar QR belum ditambahkan.\n'
                            'Taruh file PNG di:\n$qrAsset',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'PitStop Pay',
                  style: TextStyle(
                    color: _red,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tunjukkan QR ini ke kasir atau\nscan lewat aplikasi pembayaranmu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
