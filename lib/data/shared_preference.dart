import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();
  static final _instance = SharedPreference._();
  static SharedPreference get instance => _instance;

  static const String isLogged = 'loginCheck';
  static const String profilePic = 'profilePic';

  late SharedPreferences sharedPref;

  initStorage() async => sharedPref = await SharedPreferences.getInstance();

  storeToken(hostToken) async {
    await sharedPref.setString(isLogged, hostToken);
  }

  String? getToken() => sharedPref.getString(isLogged);

  storeProfile(profile) async {
    await sharedPref.setString(profilePic, profile);
  }

  String? getProfile() => sharedPref.getString(profilePic);
}
