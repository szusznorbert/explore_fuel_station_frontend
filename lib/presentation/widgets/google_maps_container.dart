import 'package:explore_fuel_stations/core/dependency_injection_container/services.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_bloc.dart';
import 'package:explore_fuel_stations/domain/bloc/fuel_station/fuel_station_state.dart';
import 'package:explore_fuel_stations/domain/entities/fuel_station_entity.dart';
import 'package:explore_fuel_stations/presentation/common/toast_message.dart';
import 'package:explore_fuel_stations/presentation/widgets/fuel_station_detail.dart';
import 'package:explore_fuel_stations/presentation/widgets/fuel_station_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsContainer extends StatefulWidget {
  const GoogleMapsContainer({super.key});

  @override
  State<GoogleMapsContainer> createState() => _GoogleMapsContainerState();
}

class _GoogleMapsContainerState extends State<GoogleMapsContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FuelStationBloc, FuelStationState>(
      listener: (context, state) {
        if (state.status == FuelStationEventStatus.error) {
          ToastMessage.displayToastMessage(state.message);
        }
      },
      builder: (context, state) {
        final Set<Marker> markers =
            state.fuelStations
                .map(
                  (station) => Marker(
                    markerId: MarkerId(station.id!),
                    position: LatLng(station.latitude, station.longitude),
                    onTap: () => _showStationDetails(context, station),
                  ),
                )
                .toSet();
        return GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          initialCameraPosition: googleMapsService.initialCameraPosition,
          minMaxZoomPreference: googleMapsService.minMaxZoomPreference,
          compassEnabled: false,
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          rotateGesturesEnabled: false,
          polylines: {},
          markers: markers,
          onMapCreated: (GoogleMapController controller) async {},
          onCameraIdle: () async {},
          onTap: (LatLng position) {
            _showFuelStationModal(context: context, latLng: position);
          },
        );
      },
    );
  }

  void _showStationDetails(BuildContext context, FuelStationEntity station) {
    final bloc = BlocProvider.of<FuelStationBloc>(context, listen: false);
    showModalBottomSheet(context: context, builder: (_) => BlocProvider.value(value: bloc, child: FuelStationDetail(station: station)));
  }

  void _showFuelStationModal({required BuildContext context, required LatLng latLng}) {
    final bloc = BlocProvider.of<FuelStationBloc>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider.value(value: bloc, child: FuelStationForm(position: latLng));
      },
    );
  }
}
