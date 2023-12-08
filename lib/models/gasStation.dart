import 'package:latlong2/latlong.dart';

class GasStation {
  final LatLng location;
  final String name;
  final String sid;

  GasStation({required this.location, required this.name, required this.sid});
}