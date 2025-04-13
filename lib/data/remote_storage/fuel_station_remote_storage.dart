import 'dart:async';

import 'package:dio/dio.dart';
import 'package:explore_fuel_stations/data/dtos/fuel_station_dto.dart';

class FuelStationRemoteStorage {
  final Dio _dio;
  final String _path = '/fuel-station';

  FuelStationRemoteStorage({required Dio dio}) : _dio = dio;

  Future<List<FuelStationDto>> fetchAll() async {
    try {
      final response = await _dio.get(_path);
      final List data = response.data as List;
      return data.map((json) => FuelStationDto.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load fuel stations: $e');
    }
  }

  Future<String> insert(FuelStationDto dto) async {
    try {
      final json = dto.toJson();
      final response = await _dio.post(_path, data: json, options: Options(validateStatus: (status) => status == 201));
      return response.data['id'] as String;
    } catch (e) {
      throw Exception('Failed to insert fuel station: $e');
    }
  }

  Future<void> update(String id, FuelStationDto dto) async {
    try {
      final json = dto.toJson();
      await _dio.put('$_path/$id', data: json, options: Options(validateStatus: (status) => status == 200));
    } catch (e) {
      throw Exception('Failed to update fuel station: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await _dio.delete('$_path/$id', options: Options(validateStatus: (status) => status == 200));
    } catch (e) {
      throw Exception('Failed to delete fuel station: $e');
    }
  }
}
