import 'package:flutter/material.dart';
import '../../data/app_settings.dart';
import '../../models/user_model.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifServis = true;
  bool _notifPromo = true;
  bool _bagikanLokasiBengkel = true;
  bool _riwayatServisPrivat = false;

  static const List<String> _worldLanguages = [
    'Afghanistan (Pashto / Dari)',
    'Afrika Selatan (English / Afrikaans / Zulu)',
    'Albania (Shqip)',
    'Aljazair (العربية / Tamazight)',
    'Amerika Serikat (English - US)',
    'Andorra (Català)',
    'Angola (Português)',
    'Arab Saudi (العربية)',
    'Argentina (Español)',
    'Armenia (Հայերեն)',
    'Australia (English - AU)',
    'Austria (Deutsch)',
    'Azerbaijan (Azərbaycan)',
    'Bahama (English)',
    'Bahrain (العربية)',
    'Bangladesh (বাংলা)',
    'Barbados (English)',
    'Belanda (Nederlands)',
    'Belarus (Беларуская)',
    'Belgia (Nederlands / Français / Deutsch)',
    'Belize (English / Español)',
    'Benin (Français)',
    'Bhutan (Dzongkha)',
    'Bolivia (Español)',
    'Bosnia dan Herzegovina (Bosanski)',
    'Botswana (English / Setswana)',
    'Brasil (Português)',
    'Brunei Darussalam (Bahasa Melayu)',
    'Bulgaria (Български)',
    'Burkina Faso (Français)',
    'Burundi (Kirundi / Français)',
    'Ceko (Čeština)',
    'Chad (Français / العربية)',
    'Chili (Español)',
    'Denmark (Dansk)',
    'Djibouti (Français / العربية)',
    'Dominika (English)',
    'Ekuador (Español)',
    'El Salvador (Español)',
    'Eritrea (Tigrinya / العربية)',
    'Estonia (Eesti)',
    'Eswatini (English / SiSwati)',
    'Ethiopia (አማርኛ)',
    'Fiji (English / Fijian)',
    'Filipina (Filipino / English)',
    'Finlandia (Suomi / Svenska)',
    'Gabon (Français)',
    'Gambia (English)',
    'Georgia (ქართული)',
    'Ghana (English)',
    'Grenada (English)',
    'Guatemala (Español)',
    'Guinea (Français)',
    'Guinea-Bissau (Português)',
    'Guyana (English)',
    'Haiti (Kreyòl Ayisyen / Français)',
    'Honduras (Español)',
    'Hongaria (Magyar)',
    'India (हिन्दी / English)',
    'Indonesia (Bahasa Indonesia)',
    'Inggris / Britania Raya (English - UK)',
    'Irak (العربية / کوردی)',
    'Iran (فارسی)',
    'Irlandia (Gaeilge / English)',
    'Islandia (Íslenska)',
    'Israel (עברית / العربية)',
    'Italia (Italiano)',
    'Jamaika (English)',
    'Jepang (日本語)',
    'Jerman (Deutsch)',
    'Kamboja (ភាសាខ្មែរ)',
    'Kamerun (Français / English)',
    'Kanada (English / Français)',
    'Kazakhstan (Қазақша / Русский)',
    'Kenya (Kiswahili / English)',
    'Kirgizstan (Кыргызча / Русский)',
    'Kiribati (English)',
    'Kolombia (Español)',
    'Komoro (العربية / Français)',
    'Kongo - Brazzaville (Français)',
    'Kongo - Kinshasa (Français)',
    'Korea Selatan (한국어)',
    'Korea Utara (조선말)',
    'Kosta Rika (Español)',
    'Kroasia (Hrvatski)',
    'Kuba (Español)',
    'Kuwait (العربية)',
    'Laos (ລາວ)',
    'Latvia (Latviešu)',
    'Lebanon (العربية)',
    'Lesotho (Sesotho / English)',
    'Liberia (English)',
    'Libya (العربية)',
    'Liechtenstein (Deutsch)',
    'Lituania (Lietuvių)',
    'Luksemburg (Lëtzebuergesch / Français / Deutsch)',
    'Madagaskar (Malagasy / Français)',
    'Maladewa (ދިވެހި)',
    'Malawi (English / Chichewa)',
    'Malaysia (Bahasa Melayu)',
    'Mali (Français)',
    'Malta (Malti / English)',
    'Maroko (العربية / Tamazight)',
    'Mauritania (العربية)',
    'Mauritius (English / Français)',
    'Meksiko (Español)',
    'Mesir (العربية)',
    'Mikronesia (English)',
    'Moldova (Română)',
    'Monako (Français)',
    'Mongolia (Монгол)',
    'Montenegro (Crnogorski)',
    'Mozambik (Português)',
    'Myanmar (မြန်မာစာ)',
    'Namibia (English)',
    'Nauru (English)',
    'Nepal (नेपाली)',
    'Niger (Français)',
    'Nigeria (English)',
    'Nikaragua (Español)',
    'Norwegia (Norsk)',
    'Oman (العربية)',
    'Pakistan (اردو / English)',
    'Palau (English)',
    'Palestina (العربية)',
    'Panama (Español)',
    'Pantai Gading (Français)',
    'Papua Nugini (English / Tok Pisin)',
    'Paraguay (Español / Guaraní)',
    'Peru (Español)',
    'Polandia (Polski)',
    'Portugal (Português)',
    'Prancis (Français)',
    'Qatar (العربية)',
    'Rumania (Română)',
    'Rusia (Русский)',
    'Rwanda (Kinyarwanda / Français / English)',
    'Saint Kitts dan Nevis (English)',
    'Saint Lucia (English)',
    'Saint Vincent dan Grenadines (English)',
    'Samoa (Gagana Samoa / English)',
    'San Marino (Italiano)',
    'Sao Tome dan Principe (Português)',
    'Selandia Baru (English / Māori)',
    'Senegal (Français)',
    'Serbia (Српски)',
    'Seychelles (Seychellois Creole / English / Français)',
    'Sierra Leone (English)',
    'Singapura (English / Bahasa Melayu / 中文 / தமிழ்)',
    'Siprus (Ελληνικά / Türkçe)',
    'Slovakia (Slovenčina)',
    'Slovenia (Slovenščina)',
    'Solomon (English)',
    'Somalia (Soomaali / العربية)',
    'Spanyol (Español)',
    'Sri Lanka (සිංහල / தமிழ்)',
    'Sudan (العربية / English)',
    'Sudan Selatan (English)',
    'Suriah (العربية)',
    'Suriname (Nederlands)',
    'Swedia (Svenska)',
    'Swiss (Deutsch / Français / Italiano)',
    'Tajikistan (Тоҷикӣ)',
    'Tanjung Verde (Português)',
    'Tanzania (Kiswahili / English)',
    'Thailand (ไทย)',
    'Timor Leste (Tetun / Português)',
    'Tiongkok (中文 - 简体)',
    'Togo (Français)',
    'Tonga (Lea Fakatonga / English)',
    'Trinidad dan Tobago (English)',
    'Tunisia (العربية)',
    'Turki (Türkçe)',
    'Turkmenistan (Türkmençe)',
    'Tuvalu (English)',
    'Uganda (English / Kiswahili)',
    'Ukraina (Українська)',
    'Uni Emirat Arab (العربية)',
    'Uruguay (Español)',
    'Uzbekistan (Oʻzbekcha)',
    'Vanuatu (Bislama / English / Français)',
    'Vatikan (Italiano / Latina)',
    'Venezuela (Español)',
    'Vietnam (Tiếng Việt)',
    'Yaman (العربية)',
    'Yordania (العربية)',
    'Yunani (Ελληνικά)',
    'Zambia (English)',
    'Zimbabwe (English / Shona)',
  ];

  void _openLanguagePicker() {
    final searchCtrl = TextEditingController();
    List<String> filtered = List.from(_worldLanguages);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Pilih Bahasa & Negara',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchCtrl,
                      decoration: InputDecoration(
                        hintText: 'Cari negara atau bahasa...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                      ),
                      onChanged: (query) {
                        setModalState(() {
                          filtered = _worldLanguages
                              .where(
                                (item) => item
                                    .toLowerCase()
                                    .contains(query.toLowerCase()),
                              )
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final lang = filtered[index];
                        final isSelected =
                            lang == AppSettings.selectedLanguage.value;
                        return ListTile(
                          title: Text(
                            lang,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? const Color(0xFFB71C1C)
                                  : null,
                            ),
                          ),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFFB71C1C),
                                )
                              : null,
                          onTap: () {
                            AppSettings.setLanguage(lang);
                            setState(() {});
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(this.context).showSnackBar(
                              SnackBar(
                                content: Text('Bahasa diubah ke $lang'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openPrivacySheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pengaturan Privasi',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    activeThumbColor: const Color(0xFFB71C1C),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Akses Lokasi Bengkel Terdekat',
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Izinkan PitStop mendeteksi lokasi untuk rekomendasi bengkel',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: _bagikanLokasiBengkel,
                    onChanged: (val) {
                      setModalState(() => _bagikanLokasiBengkel = val);
                      setState(() {});
                    },
                  ),
                  SwitchListTile(
                    activeThumbColor: const Color(0xFFB71C1C),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Sembunyikan Riwayat Servis',
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Kunci riwayat servis kendaraan dari tampilan cepat',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: _riwayatServisPrivat,
                    onChanged: (val) {
                      setModalState(() => _riwayatServisPrivat = val);
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showChangePasswordDialog() {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ubah Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password Lama'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password Baru (min. 6 karakter)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Konfirmasi Password Baru',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB71C1C),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (newCtrl.text.length < 6 || newCtrl.text != confirmCtrl.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password baru minimal 6 karakter dan harus cocok.',
                    ),
                    backgroundColor: Color(0xFFB71C1C),
                  ),
                );
                return;
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password berhasil diperbarui.')),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout() {
    const red = Color(0xFFB71C1C);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar dari Akun'),
        content: const Text('Apakah kamu yakin ingin keluar dari akun PitStop?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              AuthSession.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
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
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // TAMPILAN & BAHASA
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Tampilan & Bahasa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  activeThumbColor: red,
                  secondary: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    color: red,
                  ),
                  title: const Text(
                    'Tampilan Mode Gelap',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    isDark ? 'Mode Gelap aktif' : 'Mode Terang aktif',
                    style: const TextStyle(fontSize: 12),
                  ),
                  value: isDark,
                  onChanged: (val) {
                    AppSettings.toggleDarkMode(val);
                    setState(() {});
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language, color: red),
                  title: const Text(
                    'Bahasa',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    AppSettings.selectedLanguage.value,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _openLanguagePicker,
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // NOTIFIKASI
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Notifikasi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  activeThumbColor: red,
                  secondary: const Icon(
                    Icons.notifications_active_outlined,
                    color: red,
                  ),
                  title: const Text(
                    'Pengingat Servis Berkala',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'Notifikasi jadwal ganti oli & servis rutin',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _notifServis,
                  onChanged: (val) => setState(() => _notifServis = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  activeThumbColor: red,
                  secondary: const Icon(Icons.local_offer_outlined, color: red),
                  title: const Text(
                    'Notifikasi Promo & Voucher',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'Info diskon sparepart & layanan terbaru',
                    style: TextStyle(fontSize: 12),
                  ),
                  value: _notifPromo,
                  onChanged: (val) => setState(() => _notifPromo = val),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // PRIVASI & KEAMANAN AKUN
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Privasi & Keamanan Akun',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined, color: red),
                  title: const Text(
                    'Privasi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text(
                    'Kelola izin lokasi dan privasi data',
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _openPrivacySheet,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: red),
                  title: const Text(
                    'Ubah Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _showChangePasswordDialog,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: red),
                  title: const Text(
                    'Keluar dari Akun',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: red,
                    ),
                  ),
                  onTap: _confirmLogout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}