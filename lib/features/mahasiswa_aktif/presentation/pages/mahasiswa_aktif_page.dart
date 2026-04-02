import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/core/widgets/widgets.dart';
import 'package:test_1/features/mahasiswa_aktif/presentation/providers/mahasiswa_aktif_provider.dart';
import 'package:test_1/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          )
        ],
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),

        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data mahasiswa: ${error.toString()}',
          onRetry: () {
            ref.read(mahasiswaAktifNotifierProvider.notifier).refresh();
          },
        ),

        data: (mahasiswaList) {
          return MahasiswaAktifListView(
            mahasiswaList: mahasiswaList,
            onRefresh: () async {
              ref.invalidate(mahasiswaAktifNotifierProvider);
            },
          );
        },
      ),
    );
  }
}