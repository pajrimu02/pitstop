class UserModel {
  final String namaLengkap;
  final String noHp;
  final String provinsi;
  final String kota;
  final String email;
  final String password;

  const UserModel({
    required this.namaLengkap,
    required this.noHp,
    required this.provinsi,
    required this.kota,
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? namaLengkap,
    String? noHp,
    String? provinsi,
    String? kota,
    String? email,
    String? password,
  }) {
    return UserModel(
      namaLengkap: namaLengkap ?? this.namaLengkap,
      noHp: noHp ?? this.noHp,
      provinsi: provinsi ?? this.provinsi,
      kota: kota ?? this.kota,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class AuthSession {
  static UserModel? currentUser;

  // Akun demo sementara untuk login langsung
  static final List<UserModel> _registeredUsers = [
    const UserModel(
      namaLengkap: 'User PitStop',
      noHp: '081234567890',
      provinsi: 'Jawa Barat',
      kota: 'Kab. Cianjur',
      email: 'user@pitstop.id',
      password: 'password123',
    ),
  ];

  static bool register(UserModel newUser) {
    final exists = _registeredUsers.any(
      (u) =>
          u.email.toLowerCase() == newUser.email.toLowerCase() ||
          u.noHp == newUser.noHp,
    );
    if (exists) return false;
    _registeredUsers.add(newUser);
    currentUser = newUser;
    return true;
  }

  static bool login(String identifier, String password) {
    final input = identifier.trim().toLowerCase();
    for (final user in _registeredUsers) {
      final matchIdentity =
          user.email.toLowerCase() == input || user.noHp == input;
      if (matchIdentity && user.password == password) {
        currentUser = user;
        return true;
      }
    }
    return false;
  }

  static void loginWithGoogle() {
    currentUser = const UserModel(
      namaLengkap: 'Akun Google PitStop',
      noHp: '081200000000',
      provinsi: 'Jawa Barat',
      kota: 'Kab. Cianjur',
      email: 'google.user@gmail.com',
      password: '',
    );
  }

  static void updateProfile({
    required String namaLengkap,
    required String noHp,
    required String provinsi,
    required String kota,
    required String email,
  }) {
    if (currentUser == null) return;
    final updated = currentUser!.copyWith(
      namaLengkap: namaLengkap,
      noHp: noHp,
      provinsi: provinsi,
      kota: kota,
      email: email,
    );

    final index = _registeredUsers.indexWhere(
      (u) => u.email == currentUser!.email,
    );
    if (index != -1) {
      _registeredUsers[index] = updated;
    }
    currentUser = updated;
  }

  static void logout() {
    currentUser = null;
  }
}