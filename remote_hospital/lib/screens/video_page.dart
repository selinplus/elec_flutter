import 'package:flutter/material.dart';
import 'package:flutter_webrtc/rtc_video_view.dart';
import 'package:remote_hospital/services/signaling.dart';
import 'package:remote_hospital/services/pref_util.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:flutter_incall_manager/incall.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class VideoPage extends StatefulWidget {
  String doctor_id;
  VideoPage({this.doctor_id});
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  static AudioCache player = AudioCache(prefix: 'audios/');
  AudioPlayer  ap;
  IncallManager incall = new IncallManager();
  bool callStatus=false;
  bool _inCalling=true;
  String _status;
  Signaling _signaling;
  //final String serverIP = "ytkeno.top";
  var _selfId;
  String _displayName;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.loop('callwait.mp3').then((val){
      ap=val;
     return initRenderers();
    }).then((_){
      return getPrefInt("mdid");
    }).then((val1){
      _selfId="md"+val1.toString();
      return getPrefString("mdmc");
    }).then((val2){
      _displayName=val2.toString();
      //incall.start({'media':'audio', 'auto': true, 'ringback': ''});
      incall.setSpeakerphoneOn(true);//setForceSpeakerphoneOn(true);
    }).then((_) {
      print("connect");
      _connect();
    });
  }
  void _connect() async {
    if (_signaling == null) {
      _signaling = new Signaling();
      _signaling.selfId=_selfId;
      _signaling.displayName=_displayName;
      _signaling.connect();

      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            this.setState(() {
              _inCalling = true;
            });
            break;
          case SignalingState.CallStateBye:
            if(_signaling!=null){
              _signaling.close();
              _signaling.onRegBacking=null;
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
              break;
          case SignalingState.CallStateInvite:
          case SignalingState.CallStateConnected:
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
            _status = 'close';
            break;
          case SignalingState.ConnectionError:
            _status = 'close';
            break;
          case SignalingState.ConnectionOpen:
            break;
        }
      };
      //_signaling.onReqComing = ((from)=>_showNotification(from));
      _signaling.onRegBacking =((val)=>_reqPeer(context, widget.doctor_id, false));
      _signaling.onResComing = ((from, to, result) {
        if (result == "1"){
          ap.stop();
           setState(() {
             callStatus=true;
           });
          _invitePeer(from,false);
        }else{
          //todo toast the result
          print('refuse the request');
          if(_signaling!=null){
            _signaling.close();
            _signaling.onRegBacking=null;
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
          Fluttertoast.showToast(
              msg: '对方已拒绝',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white
          );
          Navigator.pop(context);
        }
      });

      _signaling.onLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    }
  }
  _reqPeer(context, peerId, use_screen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.req(peerId);
    }
  }
  _invitePeer(peerId, use_screen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', use_screen);
    }
  }
  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }
  _hangUp() {
    print("进入挂断......");
    if (_signaling != null) {
      print("进入_signaling挂断......");
      _signaling.bye();
      _signaling.close();
      _signaling.onRegBacking=null;
      _signaling.onResComing=null;
      _signaling.onStateChange=null;
      _signaling.onLocalStream=null;
      _signaling.onAddRemoteStream =null;
      _signaling.onRemoveRemoteStream =null;
      _signaling=null;
    }
       ap.stop();
      _localRenderer.srcObject = null;
      _remoteRenderer.srcObject = null;
      _inCalling = false;
      // });
      Navigator.pop(context);

  }
  void dispose() {
    // TODO: implement dispose
    if (_signaling != null) {
      _signaling.bye();
      _signaling.close();
      _signaling.onRegBacking=null;
      _signaling.onResComing=null;
      _signaling.onStateChange=null;
      _signaling.onLocalStream=null;
      _signaling.onAddRemoteStream =null;
      _signaling.onRemoveRemoteStream =null;
      _signaling=null;
    }
    player.clear('callwait.mp3');
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
        body: !callStatus?Container(
          alignment: Alignment.center,
          color: Colors.black,
          child: Text("正在等待对方接受请求......",style: TextStyle(color: Theme.of(context).accentColor),),
          constraints: BoxConstraints.expand(),
        ): OrientationBuilder(builder: (context, orientation) {
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
