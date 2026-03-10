import 'package:flutter/material.dart';
import 'package:test_1/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifListView extends StatelessWidget {
  final List<MahasiswaAktifModel> mahasiswaList;
  final Future<void> Function()? onRefresh;

  const MahasiswaAktifListView({
    super.key,
    required this.mahasiswaList,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mahasiswa = mahasiswaList[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(mahasiswa.nama.substring(0, 1)),
              ),
              title: Text(mahasiswa.nama),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("NIM: ${mahasiswa.nim}"),
                  Text(mahasiswa.email),
                  Text("${mahasiswa.prodi} • ${mahasiswa.angkatan}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}