import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remote_hospital_manager/services/pref_util.dart';
import 'package:remote_hospital_manager/screens/login_page.dart';
import 'package:remote_hospital_manager/screens/doctor_noreview_list_page.dart';
import 'package:remote_hospital_manager/screens/doctor_review_list_page.dart';
import 'package:remote_hospital_manager/screens/account_page.dart';
import 'package:remote_hospital_manager/models/yaodian.dart';

void main(){
  runApp(RemoteHospitalApp());
}
final ThemeData KDefaultTheme = new ThemeData(
  //brightness: Brightness.light,
  primarySwatch: Colors.teal,//Colors.lightBlue,
  //primaryColor: Color(0xFF57B4AE),
  accentColor:Color(0xFF57B4AE),//Colors.lightBlue,//Color(0xFF57B4AE),
);

class RemoteHospitalApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '视频问诊系统管理端',
      theme: KDefaultTheme,
      home:LoginPage(),
      routes: {
        "/main":(context)=>MainPage(),
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
  Yaodian yaodian =Yaodian.name();
  Widget _bodyPage= DoctorNoreviewListPage();
  void _onItemTapped(int index){
    if(mounted){
      setState(() {
        _currentIndex = index;
        if (index == 0) {
          _bodyPage = DoctorNoreviewListPage();
        }
        if(index==1){
          _bodyPage = DoctorReviewListPage();
        }
        if(index==2){
//          yaodian.ID=1;
//          yaodian.mc="燕喜堂";
//          yaodian.username="yd0001";
//          yaodian.password="123456";
//          _bodyPage=AccountCenterPage(yaodian: yaodian,);
          getPrefInt("ydid").then((val) {
            yaodian.ID = val;
            return getPrefString("ydmc");
          }).then((val){
            yaodian.mc = val;
            return getPrefString("username");
          }).then((val){
            yaodian.username=val;
            return getPrefString("password");
          }).then((val){
            yaodian.password=val;
            _bodyPage=AccountCenterPage(yaodian: yaodian,);
          });
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_bodyPage,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          //backgroundColor:Theme.of(context).accentColor ,
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon:Icon(Icons.add_box,size: 28,),
              title:Text("待审核医师",style: TextStyle(fontSize: 12)),
              backgroundColor: Theme.of(context).accentColor,
            ),
            BottomNavigationBarItem(
              icon:Icon(Icons.blur_linear,size: 28,),
              title:Text("已审核医师",style: TextStyle(fontSize: 12)),
              backgroundColor: Theme.of(context).accentColor,
            ),
            BottomNavigationBarItem(
                icon:Icon(Icons.supervisor_account,size: 28,),
                title:Text("账户中心",style: TextStyle(fontSize: 12)),
                backgroundColor: Theme.of(context).accentColor
            ),
          ]
      ),
    );
  }
}



