import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:remote_hospital_doctor/screens/login_page.dart';
import 'package:remote_hospital_doctor/screens/home_page.dart';
import 'package:remote_hospital_doctor/screens/identified_page.dart';
import 'package:remote_hospital_doctor/screens/account_page.dart';
import 'package:remote_hospital_doctor/models/yaodian.dart';
import 'package:remote_hospital_doctor/models/doctor.dart';
import 'package:remote_hospital_doctor/services/pref_util.dart';
import 'package:remote_hospital_doctor/screens/prescription_page.dart';
import 'package:remote_hospital_doctor/screens/pres_page.dart';
import 'package:remote_hospital_doctor/screens/history_prescription_page.dart';
import 'package:remote_hospital_doctor/components/doctor/doctor_noreview_list_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remote_hospital_doctor/services/signaling.dart';
import  'package:remote_hospital_doctor/screens/video_page.dart';
import 'package:remote_hospital_doctor/screens/qz_page.dart';
import 'package:remote_hospital_doctor/services/back_desktop_util.dart';
import 'package:flutter_incall_manager/flutter_incall_manager.dart';
import 'package:flutter_incall_manager/incall.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
BuildContext ctx;
void main() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  runApp(RemoteHospitalDoctorApp());
}

  final ThemeData KDefaultTheme = new ThemeData(
    //brightness: Brightness.light,
    primarySwatch: Colors.teal,//Colors.lightBlue,
    //primaryColor: Color(0xFF57B4AE),
    accentColor:Color(0xFF57B4AE),//Colors.lightBlue,//Color(0xFF57B4AE),
  );

class RemoteHospitalDoctorApp extends StatefulWidget {
  @override
  _RemoteHospitalDoctorAppState createState() => _RemoteHospitalDoctorAppState();
}

class _RemoteHospitalDoctorAppState extends State<RemoteHospitalDoctorApp> {
  IncallManager incall = new IncallManager();
  bool _linked=false;
  String _selfId;
  String _displayName;
  static const methodChannel = const MethodChannel('com.daerdo.premed');
  var platform = MethodChannel('crossingthestreams.io/resourceResolver');
  String _result;
  String _status = 'normal';
  Signaling _signaling;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '视频问诊系统医师端',
      theme: KDefaultTheme,
      home:LoginPage(initWebsocket: initWebsocket,),
      routes: {
        "/main":(context)=>MainPage(),
        "/home": (context) => HomePage(),
//        "/register": (context) => RegisterPage(),
        "/login":(context)=>LoginPage(),
        "/video":(context)=>VideoPage(),
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh','CH'),
        const Locale('en','US'),
      ],
    );
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    //initRenderers();
//    getPrefInt("doctorid").then((val1){
//        _selfId="doctor"+val1.toString();
//        return getPrefString("doctorname");
//    }).then((val2){
//       _displayName=val2.toString();
//    }).then((_){
//      _connect();
//      methodChannel.setMethodCallHandler((MethodCall call) async{
//        print(call.method);
//        if (_status == 'close'){
//          print("reconnect");
//          _signaling = null;
//          _connect();
//        }else{
//          _signaling.keepAlive();
//        }
//      });
//    });
  }
   initWebsocket(){
    getPrefInt("doctorid").then((val1){
      _selfId="doctor"+val1.toString();
      return getPrefString("doctorname");
    }).then((val2){
      _displayName=val2.toString();
    }).then((_){
      _connect();
      methodChannel.setMethodCallHandler((MethodCall call) async{
        print(call.method);
        if (_status == 'close'){
          print("reconnect");
          _signaling = null;
          _connect();
        }else{
          _signaling.keepAlive();
        }
      });
    });
  }
  void _connect() async {
    if (_signaling == null) {
      _signaling = new Signaling();
      _signaling.selfId=_selfId;
      _signaling.displayName=_displayName;
      _signaling.connect();
      _signaling.onHeart=(){
        _status="close";
      };
      _signaling.onRegBacking =((val)=>this._linked=true);
      _signaling.onReqComing = ((from){
        print("getting........................");
        _showNotification(from);
        incall.startRingtone('DEFAULT','default',30);
      });
//      _signaling.onResComing = ((from, to, result) {
//        if (result == "1"){
//          _invitePeer(from,false);
//        }else{
//          //todo toast the result
//          print('refuse the request');
//        }
//      });
    }
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {}

  Future<void> onSelectNotification(String payload) async {
   // incall.stopRingback();
    print("taped notification...........................");
    incall.stopRingtone();
//    incall.stop({"bystome":""});
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    _result =  await _showAddressDialog(ctx);
    print(_result);
    this._choose(_result, payload);
  }
  _choose(result,to){
    print(result);
    if(result=="0"){
      _signaling.res(result,to);
    }
    if(result=="1"){
       // Navigator.of(ctx).pushNamed("/video");
        Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext contxt) {
          //指定跳转的页面
          //return QzPage();
          return VideoPage(result: result,to: to,parentContext: context,);//PrescriptionPage(doctor:doctor,prescription: prescription,patient: patient,preMedicine: preMedicines,);
        },));
    }
  }

  Future<void> _showNotification(from) async {

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '13', '呼叫申请', '您有一个诊疗呼叫申请...',
        sound: '',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '呼叫申请', '您有一个诊疗呼叫申请...', platformChannelSpecifics,
        payload: from);
  }

  showDemoDialog<T>({BuildContext context, Widget child}) async {
    return showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
  _showAddressDialog(context) async {
    return showDemoDialog<String>(
        context: context,
        child: Center(
          child: new AlertDialog(
              title: const Text('是否接受连接:'),
              actions: <Widget>[
                new FlatButton(
                    child: const Text('拒绝'),
                    onPressed: () {
                      Navigator.pop(context, '0');
                    }),
                new FlatButton(
                    child: const Text('接受'),
                    onPressed: () {
                      Navigator.pop(context, '1');
                    })
              ]),
        ));
  }


}

class MainPage extends StatefulWidget {
//  Doctor doctor;
//  MainPage({this.doctor});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex=0;
  Doctor doctor=Doctor.name();
  Widget _bodyPage= PresPage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctx=context;

  }
  void _onItemTapped(int index){
    if(mounted){
      setState(() {
        ctx=context;
        _currentIndex=index;
//        if(index==3){
//          _bodyPage=DoctorNoreviewListPage();
//        }
        if(index==0){
          _bodyPage=PresPage();
        }
        if(index==1) {
          _bodyPage = HistoryPrescriptionPage();
        }
        if(index==2){
         Doctor doctor=Doctor.name();
         getPrefInt("ydid").then((val) {
           doctor.yaodian_id = val;
           return getPrefString("ydmc");
         }).then((val) {
           doctor.yaodian_mc = val;
           return getPrefInt("doctorid");
         }).then((val){
           doctor.ID=val;
           return getPrefString("doctorname");
         }).then((val){
           doctor.name=val;
           return getPrefString("zydw");
         }).then((val){
           doctor.zydw=val;
           return getPrefString("dept");
         }).then((val){
           doctor.dept=val;
           return getPrefString("zyzbm");
         }).then((val){
           doctor.zyzbm=val;
           return getPrefString("zgzbm");
         }).then((val){
           doctor.zgzbm=val;
           return getPrefString("sfzh");
         }).then((val){
           doctor.sfzh=val;
           return getPrefString("jianjie");
         }).then((val){
           doctor.jianjie=val;
           return getPrefString("mobile");
         }).then((val){
           doctor.mobile=val;
           return getPrefString("zhuangtai");
         }).then((val){
           doctor.zhuangtai=val;
           return getPrefBool("review");
         }).then((val){
           doctor.review=val;
           return getPrefString("avator_uri");
         }).then((val){
           doctor.avator_uri=val;
           return getPrefString("zyz_uri");
         }).then((val){
           doctor.zyz_uri=val;
           return getPrefString("zgz_uri");
         }).then((val){
           doctor.zgz_uri=val;
           return getPrefString("qz_uri");
         }).then((val){
           doctor.qz_uri=val;
           return getPrefString("username");
         }).then((val){
           doctor.username=val;
           return getPrefString("password");
         }).then((val){
           doctor.password=val;
//           doctor.yaodian_id=1;
//           doctor.yaodian_mc="某大型医药连锁";
           _bodyPage=AccountCenterPage(doctor:doctor);
         });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:BackDesktop.backDesktop,
      child:  Scaffold(
        body:_bodyPage,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            //backgroundColor:Theme.of(context).accentColor ,
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon:Icon(Icons.add_box,size: 28,),
                title:Text("待开处方",style: TextStyle(fontSize: 12)),
                backgroundColor: Theme.of(context).accentColor,
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.blur_linear,size: 28,),
                title:Text("处方记录",style: TextStyle(fontSize: 12)),
                backgroundColor: Theme.of(context).accentColor,
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.supervisor_account,size: 28,),
                  title:Text("账户中心",style: TextStyle(fontSize: 12)),
                  backgroundColor: Theme.of(context).accentColor
              ),
//            BottomNavigationBarItem(
//              icon:Icon(Icons.home,size: 28,),
//              title:Text("医师审核",style: TextStyle(fontSize: 12)),
//              backgroundColor:Theme.of(context).accentColor,
//            ),
            ]
        ),
      )
    );

  }
 }







