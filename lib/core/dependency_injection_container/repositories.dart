import 'package:explore_fuel_stations/domain/repositories/fuel_station_repository.dart';

import 'remote_storages.dart';

final fuelStationRepository = FuelStationRepository(fuelStationRemoteStorage: fuelStationRemoteStorage);
