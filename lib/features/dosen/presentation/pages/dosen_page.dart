import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/core/widgets/widgets.dart';
import 'package:test_1/features/dosen/data/models/dosen_model.dart';
import 'package:test_1/features/dosen/presentation/providers/dosen_provider.dart';
import 'package:test_1/features/dosen/presentation/widgets/dosen_widget.dart';

class DosenPage extends ConsumerWidget {
  const DosenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dosenState = ref.watch(dosenNotifierProvider);
    final savedUsers = ref.watch(savedUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Dosen'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(dosenNotifierProvider);
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Section: data tersimpan di sharedPreferences
          _SavedUserSection(savedUsers: savedUsers, ref: ref),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Daftar Dosen',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),

          //Dosen list
          Expanded(
            child: dosenState.when(
              loading: () => const LoadingWidget(),
              error: (error, stack) => CustomErrorWidget(
                message: 'Gagal memuat data dosen: ${error.toString()}',
                onRetry: () {
                  ref.read(dosenNotifierProvider.notifier).refresh();
                },
              ),
              data: (dosenList) => _DosenListWithSave(
                dosenList: dosenList,
                onRefresh: () => ref.invalidate(dosenNotifierProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Widget: Section data SharedPreferences
class _SavedUserSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  final WidgetRef ref;

  const _SavedUserSection({required this.savedUsers, required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Header dengan tombol hapus semua
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: const Text(
                  'Data Tersimpan di Local Storage',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? Tooltip(
                        message: 'Hapus semua data tersimpan',
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete_sweep_outlined,
                            size: 18,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            await ref
                                .read(dosenNotifierProvider.notifier)
                                .clearSavedUsers();
                            ref.invalidate(savedUsersProvider);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Semua data tersimpan dihapus'),
                                ),
                              );
                            }
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),

          //Content
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (_, _) => const Text(
              'Gagal memabaca data tersimpan',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            data: (users) {
              if (users.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outlined,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Belum ada data. Tap ikon 💾 untuk menyimpan.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: Colors.green.shade100,
                    indent: 12,
                    endIndent: 12,
                  ),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.green.shade100,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(user['username'] ?? '_'),
                      subtitle: Text(
                        'ID: ${user['user_id']} • ${_formatDate(user['saved_at'] ?? '')}',
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await ref
                              .read(dosenNotifierProvider.notifier)
                              .removeSavedUser(user['user_id'] ?? '');
                          ref.invalidate(savedUsersProvider);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${user['username']} dihapus'),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoString) {
    if (isoString.isEmpty) return '-';
    try {
      final date = DateTime.parse(isoString);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return isoString;
    }
  }
}

//Widget: List dosen dengan tombol save
class _DosenListWithSave extends ConsumerWidget {
  final List<DosenModel> dosenList;
  final VoidCallback onRefresh;

  const _DosenListWithSave({required this.dosenList, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: dosenList.length,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${dosen.id}')),
              title: Text(
                '${dosen.username} • ${dosen.email}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                dosen.address.city,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              isThreeLine: false,
              trailing: IconButton(
                icon: const Icon(Icons.save, size: 18),
                tooltip: 'Simpan user ini',
                onPressed: () async {
                  await ref
                      .read(dosenNotifierProvider.notifier)
                      .saveSelectedDosen(dosen);
                  ref.invalidate(savedUsersProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${dosen.username} berhasil disimpan ke local storage',
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
