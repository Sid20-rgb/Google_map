import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({
    Key? key, // Remove super.key here
  }) : super(key: key);

  @override
  State<AddRoom> createState() => _AddRoomState();
}

TextEditingController title = TextEditingController();
TextEditingController price = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController location = TextEditingController();
TextEditingController description = TextEditingController();
TextEditingController amenitites = TextEditingController();
TextEditingController capacity = TextEditingController();
TextEditingController exactLocation = TextEditingController();
TextEditingController preferences = TextEditingController();

class _AddRoomState extends State<AddRoom> {
  SizedBox gap() {
    return const SizedBox(
      height: 10,
    );
  }

  File? _image;

  bool isChecked = false;
  // Track whether the user agreed to terms
  final bool _isObscure = true;
  double? latitude;
  double? longitude; // Define it as nullable

  final pinkey = GlobalKey<FormState>();

  LatLng? selectedLocation;
  Set<Marker> markers = {};

  bool isMapExpanded = false;
  // Function to toggle map expansion
  void toggleMapExpansion() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    String hexColor = "#E5E5E5";
    Color color =
        Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Column(
                children: [
                  const Row(
                    children: [
                      SizedBox(
                        width: 250,
                      ),
                    ],
                  ),
                  gap(),
                  const Column(
                    children: [
                      Text(
                        'List new room/flats ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'List in the market where listers are waiting ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: pinkey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... Your existing form fields ...
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: TextFormField(
                    key: const ValueKey('title'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter property title ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Property title',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              gap(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: TextFormField(
                    key: const ValueKey('price'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter the price ';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'price',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              gap(),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: color,
                        ),
                        child: TextFormField(
                          key: const ValueKey('address'),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Address',
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 16, 16, 16),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: color,
                        ),
                        child: TextFormField(
                          key: const ValueKey('location'),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please enter location';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Location',
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 16, 16, 16),
                            ),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              gap(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: TextFormField(
                    key: const ValueKey('exact location'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a exact location';
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Exact location',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              gap(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: TextFormField(
                    key: const ValueKey('amenities'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a amenities';
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'amenities',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              gap(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: TextFormField(
                    key: const ValueKey('capacity'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a capacity';
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'capacity',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),
              gap(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: TextFormField(
                    key: const ValueKey('description'),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    maxLines: null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 16, 16, 16),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                    ),
                    cursorColor: Colors.black,
                  ),
                ),
              ),

              gap(),

              // Map for selecting location
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        key: const ValueKey('preferences'),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Please enter your preferences ';
                          }
                          return null;
                        },
                        maxLines: null,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Preference',
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 16, 16, 16),
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
                        ),
                        cursorColor: Colors.black,
                      ),
                      const SizedBox(height: 10), // Add some spacing
                      if (selectedLocation != null)
                        Text(
                          'Latitude: ${selectedLocation!.latitude.toStringAsFixed(6)}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      if (selectedLocation != null)
                        Text(
                          'Longitude: ${selectedLocation!.longitude.toStringAsFixed(6)}',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      SizedBox(
                        height: isMapExpanded ? screenHeight : 200,
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(
                                    27.7172, 85.3240), // Kathmandu coordinates
                                zoom: 15, // Set the initial zoom level
                              ),
                              markers: markers,
                              onTap: (LatLng position) {
                                // When the user taps on the map, update the selected location
                                setState(() {
                                  selectedLocation = position;
                                  markers.clear();
                                  markers.add(Marker(
                                    markerId: const MarkerId('selectedLocation'),
                                    position: selectedLocation!,
                                  ));
                                });
                              },
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: toggleMapExpansion,
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  // decoration: BoxDecoration(
                                  //   color: Colors.blue,
                                  //   borderRadius: BorderRadius.circular(28),
                                  // ),
                                  child: Icon(
                                    isMapExpanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              

            ],
          ),
        ),
      ),
            ],
        )
      ),
      ),
    );
  }
}
