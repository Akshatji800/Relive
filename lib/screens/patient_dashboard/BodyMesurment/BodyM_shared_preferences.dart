import 'package:shared_preferences/shared_preferences.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/models.dart';

class PreferencesService{
  Future saveFinalDetails(BodyM bodyM) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('height', bodyM.height);
    await preferences.setString('weight', bodyM.weight);
    await preferences.setString('bmw', bodyM.BMW);
    await preferences.setString('bmw_status', bodyM.Status);
    await preferences.setString('bmr', bodyM.BMR);
    await preferences.setString('time', bodyM.Time);
    print("Saved Details");
  }

  Future<BodyM> getFinalDetails() async {
    final preferences = await SharedPreferences.getInstance();

    final height = preferences.getString('height');
    final weight = preferences.getString('weight');
    final bmw = preferences.getString('bmw');
    final bmw_status = preferences.getString('bmw_status');
    final bmr = preferences.getString('bmr');
    final time = preferences.getString('time');


    return BodyM(
        height: height.toString(),
        weight: weight.toString(),
        BMW: bmw.toString(),
        BMR: bmr.toString(),
        Status: bmw_status.toString(),
        Time: time.toString()
    );
  }
}