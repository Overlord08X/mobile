import 'dart:io';

void main() {
  List<String> data = [];

  while (true) {
    print("\n=== MENU LIST ===");
    print("1. Tambah Data");
    print("2. Tampil Berdasarkan Index");
    print("3. Ubah Berdasarkan Index");
    print("4. Hapus Berdasarkan Index");
    print("5. Hitung Jumlah Data");
    print("6. Tampilkan Semua Data");
    print("7. Keluar");
    stdout.write("Pilih menu: ");
    int pilih = int.parse(stdin.readLineSync()!);

    if (pilih == 1) {
      stdout.write("Masukkan data: ");
      String input = stdin.readLineSync()!;
      data.add(input);
      print("Data berhasil ditambahkan.");
    }

    else if (pilih == 2) {
      stdout.write("Masukkan index: ");
      int index = int.parse(stdin.readLineSync()!);
      if (index < data.length) {
        print("Data pada index $index: ${data[index]}");
      } else {
        print("Index tidak ditemukan!");
      }
    }

    else if (pilih == 3) {
      stdout.write("Masukkan index: ");
      int index = int.parse(stdin.readLineSync()!);
      if (index < data.length) {
        stdout.write("Masukkan data baru: ");
        data[index] = stdin.readLineSync()!;
        print("Data berhasil diubah.");
      } else {
        print("Index tidak ditemukan!");
      }
    }

    else if (pilih == 4) {
      stdout.write("Masukkan index: ");
      int index = int.parse(stdin.readLineSync()!);
      if (index < data.length) {
        data.removeAt(index);
        print("Data berhasil dihapus.");
      } else {
        print("Index tidak ditemukan!");
      }
    }

    else if (pilih == 5) {
      print("Jumlah data: ${data.length}");
    }

    else if (pilih == 6) {
      print("=== Semua Data ===");
      for (int i = 0; i < data.length; i++) {
        print("Index $i : ${data[i]}");
      }
    }

    else if (pilih == 7) {
      break;
    }
  }
}