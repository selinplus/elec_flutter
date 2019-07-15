import 'package:flutter/material.dart';
import '../../models/patient.dart';
import 'package:remote_hospital/components/zqdj/wzyh_component.dart';
class WzyhListComponent extends StatelessWidget {
  @required List<Patient> userList=List<Patient>();
  WzyhListComponent(this.userList);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: userList.length,
      itemBuilder: (BuildContext context,int index){
        return WzyhComponent(userList[index]);
      },
      separatorBuilder: (BuildContext context,int index){
        return Container(
            height: 10,
            color:Colors.grey[100]
        );
      },
    );
  }
}
