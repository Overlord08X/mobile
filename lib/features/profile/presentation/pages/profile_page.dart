import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/core/widgets/widgets.dart';
import 'package:test_1/features/profile/presentation/providers/profile_provider.dart';
import 'package:test_1/features/profile/presentation/widgets/profile_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(profileNotifierProvider);
            },
          )
        ],
      ),
      body: profileState.when(
        loading: () => const LoadingWidget(),

        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat profile: ${error.toString()}',
          onRetry: () {
            ref.read(profileNotifierProvider.notifier).refresh();
          },
        ),

        data: (profileList) {
          return ProfileListView(
            profileList: profileList,
            onRefresh: () async {
              ref.invalidate(profileNotifierProvider);
            },
          );
        },
      ),
    );
  }
}