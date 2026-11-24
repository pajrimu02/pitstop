import 'package:flutter/foundation.dart';

/// Satu voucher (dipakai di halaman klaim & "Voucher Saya").
class VoucherItem {
  final String id;
  final String title;
  final String desc;
  final String code;
  final String valid;

  const VoucherItem({
    required this.id,
    required this.title,
    required this.desc,
    required this.code,
    required this.valid,
  });
}

/// Data bersama: saldo PitStop Pay, poin, dan voucher milik pengguna.
/// Semua halaman (Beranda, PitStop Pay, Poin, Voucher) membaca dari sini,
/// jadi kalau satu berubah, yang lain ikut berubah.
class WalletData extends ChangeNotifier {
  WalletData._();
  static final WalletData instance = WalletData._();

  /// Voucher yang bisa diklaim di halaman Voucher (beranda).
  static const List<VoucherItem> catalog = [
    VoucherItem(
      id: 'V1',
      title: 'Diskon Servis Berkala 30%',
      desc: 'Maksimal potongan Rp50.000 untuk semua paket servis rutin.',
      code: 'PITSTOP30',
      valid: 'Berlaku s/d 31 Des 2026',
    ),
    VoucherItem(
      id: 'V2',
      title: 'Potongan Ganti Oli Rp15.000',
      desc: 'Minimal pembelian oli mesin Rp75.000 di seluruh bengkel.',
      code: 'OLIHUMAT15',
      valid: 'Berlaku s/d 30 Nov 2026',
    ),
    VoucherItem(
      id: 'V3',
      title: 'Gratis Cek Kelistrikan & Rem',
      desc: 'Khusus pengguna baru aplikasi PitStop.',
      code: 'NEWPITSTOP',
      valid: 'Berlaku s/d 31 Des 2026',
    ),
    VoucherItem(
      id: 'V4',
      title: 'Diskon Ban 15%',
      desc: 'Maksimal potongan Rp30.000 untuk pembelian ban motor.',
      code: 'BAN15',
      valid: 'Berlaku s/d 15 Jan 2027',
    ),
    VoucherItem(
      id: 'V5',
      title: 'Gratis Ongkir',
      desc: 'Tanpa minimum belanja untuk pembelian sparepart.',
      code: 'ONGKIRGRATIS',
      valid: 'Berlaku s/d 20 Des 2026',
    ),
  ];

  // --- Data awal (sama dengan yang tadinya ada di halaman profil) ---
  int _points = 250;
  int _saldo = 125000;
  bool _payActive = true;
  final List<VoucherItem> _myVouchers = [];
  int _redeemCounter = 0;

  int get points => _points;
  int get saldo => _saldo;
  bool get payActive => _payActive;
  String get saldoText => formatRupiah(_saldo);
  List<VoucherItem> get myVouchers => List.unmodifiable(_myVouchers);

  // --- Voucher ---
  bool isClaimed(String id) => _myVouchers.any((v) => v.id == id);

  /// Klaim voucher. Hanya bisa sekali: kalau sudah pernah, mengembalikan false.
  bool claimVoucher(VoucherItem v) {
    if (isClaimed(v.id)) return false;
    _myVouchers.insert(0, v);
    notifyListeners();
    return true;
  }

  // --- Poin ---
  /// Tukar poin dengan hadiah. Hadiah masuk ke "Voucher Saya".
  /// Mengembalikan false kalau poin tidak cukup.
  bool redeemReward(String name, int cost) {
    if (_points < cost) return false;
    _points -= cost;
    _redeemCounter++;
    _myVouchers.insert(
      0,
      VoucherItem(
        id: 'R$_redeemCounter',
        title: name,
        desc: 'Hasil penukaran PitStop Poin.',
        code: 'POIN${100 + _redeemCounter}',
        valid: 'Berlaku 30 hari sejak penukaran',
      ),
    );
    notifyListeners();
    return true;
  }

  // --- PitStop Pay ---
  void topUp(int amount) {
    if (!_payActive) return;
    _saldo += amount;
    notifyListeners();
  }

  void togglePay() {
    _payActive = !_payActive;
    notifyListeners();
  }

  /// 125000 -> "Rp 125.000"
  static String formatRupiah(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final fromEnd = s.length - i;
      buf.write(s[i]);
      if (fromEnd > 1 && fromEnd % 3 == 1) buf.write('.');
    }
    return 'Rp $buf';
  }
}
