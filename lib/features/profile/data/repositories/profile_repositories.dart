import 'package:test_1/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  Future<List<ProfileModel>> getProfileList() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ProfileModel(
        nama: 'Raihan Zulfa Kamal',
        nim: '434241096',
        email: 'raihan.zulfa.kamal-2024@vokasi.unair.ac.id',
        jurusan: 'D4 Teknik Informatika',
        universitas: 'Universitas Airlangga',
      ),
    ];
  }
}