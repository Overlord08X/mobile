import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/features/profile/data/models/profile_model.dart';
import 'package:test_1/features/profile/data/repositories/profile_repositories.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

class ProfileNotifier extends StateNotifier<AsyncValue<List<ProfileModel>>> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getProfileList();
      state = AsyncValue.data(data);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadProfile();
  }
}

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<
        ProfileNotifier,
        AsyncValue<List<ProfileModel>>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository);
});