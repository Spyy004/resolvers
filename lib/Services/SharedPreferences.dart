import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveToken({String saveKey, String saveValue}) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.setString(saveKey, saveValue);
  if (value != null) {
    return true;
  } else {
    return false;
  }
}

Future<String>getToken({String key})async
{
  final prefs = await SharedPreferences.getInstance();
  final getkey = '$key';
  final value = prefs.getString(getkey)?? null;
  print("THIS IS TOKEN IN SPREF");
  print(value);
  return value;
}