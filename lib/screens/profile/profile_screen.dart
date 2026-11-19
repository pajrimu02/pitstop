import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../auth/login_screen.dart';
import 'about_app_screen.dart';
import 'edit_profile_screen.dart';
import 'help_screen.dart';
import 'my_vehicles_screen.dart';
import 'pitstop_pay_screen.dart';
import 'points_screen.dart';
import 'settings_screen.dart';
import 'voucher_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _openEditProfile() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
    );
    if (mounted) setState(() {});
  }

  void _confirmLogout() {
    const red = Color(0xFFB71C1C);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar Akun'),
        content: const Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              AuthSession.logout();
              AuthSession.logout();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginScreen(),
                  transitionDuration: const Duration(milliseconds: 220),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
                (route) => false,
              );
            },
            child: const Text(
              'Keluar',
              style: TextStyle(color: red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final user = AuthSession.currentUser;
    final displayName = user?.namaLengkap ?? 'Tamu PitStop';
    final displayEmail = user?.email ?? 'Belum login';
    final displayLocation =
        user != null ? '${user.kota}, ${user.provinsi}' : '';

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          'Akun Saya',
          style: TextStyle(
            color: red,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            isDark ? const Color(0xFF181A20) : const Color(0xFFEAF2FB),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
                    Color(0xFF181A20),
                    Color(0xFF121318),
                    Color(0xFF1A1416),
                  ]
                : const [
                    Color(0xFFEAF2FB), // Biru muda lembut di bagian atas
                    Color(0xFFF6F9FC), // Putih kebiruan bersih di tengah
                    Color(
                        0xFFFFF5F5), // Sentuhan hangat merah muda sangat tipis di bawah
                  ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
          child: Column(
            children: [
              // KARTU PROFIL DENGAN GRADASI & EFEK BUBBLE / AWAN MELINGKAR
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF8E0000),
                      Color(0xFFB71C1C),
                      Color(0xFFE53935),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: red.withValues(alpha: 0.30),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Ornamen lingkaran besar kanan atas (efek awan/gelembung)
                      Positioned(
                        right: -28,
                        top: -32,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.22),
                                Colors.white.withValues(alpha: 0.04),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Ornamen lingkaran sedang kanan bawah
                      Positioned(
                        right: 35,
                        bottom: -45,
                        child: Container(
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.10),
                          ),
                        ),
                      ),
                      // Ornamen lingkaran kecil kiri bawah
                      Positioned(
                        left: -20,
                        bottom: -25,
                        child: Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.08),
                          ),
                        ),
                      ),
                      // Ornamen titik-titik/gelembung aksen
                      Positioned(
                        right: 95,
                        top: 16,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.18),
                          ),
                        ),
                      ),

                      // KONTEN UTAMA KARTU PROFIL
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            // Avatar dengan ring transparan berlapis
                            Container(
                              padding: const EdgeInsets.all(3.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.28),
                              ),
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: red,
                                  size: 35,
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    displayEmail,
                                    style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.88),
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (displayLocation.isNotEmpty) ...[
                                    const SizedBox(height: 7),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.18),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 12.5,
                                          ),
                                          const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              displayLocation,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: _openEditProfile,
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                tooltip: 'Edit Profil',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              _menu(isDark, Icons.person_outline, 'Profil Saya',
                  _openEditProfile),
              _menu(isDark, Icons.motorcycle, 'Motor Saya', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyVehiclesScreen()),
                );
              }),
              _menu(isDark, Icons.card_giftcard, 'Voucher Saya', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VoucherScreen()),
                );
              }),
              _menu(
                isDark,
                Icons.account_balance_wallet_outlined,
                'PitStop Pay',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PitStopPayScreen()),
                  );
                },
              ),
              _menu(isDark, Icons.stars, 'Poin Saya', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PointsScreen()),
                );
              }),

              const SizedBox(height: 15),

              _menu(isDark, Icons.settings_outlined, 'Pengaturan', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              }),
              _menu(isDark, Icons.help_outline, 'Bantuan', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpScreen()),
                );
              }),
              _menu(isDark, Icons.info_outline, 'Tentang Aplikasi', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutAppScreen()),
                );
              }),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _confirmLogout,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isDark
                        ? const Color(0xFF1E1E1E)
                        : Colors.white.withValues(alpha: 0.85),
                    side: const BorderSide(color: red),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.logout, color: red),
                  label: const Text(
                    'Keluar',
                    style: TextStyle(color: red, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                'PitStop Version 1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu(bool isDark, IconData icon, String title, VoidCallback onTap) {
    const red = Color(0xFFB71C1C);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.25)
                : const Color(0xFF90A4AE).withValues(alpha: 0.14),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                isDark ? red.withValues(alpha: 0.18) : const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: red, size: 21),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}
