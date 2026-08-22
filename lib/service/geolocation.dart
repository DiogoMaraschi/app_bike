import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  String _locationMessage = "Press the button to get location";

  // Core logic to handle permissions and retrieve GPS coordinates
  Future<void> _getCurrentLocation() async {
    try{
      bool serviceEnabled;
      LocationPermission permission;

      // 1. Check if location services are enabled on the device
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _locationMessage = 'Location services are disabled.');
        return;
      }

      // 2. Check and request app-level location permissions
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _locationMessage = 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _locationMessage = 'Permissions are permanently denied.');
        return;
      }

      // 3. Fetch current position when permissions are granted
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('loo $_locationMessage');
      setState(() {

        _locationMessage = "Lat: ${position.latitude}, Long: ${position.longitude}";
      });
    } catch(e){
      print('errou aqui: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geolocator Simple")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_locationMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text("Get Current Location"),
            ),
          ],
        ),
      ),
    );
  }
}
