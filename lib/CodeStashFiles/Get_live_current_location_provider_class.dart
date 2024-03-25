/*
     LocationProvider Class

  This Dart file defines a 'LocationProvider' class responsible for managing the user's location .
  It uses the 'geolocator' and 'geocoding' packages to obtain and process location data in real-time.

  Functionalities:
  - Retrieves and updates the user's current location and address in real-time.
  - Utilizes the 'Geolocator' package to subscribe to location changes.
  - Updates user data in the 'AuthProvider' class using the 'updateUserData' method.
  - Implements 'getCurrentLocation' to continuously monitor the user's location.
  - Converts latitude and longitude into a human-readable address using 'getAddressFromLatLng'.

  Properties:
  - _loading: Indicates whether a location-related process is in progress.
  - _currentPosition: Holds the user's current position (latitude and longitude).
  - _currentAddress: Holds the human-readable address corresponding to the current position.

  Methods:
  - setLoading: Sets the loading state and notifies listeners.
  - getCurrentLocation: Listens for changes in the device's location and updates user data accordingly.
  - getAddressFromLatLng: Converts a given 'LatLng' coordinate into a human-readable address.

  Dependencies:
  - 'geolocator': Used for obtaining the device's location.
  - 'geocoding': Used for converting coordinates to addresses.

     Date : [17/01/2024]
*/

import 'package:bool/Controller/Provider/authProvider/authProvider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../View/Imports/imports.dart';

class LocationProvider with ChangeNotifier {
  //------------ PROPERTIES -----------
  Position? _currentPosition;
  String? _currentAddress;
  bool _loading = false;
  final AuthProvider authProvider = AuthProvider();

  // ------------- METHODS ----------

  // getter for loading  --->
  get loading => _loading;

  // setter for loading  --->
  void setLoading(bool value) {
    _loading = value;
    Future.microtask(() => notifyListeners());
  }
  // getter for  Position --->
  Position? get currentPosition => _currentPosition;

  // getter for  currentAddress --->
  String? get currentAddress => _currentAddress;

  //  setter for currentAddress --->
  set currentAddress(String? value) {
    _currentAddress = value;
    notifyListeners();
  }
  // constructor for getCurrentLocation ----->
  LocationProvider() {
    getCurrentLocation();
  }

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 7,
  );


  // function to get current location of user in realtime  ---->
  Future<void> getCurrentLocation() async {
    setLoading(true);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) async {
      authProvider.updateUserData(position?.latitude, position?.longitude);

      if (position != null) {
        _currentPosition = position;
        // await saveLocationLocally(position);
        String? address = await getAddressFromLatLng(
            LatLng(position.latitude, position.longitude));
        _currentAddress = address;
        setLoading(false);
      }
    });
  }
      // This function will find to Address fro, lat lng
  Future<String?> getAddressFromLatLng(LatLng latLng) async {
    try {
      if (latLng.toString().isEmpty) {
        return currentAddress = "";
      } else {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

        Placemark place = placemarks[0];
        String? name = place.name;
        String? Streats = place.street;
        String? subLocality = place.subLocality;
        String? locality = place.locality;
        String? administrativeArea = place.administrativeArea;
        String? postalCode = place.postalCode;
        String? country = place.country;
        if (name != null &&
            subLocality != null &&
            locality != null &&
            administrativeArea != null &&
            postalCode != null &&
            country != null) {
          currentAddress =
              "$name, $Streats, $locality, $administrativeArea $postalCode, $country"; //here you can used place.country and other things also
          return currentAddress;
        } else {
          return currentAddress = "";
        }
      }
    } catch (e) {
      return "";
    }
  }
}
