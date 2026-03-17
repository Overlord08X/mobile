import 'package:dio/dio.dart';
import 'package:test_1/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'en-US,en;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br',
        'DNT': '1',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1',
      },
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    final response = await _dio.get('/comments');

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data (status: ${response.statusCode})');
    }

    final data = response.data;
    if (data is! List) {
      throw Exception('Format data tidak valid');
    }

    return data
        .cast<Map<String, dynamic>>()
        .take(20)
        .map((json) => MahasiswaModel.fromJson(json))
        .toList();
  }
}
