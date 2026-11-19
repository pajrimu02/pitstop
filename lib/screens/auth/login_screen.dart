import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../widgets/auth_underline_field.dart';
import '../main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _identityController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get _isFormFilled =>
      _identityController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_isFormFilled) return;

    final success = AuthSession.login(
      _identityController.text,
      _passwordController.text,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email/No. HP atau Password salah. (Demo: user@pitstop.id / password123)',
          ),
          backgroundColor: Color(0xFFB71C1C),
        ),
      );
    }
  }

  void _handleGoogleLogin() {
    AuthSession.loginWithGoogle();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
  }

  void _showForgotPasswordDialog() {
    final resetController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Lupa Password'),
        content: TextField(
          controller: resetController,
          decoration: const InputDecoration(
            hintText: 'Masukkan Email atau No. Handphone',
          ),
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
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Instruksi reset password telah dikirim.'),
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryRed = Color(0xFFB71C1C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER MELENGKUNG + LOGO BULAT TENGAH
            SizedBox(
              height: 235,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipPath(
                    clipper: _HeaderCurveClipper(),
                    child: Container(
                      height: 185,
                      width: double.infinity,
                      color: primaryRed,
                    ),
                  ),
                  Positioned(
                    top: 115,
                    child: Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.two_wheeler,
                            color: primaryRed,
                            size: 38,
                          ),
                          SizedBox(height: 2),
                          Text(
                            'PITSTOP',
                            style: TextStyle(
                              color: primaryRed,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Text(
                            'ASSISTING YOU',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 6.5,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Masukan nomor Handphone atau\nalamat Email Kamu untuk login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 14.5,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // INPUT EMAIL / NO HP
                  AuthUnderlineField(
                    controller: _identityController,
                    hintText: 'Email/No. Handphone',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),

                  // INPUT PASSWORD
                  AuthUnderlineField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isPassword: true,
                    onChanged: (_) => setState(() {}),
                  ),

                  // LUPA PASSWORD
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(
                          color: primaryRed,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // TOMBOL MASUK
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isFormFilled ? _handleLogin : null,
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
                        'MASUK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),

                  // GOOGLE SIGN IN
                  const Text(
                    'Atau masuk dengan sekali klik',
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _handleGoogleLogin,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryRed,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),

                  // LINK KE DAFTAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tidak memiliki akun? ',
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 13.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            color: primaryRed,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // VERSI APP
                  const Text(
                    'NDS.Nw.100.pitstop.T20261120(100)',
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: 11.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 38);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 22,
      size.width,
      size.height - 38,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}