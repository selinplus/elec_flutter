import 'package:flutter/material.dart';
import 'package:remote_hospital_doctor/components/history_prescription/history_novertified_pres_list_component.dart';
import 'package:remote_hospital_doctor/components/history_prescription/history_vertified_pres_list_component.dart';
import 'package:remote_hospital_doctor/components/history_prescription/history_more_vertified_pres_list_component.dart';
//import 'package:remote_hospital/components/history_prescription/history_nosend_pres_list_component.dart';
//import 'package:remote_hospital/components/history_prescription/history_send_pres_list_component.dart';
//import 'package:remote_hospital/components/history_prescription/history_today_pres_list_component.dart';
//import 'package:remote_hospital/screens/patient_details_page.dart';
//import 'package:remote_hospital/models/patient.dart';
class HistoryPrescriptionPage extends StatefulWidget {
  @override
  _HistoryPrescriptionPageState createState() => _HistoryPrescriptionPageState();
}

class _HistoryPrescriptionPageState extends State<HistoryPrescriptionPage> with SingleTickerProviderStateMixin {
  //Patient patient =Patient.name();
  int _selectedIndex = 0;
   ScrollController _scrollViewController;
   TabController _tabController;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollViewController=ScrollController();
    _tabController=TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
            title: Text("处方记录",style: TextStyle(fontSize: 18)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
            bottom: PreferredSize(
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                      controller: _tabController,
                      labelColor:Theme.of(context).accentColor,
                      unselectedLabelColor: Colors.black,
                      tabs: <Widget>[
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          child:Text("未审核",style: TextStyle(fontSize: 12),),
                        ),
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          child:Text("今日已审核",style: TextStyle(fontSize: 12),),
                        ),
//                        Container(
//                          height: 30,
//                          alignment: Alignment.center,
//                          child:Text("今日完成",style: TextStyle(fontSize: 12,),),
//                        ),
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          child:Text("历史完成",style: TextStyle(fontSize: 12,),),
                        ),
                      ],
                  ),
                ),
                preferredSize: Size.fromHeight(15)
            ),
          ),

          body:TabBarView(
              controller: _tabController,
              children: <Widget>[
                HistoryNovertifiedPresListComponent(),
                HistoryVertifiedPresListComponent(),
                HistoryMoreVertifiedPresListComponent(),
              ],
             ) //SelectDoctorComponent(),
          );
    }
  }
