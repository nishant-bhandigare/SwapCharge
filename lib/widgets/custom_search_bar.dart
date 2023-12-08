import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../data/list_gasStation.dart';
import '../models/gasStation.dart';

class CustomSearchBar extends StatefulWidget {
  CustomSearchBar({super.key, required this.userLocation});

  LatLng userLocation;

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  String searchKey = '';

  List<GasStation> nearestGasStations = [];

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  List<GasStation> calculateDistancesAndSort(LatLng userLocation) {
    List<GasStation> sortedGasStations = List.of(gasStations);

    sortedGasStations.sort((a, b) {
      double distanceA = calculateDistance(userLocation.latitude, userLocation.longitude, a.location.latitude, a.location.longitude);
      double distanceB = calculateDistance(userLocation.latitude, userLocation.longitude, b.location.latitude, b.location.longitude);
      return distanceA.compareTo(distanceB);
    });

    return sortedGasStations;

    // List<GasStation> sortedGasStations = List.of(gasStations);
    //
    // for (int i = 1; i < sortedGasStations.length; i++) {
    //   GasStation key = sortedGasStations[i];
    //   int j = i - 1;
    //
    //   while (j >= 0 && calculateDistance(userLocation.latitude, userLocation.longitude, sortedGasStations[j].location.latitude, sortedGasStations[j].location.longitude) > calculateDistance(userLocation.latitude, userLocation.longitude, key.location.latitude, key.location.longitude)) {
    //     sortedGasStations[j + 1] = sortedGasStations[j];
    //     j = j - 1;
    //   }
    //   sortedGasStations[j + 1] = key;
    // }
    //
    // return sortedGasStations;
  }

  void findNearestGasStations() {
    LatLng userLocation = const LatLng(19.365, 72.810); // Replace with user's location
    List<GasStation> sortedGasStations = calculateDistancesAndSort(userLocation);

    for (GasStation station in sortedGasStations) {
      double distance = calculateDistance(userLocation.latitude, userLocation.longitude, station.location.latitude, station.location.longitude);
      print("${station.name}: ${distance.toStringAsFixed(2)} km");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    searchKey = _searchController.text;
                    if (searchKey == "gasStations"){
                      findNearestGasStations();
                    }
                  });
                },
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}