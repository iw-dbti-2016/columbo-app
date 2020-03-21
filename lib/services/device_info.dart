import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  const DeviceInfo();

  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

  Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      return deviceInfoPlugin.androidInfo.then((value) => value.display);
    } else if (Platform.isIOS) {
      return deviceInfoPlugin.iosInfo.then((value) => value.name);
    } else if (Platform.isWindows) {
      return 'Windows';
    } else if (Platform.isMacOS) {
      return 'MaxOS';
    } else if (Platform.isLinux) {
      return 'Linux';
    } else {
      return 'Others';
    }
  }
}
