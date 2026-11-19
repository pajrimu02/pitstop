import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Tentang Aplikasi',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 44,
              backgroundColor: Color(0xFFFFEBEE),
              child: Icon(Icons.two_wheeler, color: red, size: 46),
            ),
            SizedBox(height: 16),
            Text(
              'PitStop',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: red,
              ),
            ),
            Text(
              'Versi 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 24),
            Text(
              'PitStop adalah aplikasi layanan booking servis motor dan pembelian sparepart terlengkap untuk memudahkan perawatan kendaraan harian Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
      ),
    );
  }
}