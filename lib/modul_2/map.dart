import 'dart:io';

void main() {
  Map<String, String> data = {};

  while (true) {
    print("\n=== MENU MAP ===");
    print("1. Tambah Data");
    print("2. Tampil Berdasarkan Key");
    print("3. Ubah Data");
    print("4. Hapus Data");
    print("5. Cek Key");
    print("6. Hitung Jumlah Data");
    print("7. Tampilkan Semua Data");
    print("8. Keluar");
    stdout.write("Pilih menu: ");
    int pilih = int.parse(stdin.readLineSync()!);

    if (pilih == 1) {
      stdout.write("Masukkan key: ");
      String key = stdin.readLineSync()!;
      stdout.write("Masukkan value: ");
      String value = stdin.readLineSync()!;
      data[key] = value;
      print("Data berhasil ditambahkan.");
    }

    else if (pilih == 2) {
      stdout.write("Masukkan key: ");
      String key = stdin.readLineSync()!;
      print("Value: ${data[key]}");
    }

    else if (pilih == 3) {
      stdout.write("Masukkan key: ");
      String key = stdin.readLineSync()!;
      if (data.containsKey(key)) {
        stdout.write("Masukkan value baru: ");
        data[key] = stdin.readLineSync()!;
        print("Data berhasil diubah.");
      } else {
        print("Key tidak ditemukan.");
      }
    }

    else if (pilih == 4) {
      stdout.write("Masukkan key: ");
      String key = stdin.readLineSync()!;
      data.remove(key);
      print("Data dihapus.");
    }

    else if (pilih == 5) {
      stdout.write("Masukkan key: ");
      String key = stdin.readLineSync()!;
      print(data.containsKey(key)
          ? "Key ditemukan"
          : "Key tidak ditemukan");
    }

    else if (pilih == 6) {
      print("Jumlah data: ${data.length}");
    }

    else if (pilih == 7) {
      print("=== Semua Data ===");
      data.forEach((key, value) {
        print("Key: $key, Value: $value");
      });
    }

    else if (pilih == 8) {
      break;
    }
  }
}