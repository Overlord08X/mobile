class ProfileModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final String universitas;

  ProfileModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    required this.universitas,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      universitas: json['universitas'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'universitas': universitas,
    };
  }
}