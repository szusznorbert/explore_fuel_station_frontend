import 'package:equatable/equatable.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';

enum FuelStationEventStatus { initial, loading, loaded, created, updated, deleted, error }

class FuelStationState extends Equatable {
  final FuelStationEventStatus status;
  final List<FuelStationEntity> fuelStations;
  final String selectedId;
  final String message;

  const FuelStationState({
    this.status = FuelStationEventStatus.initial,
    this.fuelStations = const [],
    this.selectedId = '',
    this.message = '',
  });

  @override
  List<Object?> get props => [status, fuelStations, selectedId];

  FuelStationState copyWith({FuelStationEventStatus? status, List<FuelStationEntity>? fuelStations, String? selectedId, String? message}) {
    return FuelStationState(
      status: status ?? this.status,
      fuelStations: fuelStations ?? this.fuelStations,
      selectedId: selectedId ?? this.selectedId,
      message: message ?? this.message,
    );
  }
}
