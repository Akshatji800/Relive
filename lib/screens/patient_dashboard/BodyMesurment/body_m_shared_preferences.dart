import 'package:shared_preferences/shared_preferences.dart';
import 'package:mental_health/screens/patient_dashboard/BodyMesurment/models.dart';

class PreferencesService{
  Future saveFinalDetails(BodyM bodyM) async{
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('height', bodyM.height);
    await preferences.setString('weight', bodyM.weight);
    await preferences.setString('bmw', bodyM.bMW);
    await preferences.setString('bmw_status', bodyM.status);
    await preferences.setString('bmr', bodyM.bMR);
    await preferences.setString('timeAppeared', bodyM.time);
  }

  Future<BodyM> getFinalDetails() async {
    final preferences = await SharedPreferences.getInstance();

    final height = preferences.getString('height');
    final weight = preferences.getString('weight');
    final bmw = preferences.getString('bmw');
    final bmwStatus = preferences.getString('bmwStatus');
    final bmr = preferences.getString('bmr');
    final time = preferences.getString('timeAppeared');

    return BodyM(
        height: height.toString(),
        weight: weight.toString(),
        bMW: bmw.toString(),
        bMR: bmr.toString(),
        status: bmwStatus.toString(),
        time: time.toString()
    );
  }
}