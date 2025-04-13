import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsService {
  GoogleMapsService();

  static const _minZoom = 2.0;
  static const _defaultZoom = 8.0;
  static const _maxZoom = 18.0;

  CameraPosition get initialCameraPosition => const CameraPosition(target: LatLng(47.3943939, 8), zoom: _defaultZoom);
  MinMaxZoomPreference get minMaxZoomPreference => const MinMaxZoomPreference(_minZoom, _maxZoom);
}
