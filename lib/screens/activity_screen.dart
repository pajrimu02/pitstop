
import 'package:flutter/material.dart';
import '../widgets/product_image.dart';
import '../data/app_data.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String selectedStatus = 'Semua';

  final List<String> statuses = [
    'Semua',
    'Masih di PO',
    'Dalam Perjalanan',
    'Selesai',
  ];

  final Color primaryColor = const Color(0xFFB71C1C);
  final Color backgroundColor = const Color(0xFFF7F7F7);
  final Color trackingColor = const Color(0xFF299D83);

  // Format harga Rupiah
  String formatRupiah(int price) {
    final formatted = price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'Rp $formatted';
  }

  // Warna status pesanan
  Color getStatusColor(String status) {
    switch (status) {
      case 'Masih di PO':
        return Colors.orange;
      case 'Dalam Perjalanan':
        return Colors.blue;
      case 'Selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // Ikon status pesanan
  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Masih di PO':
        return Icons.inventory_2_outlined;
      case 'Dalam Perjalanan':
        return Icons.local_shipping_outlined;
      case 'Selesai':
        return Icons.check_circle_outline;
      default:
        return Icons.receipt_long_outlined;
    }
  }

  // TRACKING PENGIRIMAN
  Widget buildTrackingCard(String status) {
    // 0 = Masih di PO
    // 1 = Dalam Perjalanan
    // 3 = Selesai

    final int progress = status == 'Selesai'
        ? 3
        : status == 'Dalam Perjalanan'
            ? 1
            : 0;

    String trackingMessage;

    if (status == 'Masih di PO') {
      trackingMessage =
          'Pesanan masih dalam proses PO. Informasi pengiriman akan tersedia setelah proses PO selesai.';
    } else if (status == 'Dalam Perjalanan') {
      trackingMessage =
          'Pesanan sedang dikirim. Informasi kedatangan akan diperbarui setelah tersedia.';
    } else {
      trackingMessage =
          'Pesanan telah tiba dan proses pengiriman sudah selesai.';
    }

    final List<IconData> icons = [
      Icons.inventory_2_outlined,
      Icons.local_shipping_outlined,
      Icons.check_circle_outline,
    ];

    final List<String> labels = [
      'Sedang Dikirim',
      'Menuju Alamatmu',
      'Pesanan Tiba',
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status == 'Selesai'
                ? 'Pesanan telah tiba'
                : status == 'Masih di PO'
                    ? 'Menunggu proses pengiriman'
                    : 'Estimasi tiba: menunggu informasi',
            style: TextStyle(
              color: trackingColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 22),

          // IKON DAN GARIS PROGRESS
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildTrackingStep(
                  icons[0],
                  progress > 0,
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: progress >= 2
                      ? trackingColor
                      : Colors.grey.shade300,
                ),
              ),

              Expanded(
                flex: 2,
                child: buildTrackingStep(
                  icons[1],
                  progress > 1,
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  height: 3,
                  color: progress >= 3
                      ? trackingColor
                      : Colors.grey.shade300,
                ),
              ),

              Expanded(
                flex: 2,
                child: buildTrackingStep(
                  icons[2],
                  progress >= 3,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // LABEL TAHAP PENGIRIMAN
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  labels[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: progress > 0
                        ? trackingColor
                        : Colors.grey,
                    fontWeight: progress > 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),

              const Expanded(flex: 1, child: SizedBox()),

              Expanded(
                flex: 2,
                child: Text(
                  labels[1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: progress > 1
                        ? trackingColor
                        : Colors.grey,
                    fontWeight: progress > 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),

              const Expanded(flex: 1, child: SizedBox()),

              Expanded(
                flex: 2,
                child: Text(
                  labels[2],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: progress >= 3
                        ? trackingColor
                        : Colors.grey,
                    fontWeight: progress >= 3
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // INFORMASI PENGIRIMAN
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: trackingColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: trackingColor,
                  size: 19,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    trackingMessage,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // IKON TAHAP TRACKING
  Widget buildTrackingStep(IconData icon, bool active) {
    return Center(
      child: Icon(
        icon,
        size: 27,
        color: active
            ? trackingColor
            : Colors.grey.shade400,
      ),
    );
  }

  // Menampilkan detail pesanan
  void showOrderDetail(dynamic order) {
    final statusColor = getStatusColor(order.status);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(22),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // GARIS ATAS
                  Center(
                    child: Container(
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Detail Pesanan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // INFORMASI PRODUK
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ProductImage(
                          path: order.image,
                          width: 95,
                          height: 95,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.name,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 7),

                            Text(
                              order.date,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              formatRupiah(order.price),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),
                  const Divider(),
                  const SizedBox(height: 12),

                  // INFORMASI PESANAN
                  const Text(
                    'Informasi Pesanan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 15),

                  detailRow(
                    'Nama Toko',
                    'PitStop Official Store',
                  ),

                  detailRow(
                    'Tanggal Pesanan',
                    order.date,
                  ),

                  detailRow(
                    'Produk',
                    order.name,
                  ),

                  detailRow(
                    'Total Harga',
                    formatRupiah(order.price),
                  ),

                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),

                  // STATUS PESANAN DAN TRACKING
                  const Text(
                    'Status Pesanan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          getStatusIcon(order.status),
                          color: statusColor,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            order.status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // TRACKING PENGIRIMAN
                  buildTrackingCard(order.status),

                  const SizedBox(height: 22),

                  // TOMBOL TUTUP
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Baris informasi detail
  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = AppData.orders.where((order) {
      return selectedStatus == 'Semua' ||
          order.status == selectedStatus;
    }).toList();

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: Text(
          'Riwayat Pesanan',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          // FILTER STATUS
          Container(
            color: Colors.white,
            height: 62,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: statuses.length,
              itemBuilder: (context, index) {
                final status = statuses[index];
                final selected = selectedStatus == status;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedStatus = status;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryColor
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // JUMLAH PESANAN
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 17, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Daftar Pesanan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '${orders.length} pesanan',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // DAFTAR PESANAN
          Expanded(
            child: orders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 65,
                          color: Colors.grey.shade400,
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Belum ada pesanan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'Pesanan dengan status ini belum tersedia.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      15, 5, 15, 20,
                    ),
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: 0.035,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // GAMBAR PRODUK
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ProductImage(
                                path: order.image,
                                width: 85,
                                height: 85,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 13),

                            // INFORMASI PRODUK
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    order.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 7),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today_outlined,
                                        size: 12,
                                        color: Colors.grey.shade600,
                                      ),

                                      const SizedBox(width: 5),

                                      Expanded(
                                        child: Text(
                                          order.date,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    formatRupiah(order.price),
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 8),

                            // TOMBOL LIHAT DETAIL
                            OutlinedButton(
                              onPressed: () {
                                showOrderDetail(order);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryColor,
                                side: BorderSide(
                                  color: primaryColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                minimumSize: const Size(0, 38),
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Lihat Detail',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
  }
}

