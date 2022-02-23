// ignore_for_file: avoid_print
import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:http/http.dart';
import 'package:google_geocoding/google_geocoding.dart';

class Map extends StatefulWidget{
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map>{
  double _centerLng = 126.8630932;
  double _centerLat = 37.3828698;

  final Completer<GoogleMapController> _controller = Completer();

  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
  
    getPosition();
    
    _markers.add(Marker(
       markerId: const MarkerId("1"),
       draggable: true,
       onTap: () => print("Marker!"),
       position: LatLng(_centerLat, _centerLng)));    

    getPlaceAddress(_centerLat, _centerLng);
  }

  void getPosition() async {
    // ignore: unused_local_variable
    LocationPermission permission = await Geolocator.requestPermission(); //  geolocator 권한 설정
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    try {
      setState(() {
        _centerLng = position.longitude;
        _centerLat = position.latitude;
        print(_centerLng);  
        print(_centerLat);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  // 좌표로 주소를 획득.
  // 찾을 수 없는 지역일 경우 404에러 발생함.
  Future<String?> getPlaceAddress(double lat, double lng) async {
    var googleGeocoding = GoogleGeocoding("AIzaSyAlaan4pahYNACqqgENdWwE96i0CxGsuCA");
    var response = await googleGeocoding.geocoding.getReverse(LatLon(lat,lng));
    if (response != null && response.results != null) {
      if (mounted) {
        setState(() {
          print(response.results);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          
        });
      }
    }
    

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 구글맵, 네이버, 카카오일 경우 조회수에 따라 비용이 발생함.
    // 다만, App일경우 구굴은 비용이 발생하지 않음.
    // 비교하여 정리가 잘되어 있음: https://epdev.tistory.com/8
    return GoogleMap(
        mapType: MapType.normal,
        markers: Set.from(_markers),
        initialCameraPosition: CameraPosition(
          target: LatLng(_centerLat, _centerLng),
          zoom: 19.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
      
      // openmap을 통해서 맵구현
      /*FlutterMap(
      options: MapOptions(
        center: LatLng(_centerLat, _centerLng),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate:"https://api.mapbox.com/styles/v1/choongbeom/ckzs2cm9r004x15qt7r1xrpyl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiY2hvb25nYmVvbSIsImEiOiJja3pzMmFoZ2o2eTFzMm5ua2xrMHRpOGd2In0.a1r46O921ATOhEB-3S4auA",
          additionalOptions: {
              'accessToken': "pk.eyJ1IjoiY2hvb25nYmVvbSIsImEiOiJja3pzMml5a3Uwb2V3MnZvOW9weDE5cWUwIn0.kNMMbsJPa93nuPRVop0eVg",
              'id': "mapbox.mapbox-streets-v8"
          }
        ),
        MarkerLayerOptions(markers: [
              Marker(
                width: 30.0,
                height: 30.0,
                point: LatLng(_centerLat,_centerLng),
                builder: (context) => Image.asset('assets/images/profile.png'))
        ]),
      ],
    );*/

  }
}