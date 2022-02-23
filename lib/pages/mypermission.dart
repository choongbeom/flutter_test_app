import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPermission extends StatefulWidget{
  const MyPermission({Key? key}) : super(key: key);

  @override
  _PermissionState createState() => _PermissionState();
}

class _PermissionState extends State<MyPermission>{
  
  @override
  void initState() {
    super.initState();

    //callPermission();
    getStatuses();
  }

  // 단일 권한 부여 및 체크
  void callPermission() async {
    var status = await Permission.locationAlways.request();
  
    if (status.isGranted) {
      // ignore: avoid_print
      print('권한이 부여되었습니다.');
    }

    if(status.isDenied) {
      // ignore: avoid_print
      print('권한 부여가 거부되었습니다.');
    }

    if(status.isPermanentlyDenied) {
      // ignore: avoid_print
      print('권한 부여가 영구적으로 거부되었습니다.');
    }

    if(status.isRestricted || status.isLimited) {
      // ignore: avoid_print
      print('권한이 제한되었습니다.');
    }
  }

  // 여러개 권한 부여시 사용
  Future<bool> getStatuses() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera, Permission.location].request();

  if (statuses.values.every((element) => element.isGranted)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}