import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:mental_health/screens/patient_dashboard/doctor_appointment/components/agora.config.dart'
    as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MediaChannelRelay Example
class MediaChannelRelay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MediaChannelRelay> {
  late final RtcEngine _engine;
  bool isJoined = false;
  int? remoteUid;
  bool isRelaying = false;
  bool muted = false;
  bool camera = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListener();

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await _engine.joinChannel(config.token, config.channelId, null, 0, null);
  }

  _addListener() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        print('warning ${warningCode}');
      },
      error: (errorCode) {
        print('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        print('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        print('userJoined $uid $elapsed');
        this.setState(() {
          remoteUid = uid;
        });
      },
      userOffline: (uid, reason) {
        print('userOffline $uid $reason');
        this.setState(() {
          remoteUid = null;
        });
      },
      channelMediaRelayStateChanged:
          (ChannelMediaRelayState state, ChannelMediaRelayError code) {
        switch (state) {
          case ChannelMediaRelayState.Idle:
            print('ChannelMediaRelayState.Idle $code');
            this.setState(() {
              isRelaying = false;
            });
            break;
          case ChannelMediaRelayState.Connecting:
            print('ChannelMediaRelayState.Connecting $code)');
            break;
          case ChannelMediaRelayState.Running:
            print('ChannelMediaRelayState.Running $code)');
            this.setState(() {
              isRelaying = true;
            });
            break;
          case ChannelMediaRelayState.Failure:
            print('ChannelMediaRelayState.Failure $code)');
            this.setState(() {
              isRelaying = false;
            });
            break;
          default:
            print('default $code)');
            break;
        }
      },
    ));
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: _onToggleCamera,
            child: Icon(
              camera ? Icons.camera_alt : Icons.camera_enhance_outlined,
              color: camera ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: camera ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onToggleCamera() {
    setState(() {
      camera = !camera;
    });
    _engine.enableLocalVideo(camera);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(children: [
        Column(
          children: [
            !isJoined
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: _initEngine,
                          child: Text('Join channel'),
                        ),
                      )
                    ],
                  )
                : _renderVideo(),
          ],
        )
      ]),
    );
  }

  _renderVideo() {
    return Column(children: [
      AspectRatio(
        aspectRatio: 1.09,
        child: kIsWeb ? RtcLocalView.SurfaceView() : RtcLocalView.TextureView(),
      ),
      AspectRatio(
        aspectRatio: 1.09,
        child: remoteUid != null
            ? (kIsWeb
                ? RtcRemoteView.SurfaceView(
                    uid: remoteUid!,
                    channelId: config.channelId,
                  )
                : RtcRemoteView.TextureView(
                    uid: remoteUid!,
                    channelId: config.channelId,
                  ))
            : Stack(
              children:[ Container(
                  color: Colors.grey[200],
                ),
                _toolbar(),
            ]),
      ),
    ]);
  }
}
