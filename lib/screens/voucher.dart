import 'package:flutter/material.dart';
import '../screens/wallet_data.dart';

/// Halaman klaim voucher (dibuka dari beranda).
/// Voucher hanya bisa diklaim SEKALI dan langsung masuk ke Profil > Voucher Saya.
class VoucherClaimScreen extends StatelessWidget {
  const VoucherClaimScreen({super.key});

  static const Color _red = Color(0xFFB71C1C);

  void _claim(BuildContext context, VoucherItem v) {
    final ok = WalletData.instance.claimVoucher(v);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Voucher berhasil diklaim. Cek di Profil > Voucher Saya.'
              : 'Voucher ini sudah pernah kamu klaim.',
        ),
        backgroundColor: _red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: _red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Voucher',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: ListenableBuilder(
        listenable: WalletData.instance,
        builder: (context, _) {
          const vouchers = WalletData.catalog;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: vouchers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) => _voucherCard(context, vouchers[i]),
          );
        },
      ),
    );
  }

  Widget _voucherCard(BuildContext context, VoucherItem v) {
    final claimed = WalletData.instance.isClaimed(v.id);

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
            Container(
              width: 70,
              color: claimed ? Colors.grey.shade500 : _red,
              alignment: Alignment.center,
              child: const Icon(
                Icons.confirmation_number,
                color: Colors.white,
                size: 30,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            v.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            v.desc,
                            style: const TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            v.valid,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed: claimed ? null : () => _claim(context, v),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _red,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFFE0E0E0),
                          disabledForegroundColor: Colors.grey,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          claimed ? 'Diklaim' : 'Klaim',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
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
