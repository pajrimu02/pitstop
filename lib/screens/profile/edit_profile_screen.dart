import 'package:flutter/material.dart';
import '../../data/wilayah_data.dart';
import '../../models/user_model.dart';
import '../../widgets/auth_underline_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _namaController;
  late final TextEditingController _hpController;
  late final TextEditingController _emailController;
  String? _selectedProvinsi;
  String? _selectedKota;

  @override
  void initState() {
    super.initState();
    final user = AuthSession.currentUser;
    _namaController = TextEditingController(text: user?.namaLengkap ?? '');
    _hpController = TextEditingController(text: user?.noHp ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
    _selectedProvinsi = user?.provinsi;
    _selectedKota = user?.kota;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _hpController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_namaController.text.trim().isEmpty ||
        _hpController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _selectedProvinsi == null ||
        _selectedKota == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap lengkapi semua data profil.'),
          backgroundColor: Color(0xFFB71C1C),
        ),
      );
      return;
    }

    AuthSession.updateProfile(
      namaLengkap: _namaController.text.trim(),
      noHp: _hpController.text.trim(),
      provinsi: _selectedProvinsi!,
      kota: _selectedKota!,
      email: _emailController.text.trim(),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFB71C1C);
    final daftarKota = WilayahData.getKotaByProvinsi(_selectedProvinsi);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xFFFFEBEE),
                child: Icon(Icons.person, color: red, size: 46),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Nama Lengkap',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            AuthUnderlineField(
              controller: _namaController,
              hintText: 'Nama Lengkap',
            ),
            const SizedBox(height: 18),
            const Text(
              'Nomor Handphone',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            AuthUnderlineField(
              controller: _hpController,
              hintText: 'Nomor Handphone',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 18),
            const Text(
              'Email',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            AuthUnderlineField(
              controller: _emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 18),
            const Text(
              'Provinsi Domisili',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            DropdownButtonFormField<String>(
              initialValue: WilayahData.daftarProvinsi.contains(_selectedProvinsi)
                  ? _selectedProvinsi
                  : null,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: red),
              items: WilayahData.daftarProvinsi
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedProvinsi = val;
                  _selectedKota = null;
                });
              },
            ),
            const SizedBox(height: 18),
            const Text(
              'Kota Domisili',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            DropdownButtonFormField<String>(
              initialValue:
                  daftarKota.contains(_selectedKota) ? _selectedKota : null,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, color: red),
              items: daftarKota
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: _selectedProvinsi == null
                  ? null
                  : (val) => setState(() => _selectedKota = val),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SIMPAN PERUBAHAN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}