import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:led_control_app/utils/patten.dart';

class MapRepairScreen extends StatefulWidget {
  final LatLng location;
  const MapRepairScreen({super.key, required this.location});
  @override
  State<MapRepairScreen> createState() => _MapRepairScreenState();
}

class _MapRepairScreenState extends State<MapRepairScreen> {
  LatLng? currentPosition;
  GoogleMapController? mapController;
  late LatLng _center;
  Set<Marker> markers = {};
  BitmapDescriptor iconImage = BitmapDescriptor.defaultMarker;

  void initMarkerIcon() async {
    iconImage = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/light.png');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _center = widget.location;
    markers.add(Marker(
      onTap: () {},
      icon: iconImage,
      position: _center,
      markerId: MarkerId(_center.toString()),
    ));
    initMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 0.5,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          margin: contentPadding,
          padding: contentPadding,
          child: GoogleMap(
            trafficEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: markers,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          )),
    );
  }
}
