class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final String prodi;
  final String angkatan;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.prodi,
    required this.angkatan,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      prodi: json['prodi'] ?? '',
      angkatan: json['angkatan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'prodi': prodi,
      'angkatan': angkatan,
    };
  }
}