import 'package:test_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaAktifModel(
        nama: 'Raihan Zulfa Kamal',
        nim: '434241096',
        email: 'raihan.zulfa.kamal@vokasi.unair.ac.id',
        prodi: 'D4 Teknik Informatika',
        angkatan: '2024',
      ),
      MahasiswaAktifModel(
        nama: 'Alya Putri',
        nim: '434241097',
        email: 'alya.putri@vokasi.unair.ac.id',
        prodi: 'D4 Teknik Informatika',
        angkatan: '2024',
      ),
      MahasiswaAktifModel(
        nama: 'Fajar Ramadhan',
        nim: '434241098',
        email: 'fajar.ramadhan@vokasi.unair.ac.id',
        prodi: 'D4 Teknik Informatika',
        angkatan: '2024',
      ),
    ];
  }
}