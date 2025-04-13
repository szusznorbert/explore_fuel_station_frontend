import 'package:explore_fuel_stations/core/dependency_injection_container/network.dart';
import 'package:explore_fuel_stations/data/remote_storage/fuel_station_remote_storage.dart';

final fuelStationRemoteStorage = FuelStationRemoteStorage(dio: dioClient.backendDio);
