import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:led_control_app/models/led.dart';
import 'package:led_control_app/providers/data_provider.dart';
import 'package:led_control_app/utils/app_color.dart';
import 'package:led_control_app/utils/patten.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? currentPosition;
  GoogleMapController? mapController;
  LatLng _center = const LatLng(10.879584309969259, 106.8069217975916);
  Set<Marker> markers = {};
  BitmapDescriptor iconImage = BitmapDescriptor.defaultMarker;

  void initMarkerIcon() async {
    iconImage = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/light.png');
    setState(() {});
  }

  getLocation() async {
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _center = location;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocation();
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
        child: Consumer<DataProvider>(builder: (context, state, child) {
          var items = state.groups[0].leds;
          markers = {};
          for (var item in items) {
            final position = LatLng(item.lat, item.lon);
            markers.add(Marker(
              onTap: () {
                final tmpPosition = LatLng(item.lat - 0.0002, item.lon);
                currentPosition = tmpPosition;
                showModalSheet(item);
              },
              icon: iconImage,
              position: position,
              markerId: MarkerId(position.toString()),
            ));
          }
          return GoogleMap(
            trafficEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },
            markers: markers,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          );
        }),
      ),
    );
  }

  void showModalSheet(Led item) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                padding: contentPadding,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {}, child: const Text('Cancel')),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.ios_share)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: detailInfoWidget(
                                Icons.device_thermostat,
                                '${item.temp.toString()} °C',
                                AppColors.gradientRed)),
                        Expanded(
                            child: detailInfoWidget(
                                Icons.water_drop,
                                '${item.humi.toString()} %',
                                AppColors.gradientBlue))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: detailInfoWidget(
                                Icons.text_rotation_angledown,
                                item.incli.toString(),
                                AppColors.gradientGreen)),
                        Expanded(
                            child: detailInfoWidget(Icons.network_check,
                                item.rsrp.toString(), AppColors.gradientPurple))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailScreen(
                      //       led: item,
                      //     ),
                      //   ),
                      // );
                    },
                    label: const Text(
                      "View Detail",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.menu_open_outlined,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007AFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget detailInfoWidget(IconData icon, String value, List<Color> listColors) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(9.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: listColors,
          ),
          borderRadius: BorderRadius.circular(9)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
