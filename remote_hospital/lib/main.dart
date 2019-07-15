import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remote_hospital/models/yaodian.dart';
import 'package:remote_hospital/models/mendian.dart';
import 'package:remote_hospital/services/pref_util.dart';
import './screens/login_page.dart';
import 'package:remote_hospital/screens/history_prescription_page.dart';
import './screens/register_page.dart';
import './screens/home_page.dart';
import './screens/zqdj_page.dart';
import './screens/doctor_page.dart';
import './screens/account_page.dart';
import './screens/md_pres_page.dart';
import 'package:flutter/services.dart';
import './screens/second_page.dart';
import 'package:remote_hospital/services/back_desktop_util.dart';
void main() {
  runApp(RemoteHospitalApp());
  //if (Platform.isAndroid) {
//    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//      statusBarColor: Colors.transparent,
//    );
//    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  //}

}

  final ThemeData KDefaultTheme = new ThemeData(
    //brightness: Brightness.light,
    primarySwatch: Colors.teal,
    //primaryColor: Color(0xFF57B4AE),
    accentColor:Color(0xFF57B4AE),
  );


class RemoteHospitalApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    bool isLogin = false;
//    Widget _homePage ;
//    _homePage = isLogin?LoginPage(): MainPage();
////    getPrefString("licence").then((val){
////
////    })

    return MaterialApp(
      theme:KDefaultTheme,
      title:"视频问诊",
      home:LoginPage(),
      routes: {
        "/main":(context)=>MainPage(),
        "/home": (context) => HomePage(),
        "/register": (context) => RegisterPage(),
        "/login":(context)=>LoginPage()
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
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  int _currentIndex=0;
  Widget _bodyPage=MdPresPage();

  void _onItemTapped(int index){
    if(mounted){
      setState(() {
        _currentIndex=index;
        if(index==0){
          _bodyPage=MdPresPage();
//          Yaodian yaodian =Yaodian.name();
//          Mendian mendian=Mendian.name();
//          getPrefInt("ydid").then((val) {
//            mendian.yaodian_id = val;
//            return getPrefString("ydmc");
//          }).then((val){
//            mendian.yaodian_mc = val;
//            return getPrefInt("mdid");
//          }).then((val){
//            mendian.ID=val;
//            return getPrefString("mdmc");
//          }).then((val){
//            mendian.mc=val;
//            print("门店名称:"+mendian.mc);
//            return getPrefString("fzr");
//          }).then((val){
//            mendian.fzr=val;
//            return getPrefString("dianhua");
//          }).then((val){
//            mendian.dianhua=val;
//            return getPrefString("licence");
//          }).then((val){
//            mendian.licence=val;
//            return getPrefString("username");
//          }).then((val){
//            mendian.username=val;
//            _bodyPage=MdPresPage();
//          });
        }
        if(index==1){
          _bodyPage=ZqdjPage();
        }
        if(index==2){
          _bodyPage=HistoryPrescriptionPage();
        }
        if(index==3){
          Yaodian yaodian =Yaodian.name();
          Mendian mendian=Mendian.name();
          getPrefInt("ydid").then((val) {
            mendian.yaodian_id = val;
            return getPrefString("ydmc");
          }).then((val){
            mendian.yaodian_mc = val;
            return getPrefInt("mdid");
          }).then((val){
            mendian.ID=val;
            return getPrefString("mdmc");
          }).then((val){
            mendian.mc=val;
            print("门店名称:"+mendian.mc);
            return getPrefString("fzr");
          }).then((val){
            mendian.fzr=val;
            return getPrefString("dianhua");
          }).then((val){
            mendian.dianhua=val;
            return getPrefString("licence");
          }).then((val){
            mendian.licence=val;
            return getPrefString("yaosshuri");
          }).then((val){
            mendian.yaosshuri=val;
            return getPrefString("username");
          }).then((val){
            mendian.username=val;
            _bodyPage=AccountCenterPage(mendian:mendian);
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
                icon:Icon(Icons.home,size: 28,),
                title:Text("首页",style: TextStyle(fontSize: 12)),
                backgroundColor:Theme.of(context).accentColor,
              ),
              BottomNavigationBarItem(
                icon:Icon(Icons.add_box,size: 28,),
                title:Text("诊前登记",style: TextStyle(fontSize: 12)),
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
            ]
        ),
      )
    );

  }
}

