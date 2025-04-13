import 'package:explore_fuel_stations/core/dependency_injection_container/repositories.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_bloc.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_event.dart';
import 'package:explore_fuel_stations/domain/repositories/fuel_station_repository.dart';
import 'package:explore_fuel_stations/presentation/widgets/google_maps_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => fuelStationRepository,
      child: BlocProvider<FuelStationBloc>(
        create: (context) => FuelStationBloc(fuelStationRepository: context.read<FuelStationRepository>())..add(FetchFuelStations()),
        child: Scaffold(resizeToAvoidBottomInset: true, body: GoogleMapsContainer()),
      ),
    );
  }
}
