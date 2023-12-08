import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/list_gasStation.dart';
import '../models/gasStation.dart';
import '../widgets/scale_layer_plugin_option.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/zoombuttons_plugin_option.dart';
import 'battery_station.dart';

class LiveMapScreen extends StatefulWidget {
  const LiveMapScreen({Key? key}) : super(key: key);

  @override
  _LiveMapScreenState createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> {
  LatLng center = const LatLng(19.38331, 72.83106);
  // LatLng center = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final permissionStatus = await Permission.location.status;

    if (permissionStatus != PermissionStatus.granted) {
      await Permission.location.request();
    }

    if (permissionStatus == PermissionStatus.granted) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        center = LatLng(position.latitude, position.longitude);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: 15.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 35.0,
                  height: 35.0,
                  point: center,
                  child: Image.asset("assets/icons/map_pin.png"),
                ),
                ...gasStations.map((station) {
                  return Marker(
                    width: 35.0,
                    height: 35.0,
                    point: station.location,
                    child: InkWell(
                      child: Image.asset("assets/icons/charging-station.png"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BatteryStationScreen(
                            sid: station.sid,
                          ),
                        ));
                      },
                    ),
                  );
                }),
              ],
            ),
            ScaleLayerWidget(
              options: ScaleLayerPluginOption(
                lineColor: Colors.blue,
                lineWidth: 2,
                textStyle: const TextStyle(color: Colors.blue, fontSize: 12),
                padding: const EdgeInsets.all(10),
              ),
            ),
            const FlutterMapZoomButtons(
              minZoom: 4,
              maxZoom: 19,
              mini: true,
              padding: 10,
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
        Column(
          children: [
            CustomSearchBar(userLocation: center,),
          ],
        ),
      ],
    );
  }
}