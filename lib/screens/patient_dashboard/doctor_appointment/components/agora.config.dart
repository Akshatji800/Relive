import 'package:mental_health/screens/patient_dashboard/doctor_appointment/screens/token_maker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Get your own App ID at https://dashboard.agora.io/
String appId = env['AGORA_APP_ID'].toString();

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String token = updatedtoken;

/// Your channel ID
String channelId = channelNameEntered;

/// Your int user ID
const uid = 0;

/// Your string user ID
const stringUid = 'Akshatji';
