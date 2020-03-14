
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const secureStorage = FlutterSecureStorage();

Future<String> getFromStorage(String key) {
  return secureStorage.read(key: key);
}

void writeToStorage(String key, String value) {
  secureStorage.write(key: key, value: value);
}

Future<bool> isInStorage(String key) async {
  final value = await getFromStorage(key);

  return value != null;
}

void removeFromStorage(String key) {
  secureStorage.delete(key: key);
}