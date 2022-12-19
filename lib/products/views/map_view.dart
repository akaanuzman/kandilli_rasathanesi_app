import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kandilli_rasathanesi_app/products/models/earthquake_model.dart';

class EarthquakeMapView extends StatefulWidget {
  final EarthquakeModel model;
  const EarthquakeMapView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<EarthquakeMapView> createState() => EarthquakeMapViewState();
}

class EarthquakeMapViewState extends State<EarthquakeMapView> {
  late final EarthquakeModel _model;
  late final CameraPosition _cameraPosition;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    _model = widget.model;
    _initCameraPosition;
    super.initState();
  }

  void get _initCameraPosition {
    if (_model.lat != null && _model.lng != null) {
      double latitude = _model.lat!.toDouble();
      double longitude = _model.lng!.toDouble();
      double zoom = 14.0;
      _cameraPosition = CameraPosition(
        target: LatLng(
          latitude,
          longitude,
        ),
        zoom: zoom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInLeft(
          child: Text("${_model.lokasyon}"),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
