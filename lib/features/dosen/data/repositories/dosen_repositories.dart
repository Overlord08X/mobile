import 'dart:convert';

import 'package:test_1/core/network/dio_client.dart';
import 'package:test_1/features/dosen/data/models/dosen_model.dart';
import 'package:dio/dio.dart';

class DosenRepository {
  final DioClient _dioClient;

  DosenRepository({DioClient? dioClient})
    : _dioClient = dioClient ?? DioClient();

  // get data daftar dosen
  Future<List<DosenModel>> getDosenList() async {
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
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;
      final message = e.message;
      throw Exception(
        'Gagal memuat data dosen: ${statusCode ?? 'unknown'} - $message',
      );
    } catch (e, stackTrace) {
      throw Exception('Gagal memuat data dosen: ${e.toString()}');
    }
  }
}
