import 'package:explore_fuel_stations/core/common/failure/fuel_repository_failure.dart';
import 'package:explore_fuel_stations/data/remote_storage/fuel_station_remote_storage.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';

class FuelStationRepository {
  final FuelStationRemoteStorage _fuelStationRemoteStorage;

  FuelStationRepository({required FuelStationRemoteStorage fuelStationRemoteStorage})
    : _fuelStationRemoteStorage = fuelStationRemoteStorage;

  Future<List<FuelStationEntity>> getAllFuelStations() async {
    try {
      final fuelStations = await _fuelStationRemoteStorage.fetchAll();
      return fuelStations.map((station) => FuelStationEntity.fromDto(station)).toList();
    } catch (error) {
      throw FuelRepositoryFailure.create();
    }
  }

  Future<void> updateFuelStationById(FuelStationEntity fuelStation) async {
    try {
      final fuelStationDto = fuelStation.toDto();
      final id = fuelStationDto.id;
      await _fuelStationRemoteStorage.update(id, fuelStationDto);
    } catch (error) {
      throw FuelRepositoryFailure.update();
    }
  }

  Future<void> deleteFuelStationById(String id) async {
    try {
      await _fuelStationRemoteStorage.delete(id);
    } catch (error) {
      throw FuelRepositoryFailure.delete();
    }
  }

  Future<String> addFuelStation(FuelStationEntity fuelStation) async {
    try {
      return await _fuelStationRemoteStorage.insert(fuelStation.toDto());
    } catch (error) {
      throw FuelRepositoryFailure.create();
    }
  }
}
