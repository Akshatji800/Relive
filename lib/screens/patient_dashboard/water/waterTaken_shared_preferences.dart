import 'package:shared_preferences/shared_preferences.dart';
import 'package:mental_health/screens/patient_dashboard/models/waterData.dart';

class WaterPreferencesServices{
  Future saveWaterDetails(WaterData waterD) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('consumed', waterD.consumed);
    await preferences.setString('target', waterD.target);
    await preferences.setString("lastseen", waterD.last_seen);
    await preferences.setString("time", waterD.time);
  }

  Future<WaterData> getFinalDetails() async{
    final preferences = await SharedPreferences.getInstance();
    final consumed = preferences.getString('consumed');
    final target = preferences.getString('target');
    final LastSeen = preferences.getString('lastseen');
    final Time = preferences.getString('time');

    return WaterData(consumed: consumed.toString(), target: target.toString(), last_seen: LastSeen.toString(),time: Time.toString());
  }

}