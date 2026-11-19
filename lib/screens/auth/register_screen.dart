import 'package:flutter/material.dart';
import '../../data/wilayah_data.dart';
import '../../models/user_model.dart';
import '../../widgets/auth_underline_field.dart';
import '../main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaController = TextEditingController();
  final _hpController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedProvinsi;
  String? _selectedKota;

  bool get _isFormValid =>
      _namaController.text.trim().isNotEmpty &&
      _hpController.text.trim().isNotEmpty &&
      _selectedProvinsi != null &&
      _selectedKota != null &&
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.length >= 6 &&
      _confirmPasswordController.text == _passwordController.text;

  @override
  void dispose() {
    _namaController.dispose();
    _hpController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi password tidak cocok.'),
          backgroundColor: Color(0xFFB71C1C),
        ),
      );
      return;
    }

    final newUser = UserModel(
      namaLengkap: _namaController.text.trim(),
      noHp: _hpController.text.trim(),
      provinsi: _selectedProvinsi!,
      kota: _selectedKota!,
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    final created = AuthSession.register(newUser);
    if (!created) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau Nomor Handphone sudah terdaftar.'),
          backgroundColor: Color(0xFFB71C1C),
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFB71C1C);
    final daftarKota = WilayahData.getKotaByProvinsi(_selectedProvinsi);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Masukkan data diri Kamu',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF424242),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Color(0xFFE0E0E0), height: 1),
                  const SizedBox(height: 16),

                  // NAMA LENGKAP
                  AuthUnderlineField(
                    controller: _namaController,
                    hintText: 'Nama Lengkap',
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 18),

                  // NOMOR HANDPHONE
                  AuthUnderlineField(
                    controller: _hpController,
                    hintText: 'Nomor Handphone',
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 22),

                  // DROPDOWN PROVINSI DOMISILI
                  const Text(
                    'Provinsi Domisili',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedProvinsi,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: primaryRed,
                    ),
                    hint: const Text(
                      'Provinsi Domisili',
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryRed, width: 1.8),
                      ),
                    ),
                    items: WilayahData.daftarProvinsi
                        .map(
                          (prov) => DropdownMenuItem(
                            value: prov,
                            child: Text(
                              prov,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProvinsi = value;
                        _selectedKota = null;
                      });
                    },
                  ),
                  const SizedBox(height: 22),

                  // DROPDOWN KOTA DOMISILI
                  const Text(
                    'Kota Domisili',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedKota,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: primaryRed,
                    ),
                    hint: const Text(
                      'Kota Domisili',
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryRed, width: 1.8),
                      ),
                    ),
                    items: daftarKota
                        .map(
                          (kota) => DropdownMenuItem(
                            value: kota,
                            child: Text(
                              kota,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: _selectedProvinsi == null
                        ? null
                        : (value) {
                            setState(() {
                              _selectedKota = value;
                            });
                          },
                  ),
                  const SizedBox(height: 18),

                  // EMAIL
                  AuthUnderlineField(
                    controller: _emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 18),

                  // PASSWORD
                  AuthUnderlineField(
                    controller: _passwordController,
                    hintText: 'Password (min. 6 karakter)',
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 18),

                  // KONFIRMASI PASSWORD
                  AuthUnderlineField(
                    controller: _confirmPasswordController,
                    hintText: 'Konfirmasi Password',
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // TOMBOL LANJUT DI BAGIAN BAWAH
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isFormValid ? _handleRegister : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  disabledBackgroundColor: const Color(0xFFE0E0E0),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'LANJUT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}