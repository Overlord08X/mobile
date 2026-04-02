import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/core/services/local_storage_service.dart';
import 'package:test_1/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:test_1/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

// Repository Provider
final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

// Local Storage Service Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

// provider semua data user yang disimpan
final savedUsersProvider = FutureProvider<List<Map<String, String>>>((
  ref,
) async {
  final storage = ref.watch(localStorageServiceProvider);
  return storage.getSavedUsers();
});

//StateNotifier untuk mengelola state mahasiswa
class MahasiswaNotifier
    extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final LocalStorageService _storage;

  MahasiswaNotifier(this._repository, this._storage)
    : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMahasiswaList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }

  //Simpan mahasiswa yang dipilih ke local storage (tanpa menghapus yang lama)
  Future<void> saveSelectedMahasiswa(MahasiswaModel mahasiswa) async {
    await _storage.addUserToSavedList(
      userId: mahasiswa.nim.toString(),
      username: mahasiswa.nama,
    );
  }

  //Hapus user tertentu dari list
  Future<void> removeSavedUser(String userId) async {
    await _storage.removeSavedUser(userId);
  }

  //Hapus semua user dari list
  Future<void> clearSavedUsers() async {
    await _storage.clearSavedUsers();
  }
}

// Mahasiswa Notifier Provider
final mahasiswaNotifierProvider =
    StateNotifierProvider.autoDispose<
      MahasiswaNotifier,
      AsyncValue<List<MahasiswaModel>>
    >((ref) {
      final repository = ref.watch(mahasiswaRepositoryProvider);
      final storage = ref.watch(localStorageServiceProvider);
      return MahasiswaNotifier(repository, storage);
    });
