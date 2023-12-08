// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../widgets/scale_layer_plugin_option.dart';
// import '../widgets/zoombuttons_plugin_option.dart';
// import 'battery_station.dart';
//
// class LiveMapScreen extends StatefulWidget {
//   const LiveMapScreen({Key? key}) : super(key: key);
//
//   @override
//   _LiveMapScreenState createState() => _LiveMapScreenState();
// }
//
// class _LiveMapScreenState extends State<LiveMapScreen> {
//   LatLng _center = const LatLng(19.38331, 72.83106);
//
//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }
//
//   Future<void> _getLocation() async {
//     final permissionStatus = await Permission.location.status;
//
//     if (permissionStatus != PermissionStatus.granted) {
//       await Permission.location.request();
//     }
//
//     if (permissionStatus == PermissionStatus.granted) {
//       final position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         _center = LatLng(position.latitude, position.longitude);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(
//             initialCenter: _center,
//             initialZoom: 15.0,
//           ),
//           children: [
//             TileLayer(
//               urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             ),
//             MarkerLayer(
//               markers: [
//                 Marker(
//                   width: 35.0,
//                   height: 35.0,
//                   point: _center,
//                   child: Image.asset("assets/icons/map_pin.png"),
//                 ),
//                 ...gasStations.map((station) {
//                   return Marker(
//                     width: 35.0,
//                     height: 35.0,
//                     point: station.location,
//                     child: InkWell(
//                       child: Image.asset("assets/icons/charging-station.png"),
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => BatteryStationScreen(
//                             sid: station.sid,
//                           ),
//                         ));
//                       },
//                     ),
//                   );
//                 }),
//               ],
//             ),
//             ScaleLayerWidget(
//               options: ScaleLayerPluginOption(
//                 lineColor: Colors.blue,
//                 lineWidth: 2,
//                 textStyle: const TextStyle(color: Colors.blue, fontSize: 12),
//                 padding: const EdgeInsets.all(10),
//               ),
//             ),
//             const FlutterMapZoomButtons(
//               minZoom: 4,
//               maxZoom: 19,
//               mini: true,
//               padding: 10,
//               alignment: Alignment.bottomRight,
//             ),
//           ],
//         ),
//         Column(
//           children: [
//             SearchBar(),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class GasStation {
//   final LatLng location;
//   final String name;
//   final String sid;
//
//   GasStation({required this.location, required this.name, required this.sid});
// }
//
// List<GasStation> gasStations = [
//   GasStation(
//     location: const LatLng(19.373260, 72.823140),
//     name: "Fort Width\nSwapping Station",
//     sid: "0OvYHUaegRAlVkqHAP9a",
//   ),
//   GasStation(
//     location: const LatLng(19.412240, 72.799680),
//     name: "Brentwood\nSwapping Station",
//     sid: "E6BM4N6LLhORLc3N5YMp",
//   ),
//   GasStation(
//     location: const LatLng(19.373260, 72.823143),
//     name: "Scottsdale\nSwapping Station",
//     sid: "gQ89PuW6pHFcjBSIAoSi",
//   ),
//   GasStation(
//     location: const LatLng(19.366210, 72.815620),
//     name: "Springfield\nSwapping Station",
//     sid: "hCB4lij49D7NuZdEUc3v",
//   ),
//   GasStation(
//     location: const LatLng(19.349660, 72.806092),
//     name: "Fairfield\nSwapping Station",
//     sid: "q0HH9P66avdQNumK4jfI",
//   ),
// ];
//
// class SearchBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//           child: Material(
//             elevation: 5,
//             borderRadius: BorderRadius.circular(25.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   hintText: 'Search',
//                   prefixIcon: Icon(
//                     Icons.search, color: Colors.black,
//
//                   ),
//                   contentPadding: EdgeInsets.symmetric(vertical: 15.0),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Container(
//         //   height: 50, // Adjust the height as needed
//         //   child: SingleChildScrollView(
//         //     child: Row(
//         //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//         //       children: <Widget>[
//         //         _buildFilterChip('Electric'),
//         //         _buildFilterChip('Petrol'),
//         //         // Add more FilterChip widgets for other filters
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   Widget _buildFilterChip(String label) {
//     return Container(
//       // width: 50,
//       height: 40,
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Center(
//         child: Text(label),
//       ),
//     );
//   }
// }