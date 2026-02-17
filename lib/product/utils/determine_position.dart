import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

Future<Either<String, Position>> getUserPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    return const Left('Lütfen Telefonunuzun Konum Servisini Açın.');
  } else {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        return const Left('Lütfen Uygulamanın Konum Servisine Erişmesine İzin Verin.');
      } else {
        final location = await Geolocator.getCurrentPosition();
        return Right(location);
      }
    } else {
      final location = await Geolocator.getCurrentPosition();
      return Right(location);
    }
  }
}
