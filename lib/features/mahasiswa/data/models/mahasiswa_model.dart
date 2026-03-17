class MahasiswaModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['nama'] ?? json['name'] ?? '',
      nim: json['nim']?.toString() ?? json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama': nama, 'nim': nim, 'email': email, 'jurusan': jurusan};
  }
}
