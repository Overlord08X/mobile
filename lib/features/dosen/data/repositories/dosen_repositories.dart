import 'package:test_1/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  Future<List<DosenModel>> getDosenList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      DosenModel(
        nama: 'Raihan Zulfa Kamal',
        nip: '1234567890',
        email: 'raihan.zulfa.kamal-2024@vokasi.unair.ac.id',
        jurusan: 'Teknik Informatika',
      ),
      DosenModel(
        nama: 'Emilya Rachmawati',
        nip: '1234567890',
        email: 'emilya.rachmawati-2024@vokasi.unair.ac.id',
        jurusan: 'Teknik Informatika',
      ),
      DosenModel(
        nama: 'Raiya',
        nip: '1234567890',
        email: 'raiya-2024@vokasi.unair.ac.id',
        jurusan: 'Teknik Informatika',
      ),
    ];
  }
}