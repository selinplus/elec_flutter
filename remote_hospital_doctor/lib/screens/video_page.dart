import 'package:flutter/material.dart';
import 'package:flutter_webrtc/rtc_video_view.dart';
import 'package:remote_hospital_doctor/services/signaling.dart';
import 'package:flutter_incall_manager/incall.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
class VideoPage extends StatefulWidget {
  String result;
  String to;
  final parentContext;
  VideoPage({this.result,this.to,this.parentContext});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  IncallManager incall = new IncallManager();
  bool _inCalling=true;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  Signaling _signaling = new Signaling();

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
    //return "";
  }
 void initState() {
   //
//   incall.checkRecordPermission();
//   incall.requestRecordPermission();
//   incall.start({'media':'audio', 'auto': true, 'ringback': ''});

    _signaling.onStateChange = (SignalingState state) {
      switch (state) {
        case SignalingState.CallStateNew:
          this.setState(() {
            _inCalling = true;
          });
          break;
        case SignalingState.CallStateBye:
//          this.setState(() {
          if(_signaling!=null){
            _signaling.doctorClose();
//            _signaling.onRegBacking=null;
            _signaling.onResComing=null;
            _signaling.onStateChange=null;
            _signaling.onLocalStream=null;
            _signaling.onAddRemoteStream =null;
            _signaling.onRemoveRemoteStream =null;
            _signaling=null;
          }

          _localRenderer.srcObject = null;
          _remoteRenderer.srcObject = null;
          _inCalling = false;
            Navigator.pop(context);
//          });
          break;
        case SignalingState.CallStateInvite:
        case SignalingState.CallStateConnected:
        case SignalingState.CallStateRinging:
        case SignalingState.ConnectionClosed:
        case SignalingState.ConnectionError:
        case SignalingState.ConnectionOpen:
          break;
      }
    };
    _signaling.onLocalStream = ((stream) {
      _localRenderer.srcObject = stream;
    });

    _signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
    });

    _signaling.onRemoveRemoteStream = ((stream) {
      _remoteRenderer.srcObject = null;
    });
    initRenderers().then((_){
      print("before....................");
      incall.setSpeakerphoneOn(true);
      print("after....................");
    }).then((_){
      _signaling.res(widget.result,widget.to);
    });

  }

  _hangUp() {
    print("进入挂断......");
    if (_signaling != null) {
      print("进入_signaling挂断......");
      _signaling.bye();
      _signaling.doctorClose();
//      _signaling.onRegBacking=null;
      _signaling.onResComing=null;
      _signaling.onStateChange=null;
      _signaling.onLocalStream=null;
      _signaling.onAddRemoteStream =null;
      _signaling.onRemoveRemoteStream =null;
      _signaling=null;
    }
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
    _inCalling = false;
    // });
    Navigator.pop(context);
  }

  _switchCamera() {
    _signaling.switchCamera();
  }

  _muteMic() {

  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_signaling != null) {
      _signaling.bye();
      _signaling.doctorClose();
//      _signaling.onRegBacking=null;
      _signaling.onResComing=null;
      _signaling.onStateChange=null;
      _signaling.onLocalStream=null;
      _signaling.onAddRemoteStream =null;
      _signaling.onRemoveRemoteStream =null;
      _signaling=null;
    }
    incall.setSpeakerphoneOn(false);
    incall.stop({"bystome":""});
    _localRenderer.srcObject = null;
    _remoteRenderer.srcObject = null;
    _inCalling = false;
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('视频问诊'),
//        actions: <Widget>[
//          IconButton(
//            icon: const Icon(Icons.settings),
//            onPressed: null,
//            tooltip: 'setup',
//          ),
//        ],
//      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: _hangUp,
          tooltip: '挂断',
          child:  Icon(Icons.call_end),
          backgroundColor: Colors.pink,
      ),
//      Container(
//          width: 200.0,
//          child: new Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//
//                IconButton(
//                  icon: const Icon(Icons.switch_camera),
//                  onPressed: _switchCamera,
//                ),
//                IconButton(
//                  onPressed: _hangUp,
////                  tooltip: 'Hangup',
//                  icon:  Icon(Icons.call_end),
//                  //backgroundColor: Colors.pink,
//                ),
//                  IconButton(
//                   icon: const Icon(Icons.mic_off),
//                   onPressed: _muteMic,
//                )
//              ])) ,
      body: OrientationBuilder(builder: (context, orientation) {
        return new Container(
          child: new Stack(children: <Widget>[
            new Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                bottom: 0.0,
                child: new Container(
                  //color:Colors.red,
                  margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: new RTCVideoView(_remoteRenderer),
                  decoration: new BoxDecoration(color: Colors.black54),
                )),
            new Positioned(
              left: 20.0,
              top: 20.0,
              child: new Container(
                width: orientation == Orientation.portrait ? 90.0 : 120.0,
                height:
                orientation == Orientation.portrait ? 120.0 : 90.0,
                child: new RTCVideoView(_localRenderer),
                decoration: new BoxDecoration(color: Colors.black54),
              ),
            ),
          ]),
        );
      })

    );
  }
}
