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
      nama: json['nama'] ?? json['title'] ?? '',
      nim: json['nim']?.toString() ?? json['id']?.toString() ?? '',
      email: json['email'] ?? 'user${json['userId'] ?? ''}@example.com',
      prodi: json['prodi'] ?? json['body'] ?? '',
      angkatan:
          json['angkatan']?.toString() ?? json['userId']?.toString() ?? '2024',
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
