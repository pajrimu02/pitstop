import 'package:flutter/material.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  int _points = 250;

  void _redeem(String rewardName, int cost) {
    if (_points < cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Poin kamu belum mencukupi.'),
          backgroundColor: Color(0xFFB71C1C),
        ),
      );
      return;
    }
    setState(() => _points -= cost);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Berhasil menukar $rewardName!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);

    final rewards = [
      {'name': 'Voucher Potongan Rp10.000', 'cost': 100},
      {'name': 'Gratis Cuci Motor Steam', 'cost': 150},
      {'name': 'Voucher Oli Mesin Rp25.000', 'cost': 250},
    ];

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
      body: Padding(
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
                    child: Icon(Icons.stars, color: Colors.orange, size: 32),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total PitStop Poin',
                        style: TextStyle(color: Colors.grey, fontSize: 12.5),
                      ),
                      Text(
                        '$_points Poin',
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
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final item = rewards[index];
                  final name = item['name'] as String;
                  final cost = item['cost'] as int;

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
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$cost Poin',
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
                          onPressed: () => _redeem(name, cost),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Tukar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}