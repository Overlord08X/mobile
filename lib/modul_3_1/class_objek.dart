import 'dart:io';

class Mahasiwa {
  String nama = 'raihan';

  void tampilkanData() {
    print(nama);
  }
}

void main() {
  var mahasiswa1 = Mahasiwa();
  mahasiswa1.tampilkanData();

  stdout.write("Masukkan nama baru: ");
  String? namaBaru = stdin.readLineSync();
  if (namaBaru != null && namaBaru.isNotEmpty) {
    mahasiswa1.nama = namaBaru;
    print("Nama berhasil diubah.");
    mahasiswa1.tampilkanData();
  } else {
    print("Nama tidak boleh kosong.");
  }
}