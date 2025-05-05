// import 'package:geolocator/geolocator.dart';
//
// class LocationManager{
//   static Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied ||
//         permission==LocationPermission.deniedForever) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       var reult= await Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     var location=await Geolocator.getCurrentPosition();
//     print(location.toString());
//     return location;
//   }
// }