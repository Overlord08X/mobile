import 'dart:io';

void main() {
  Set<String> data = {};

  while (true) {
    print("\n=== MENU SET ===");
    print("1. Tambah Data");
    print("2. Hapus Data");
    print("3. Cek Data");
    print("4. Hitung Jumlah Data");
    print("5. Tampilkan Semua Data");
    print("6. Keluar");
    stdout.write("Pilih menu: ");
    int pilih = int.parse(stdin.readLineSync()!);

    if (pilih == 1) {
      stdout.write("Masukkan data: ");
      String input = stdin.readLineSync()!;
      data.add(input);
      print("Data berhasil ditambahkan (tidak bisa duplicate).");
    }

    else if (pilih == 2) {
      stdout.write("Masukkan data yang akan dihapus: ");
      String input = stdin.readLineSync()!;
      data.remove(input);
      print("Data dihapus.");
    }

    else if (pilih == 3) {
      stdout.write("Masukkan data yang dicek: ");
      String input = stdin.readLineSync()!;
      print(data.contains(input)
          ? "Data ditemukan"
          : "Data tidak ditemukan");
    }

    else if (pilih == 4) {
      print("Jumlah data: ${data.length}");
    }

    else if (pilih == 5) {
      print("=== Semua Data ===");
      for (var item in data) {
        print(item);
      }
    }

    else if (pilih == 6) {
      break;
    }
  }
}