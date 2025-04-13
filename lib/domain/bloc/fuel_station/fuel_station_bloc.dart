import 'package:explore_fuel_stations/core/common/failure/failure.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_event.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_state.dart';
import 'package:explore_fuel_stations/domain/repositories/fuel_station_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuelStationBloc extends Bloc<FuelStationEvent, FuelStationState> {
  final FuelStationRepository fuelStationRepository;

  FuelStationBloc({required this.fuelStationRepository}) : super(const FuelStationState()) {
    on<FetchFuelStations>(_mapFetchFuelStationsEventToState);
    on<AddFuelStation>(_mapAddFuelStationEventToState);
    on<UpdateFuelStation>(_mapUpdateFuelStationEventToState);
    on<DeleteFuelStation>(_mapDeleteFuelStationEventToState);
  }

  Future<void> _mapFetchFuelStationsEventToState(FetchFuelStations event, Emitter<FuelStationState> emit) async {
    emit(state.copyWith(status: FuelStationEventStatus.loading));
    try {
      final fuelStations = await fuelStationRepository.getAllFuelStations();
      emit(state.copyWith(status: FuelStationEventStatus.loaded, fuelStations: fuelStations));
    } on Failure catch (error) {
      emit(state.copyWith(status: FuelStationEventStatus.error, message: error.message));
    }
  }

  Future<void> _mapAddFuelStationEventToState(AddFuelStation event, Emitter<FuelStationState> emit) async {
    try {
      emit(state.copyWith(status: FuelStationEventStatus.loading));
      final fuelStationId = await fuelStationRepository.addFuelStation(event.fuelStation);
      final updatedFuelStations = [...state.fuelStations, event.fuelStation.copyWith(id: fuelStationId)];
      emit(
        state.copyWith(
          status: FuelStationEventStatus.created,
          fuelStations: updatedFuelStations,
          message: 'Fuel station created successfully',
        ),
      );
    } on Failure catch (error) {
      emit(state.copyWith(status: FuelStationEventStatus.error, message: error.message));
    }
  }

  void _mapUpdateFuelStationEventToState(UpdateFuelStation event, Emitter<FuelStationState> emit) async {
    try {
      emit(state.copyWith(status: FuelStationEventStatus.loading));
      final updatedFuelStations =
          state.fuelStations.map((station) => station.id == event.fuelStation.id ? event.fuelStation : station).toList();
      await fuelStationRepository.updateFuelStationById(event.fuelStation);
      emit(
        state.copyWith(
          status: FuelStationEventStatus.updated,
          fuelStations: updatedFuelStations,
          message: 'Fuel station updated successfully',
        ),
      );
    } on Failure catch (error) {
      emit(state.copyWith(status: FuelStationEventStatus.error, message: error.message));
    }
  }

  void _mapDeleteFuelStationEventToState(DeleteFuelStation event, Emitter<FuelStationState> emit) async {
    try {
      emit(state.copyWith(status: FuelStationEventStatus.loading));
      final updatedFuelStations = state.fuelStations.where((station) => station.id != event.fuelStationId).toList();
      await fuelStationRepository.deleteFuelStationById(event.fuelStationId);
      emit(
        state.copyWith(
          status: FuelStationEventStatus.deleted,
          fuelStations: updatedFuelStations,
          message: 'Fuel station deleted successfully',
        ),
      );
    } on Failure catch (error) {
      emit(state.copyWith(status: FuelStationEventStatus.error, message: error.message));
    }
  }
}
