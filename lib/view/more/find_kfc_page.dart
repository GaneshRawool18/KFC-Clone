import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart'; // For location fetching
import 'package:permission_handler/permission_handler.dart'; // For requesting permissions

class FindAKfc extends StatefulWidget {
  @override
  _FindAKfcState createState() => _FindAKfcState();
}

class _FindAKfcState extends State<FindAKfc> {
  LatLng _currentLocation = const LatLng(18.5204, 73.8567); // Default to Pune
  final TextEditingController _locationController = TextEditingController();
  bool _useMyLocation = false;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: _currentLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        draggable: true,
        onDragEnd: (newPosition) {
          setState(() {
            _currentLocation = newPosition;
          });
        },
      ),
    );
  }

  // Function to get the current location of the device
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _useMyLocation = true;
        _markers = {
          Marker(
            markerId: const MarkerId('current_location'),
            position: _currentLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            draggable: true,
            onDragEnd: (newPosition) {
              setState(() {
                _currentLocation = newPosition;
              });
            },
          ),
        };
      });
    } catch (e) {
      print("Error getting location: $e");
      // Handle permission denial or location error
    }
  }

  // Function to request location permission dynamically
  Future<void> _requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else if (status.isDenied) {
      // You can show a dialog asking the user to go to settings if permission is denied
      print("Location permission denied");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _animateToLocation(LatLng location) {
    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(location, 15));
    setState(() {
      _currentLocation = location;
      _markers = {
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          draggable: true,
          onDragEnd: (newPosition) {
            setState(() {
              _currentLocation = newPosition;
            });
          },
        ),
      };
    });
  }

  void _useCurrentDeviceLocation() {
    _requestLocationPermission(); // Request and fetch the current location
    _locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'FIND A KFC',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter your location',
                      prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _locationController.clear();
                          setState(() {
                            _useMyLocation = false;
                            _currentLocation = const LatLng(18.5204, 73.8567);
                            _markers = {
                              Marker(
                                markerId: const MarkerId('current_location'),
                                position: _currentLocation,
                                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                                draggable: true,
                                onDragEnd: (newPosition) {
                                  setState(() {
                                    _currentLocation = newPosition;
                                  });
                                },
                              ),
                            };
                            _animateToLocation(_currentLocation);
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                ElevatedButton(
                  onPressed: () {
                    final selectedLocation = _locationController.text.isNotEmpty
                        ? _locationController.text
                        : '${_currentLocation.latitude}, ${_currentLocation.longitude}';
                    // Here we assume an AddressProvider is used to handle location data
                    Get.back(); // Go back to the previous page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 13.0,
                  ),
                  markers: _markers,
                  myLocationEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    size: isSmallScreen ? 40 : 50,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.02,
                  right: screenWidth * 0.02,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'zoom_in',
                        mini: true,
                        onPressed: () {
                          _mapController?.animateCamera(CameraUpdate.zoomIn());
                        },
                        child: const Icon(Icons.add),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      FloatingActionButton(
                        heroTag: 'zoom_out',
                        mini: true,
                        onPressed: () {
                          _mapController?.animateCamera(CameraUpdate.zoomOut());
                        },
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.02,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Google'),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: const Text(
                      'Place the pin at your location.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
