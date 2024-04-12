import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Static Location Map',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Static Location Map'),
        ),
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Static Location: Latitude 37.7749, Longitude -122.4194',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: MapWidget(
                latitude: 27.6922368,
                longitude: 85.3213184,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapWidget({super.key, required this.latitude, required this.longitude});

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
          final LatLng location = LatLng(widget.latitude, widget.longitude);
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(location, 14.0),
          );
        });
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 14.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('staticMarker'),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: const InfoWindow(title: 'Static Location'),
        ),
      },
    );
  }
}
