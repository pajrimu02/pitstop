class WilayahData {
  static const Map<String, List<String>> provinsiKota = {
    'Jawa Barat': [
      'Kab. Cianjur',
      'Kota Bandung',
      'Kab. Bandung',
      'Kota Bogor',
      'Kab. Bogor',
      'Kota Bekasi',
      'Kota Depok',
      'Kab. Sukabumi',
      'Kota Sukabumi',
    ],
    'DKI Jakarta': [
      'Jakarta Selatan',
      'Jakarta Pusat',
      'Jakarta Barat',
      'Jakarta Timur',
      'Jakarta Utara',
    ],
    'Banten': [
      'Kota Tangerang',
      'Kota Tangerang Selatan',
      'Kab. Tangerang',
      'Kota Serang',
      'Kota Cilegon',
    ],
    'Jawa Tengah': [
      'Kota Semarang',
      'Kota Surakarta',
      'Kab. Banyumas',
      'Kab. Cilacap',
      'Kota Tegal',
    ],
    'Jawa Timur': [
      'Kota Surabaya',
      'Kota Malang',
      'Kab. Sidoarjo',
      'Kota Kediri',
      'Kab. Banyuwangi',
    ],
  };

  static List<String> get daftarProvinsi => provinsiKota.keys.toList();

  static List<String> getKotaByProvinsi(String? provinsi) {
    if (provinsi == null) return [];
    return provinsiKota[provinsi] ?? [];
  }
}