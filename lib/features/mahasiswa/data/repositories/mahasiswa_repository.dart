import 'package:test_1/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Raihan Zulfa Kamal',
        nim: '434241096',
        email: 'raihan.zulfa.kamal@vokasi.unair.ac.id',
        jurusan: 'Teknik Informatika',
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '434241097',
        email: 'budi.santoso@vokasi.unair.ac.id',
        jurusan: 'Teknik Informatika',
      ),
      MahasiswaModel(
        nama: 'Siti Aisyah',
        nim: '434241098',
        email: 'siti.aisyah@vokasi.unair.ac.id',
        jurusan: 'Teknik Informatika',
      ),
    ];
  }
}