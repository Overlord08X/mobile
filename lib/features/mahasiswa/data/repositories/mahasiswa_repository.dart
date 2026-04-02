import 'dart:convert';

import 'package:test_1/core/network/dio_client.dart';
import 'package:test_1/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:dio/dio.dart';

class MahasiswaRepository {
  final DioClient _dioClient;

  MahasiswaRepository({DioClient? dioClient})
    : _dioClient = dioClient ?? DioClient();

  // get data daftar mahasiswa
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final Response response = await _dioClient.dio.get(
        '/users',
        options: Options(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );
      final List<dynamic> data = response.data;
      return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;
      final message = e.message;
      throw Exception(
        'Gagal memuat data mahasiswa: ${statusCode ?? 'unknown'} - $message',
      );
    } catch (e, stackTrace) {
      throw Exception('Gagal memuat data mahasiswa: ${e.toString()}');
    }
  }
}
