import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';
import 'package:test_1/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repositories.dart';

final mahasiswaAktifRepositoryProvider =
    Provider<MahasiswaAktifRepository>((ref) {
  return MahasiswaAktifRepository();
});

class MahasiswaAktifNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
  final MahasiswaAktifRepository _repository;

  MahasiswaAktifNotifier(this._repository)
      : super(const AsyncValue.loading()) {
    loadMahasiswaAktif();
  }

  Future<void> loadMahasiswaAktif() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaAktifList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaAktif();
  }
}

final mahasiswaAktifNotifierProvider =
    StateNotifierProvider.autoDispose<
        MahasiswaAktifNotifier,
        AsyncValue<List<MahasiswaAktifModel>>>((ref) {
  final repository = ref.watch(mahasiswaAktifRepositoryProvider);
  return MahasiswaAktifNotifier(repository);
});