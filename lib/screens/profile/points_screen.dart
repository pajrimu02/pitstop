import 'package:flutter/material.dart';
import '../../screens/wallet_data.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  static const List<_Reward> _rewards = [
    _Reward('Voucher Potongan Rp10.000', 100),
    _Reward('Gratis Cuci Motor Steam', 150),
    _Reward('Voucher Oli Mesin Rp25.000', 250),
  ];

  void _redeem(BuildContext context, _Reward r) {
    final ok = WalletData.instance.redeemReward(r.name, r.cost);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Berhasil menukar ${r.name}! Cek di Voucher Saya.'
              : 'Poin kamu belum mencukupi.',
        ),
        backgroundColor: ok ? null : const Color(0xFFB71C1C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Poin Saya',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: ListenableBuilder(
        listenable: WalletData.instance,
        builder: (context, _) {
          final points = WalletData.instance.points;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFFFFF1D6),
                        child:
                            Icon(Icons.stars, color: Colors.orange, size: 32),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total PitStop Poin',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.5),
                          ),
                          Text(
                            '$points Poin',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tukar Poin',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: _rewards.length,
                    itemBuilder: (context, index) {
                      final r = _rewards[index];
                      final enough = points >= r.cost;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${r.cost} Poin',
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _redeem(context, r),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: red,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor:
                                    const Color(0xFFE0E0E0),
                              ),
                              child: Text(enough ? 'Tukar' : 'Kurang'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Reward {
  final String name;
  final int cost;
  const _Reward(this.name, this.cost);
}
