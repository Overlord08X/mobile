import 'package:flutter/material.dart';
import 'package:test_1/features/profile/data/models/profile_model.dart';

class ProfileListView extends StatelessWidget {
  final List<ProfileModel> profileList;
  final Future<void> Function()? onRefresh;

  const ProfileListView({
    super.key,
    required this.profileList,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final profile = profileList.first;

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),

          CircleAvatar(
            radius: 50,
            child: Text(
              profile.nama.substring(0, 1),
              style: const TextStyle(fontSize: 40),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              profile.nama,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Card(
            child: ListTile(
              leading: const Icon(Icons.badge),
              title: const Text("NIM"),
              subtitle: Text(profile.nim),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(profile.email),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Jurusan"),
              subtitle: Text(profile.jurusan),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text("Universitas"),
              subtitle: Text(profile.universitas),
            ),
          ),
        ],
      ),
    );
  }
}