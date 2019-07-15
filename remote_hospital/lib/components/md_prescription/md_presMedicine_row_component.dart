import 'package:flutter/material.dart';
import 'package:remote_hospital/models/medicine.dart';
import 'package:remote_hospital/models/mdroute.dart';
import 'package:remote_hospital/models/mdtimes.dart';
import 'package:remote_hospital/components/md_prescription/medicine_num_row_component.dart';
class MdPresMedicineRowComponent extends StatelessWidget {
  int index;
  Medicine medicine;
  final callback,increment,reduce,changeMdRoute,changeMdTimes,changeYyjl;
  final bool canOper;
  final List<MdRoute> mdrouteList;
  final List<MdTimes> mdtimesList;
  final TextEditingController _yyjlController =TextEditingController();

  MdPresMedicineRowComponent({this.index,this.medicine,this.callback,this.increment,this.reduce,this.canOper,this.changeMdRoute,this.changeMdTimes,this.changeYyjl,this.mdrouteList,this.mdtimesList});
   _getMdRouteList(){
      List<DropdownMenuItem<String>> list =List<DropdownMenuItem<String>>();
      DropdownMenuItem<String> item;
      for(int i=0;i<mdrouteList.length;i++){
        item=DropdownMenuItem<String>(child: Text("${mdrouteList[i].route}"),value:mdrouteList[i].route);
        list.add(item);
      }
      return list;
  }
  _getMdTimesList(){
    List<DropdownMenuItem<String>> list =List<DropdownMenuItem<String>>();
    DropdownMenuItem<String> item;
    for(int i=0;i<mdtimesList.length;i++){
      item=DropdownMenuItem<String>(child: Text("${mdtimesList[i].times}"),value:mdtimesList[i].times);
      list.add(item);
    }
    return list;
  }
  _increment(){
    //print((index+1).toString());
    increment(index-1);
  }
  _reduce(){
    reduce(index-1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:canOper? Column(
        children: <Widget>[
          Container(
//            height: 30,
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 20,
                  child: Text("${index.toString()}"+"、", style: TextStyle(fontSize: 12,color:Colors.grey),),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Text("${medicine.mc}", style: TextStyle(fontSize: 12,color:Colors.grey),),
                  ),
                ),
                Container(
                  child: Container(
                    child: Text("${medicine.style}", style: TextStyle(fontSize: 12,color:Colors.grey),),
                  ),
                ),
                Container(
                  child:MedicineNumberRowComponent(num:medicine.cnt,unit: medicine.unit,increment:_increment,reduce:_reduce,canOper: canOper,) ,
                ),
                Container(
                  //color:Colors.blue,
                    margin: EdgeInsets.only(left: 15.0,right: 5.0),
                    // padding:  EdgeInsets.symmetric(vertical: 10.0),
                    width: 40,
                    //height: 60,
                    alignment: Alignment.center,
                    child: IconButton(
                        padding:EdgeInsets.symmetric(horizontal: 0.0),
                        icon:Icon(
                          Icons.remove,
                          color:Colors.red,
                          size:30,
                        ),
                        onPressed: (){
                          callback(this.medicine);
                        }
                    )
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30.0),
            child: Row(
              children: <Widget>[
                Container(
                    height: 30,
                    width:150,
                    child:TextField(
                        controller: TextEditingController.fromValue(TextEditingValue(text:medicine.yyjl==null?"":"${medicine.yyjl}")),
                        onChanged: (val){
                          changeYyjl(val,index-1);
                        },
                        style: TextStyle(fontSize: 12,color: Theme.of(context).accentColor),
                        decoration: InputDecoration(
                          hintText: "点击输入用药剂量",
                          hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                          prefixIcon: Text("每次",style:TextStyle(fontSize: 12,color: Theme.of(context).accentColor),),
                        )
                    )
                )
              ],
            ),
          ),
          Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 30.0),
                      width: 200,
                      child:  DropdownButton<String>(
                        items:_getMdTimesList(),
                        hint:Text("用药频次"),
                        value:medicine.times,
                        style: TextStyle(fontSize: 12,color:Theme.of(context).accentColor),
                        onChanged:(T){
                          print(T);
                          changeMdTimes(T,index-1);
                        },
                        isExpanded: true,
                        iconSize: 30.0,
                      )
                  ),
                  Container(
                      width: 120,
                      padding: EdgeInsets.only(left: 30.0),
                      child: DropdownButton<String>(
                        items:_getMdRouteList(),
                        hint:Text("用药途径"),
                        value:medicine.route,
                        style: TextStyle(fontSize: 12,color:Theme.of(context).accentColor),
                        onChanged:(T){
                          print(T);
                          changeMdRoute(T,index-1);
                        },
                        isExpanded: true,
                        iconSize: 30.0,
                      )
                  ),

                ],
              )
          ),

        ],
      ): Column(
        children: <Widget>[
          Container(
//            height: 20,
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 20,
                  child: Text("${index.toString()}"+"、", style: TextStyle(fontSize: 10,color:Colors.grey),),
                ),
                Expanded(
                  child:  Container(
                    child: Text("${medicine.mc}", style: TextStyle(fontSize: 10,color:Colors.grey),),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left:20.0),
                  child: Text("${medicine.style}", style: TextStyle(fontSize: 10,color:Colors.grey),),
                ),
                Container(
                  padding: EdgeInsets.only(right: 60),
                  child:MedicineNumberRowComponent(num:medicine.cnt,unit: medicine.unit,increment:_increment,reduce:_reduce,canOper: canOper,) ,
                ),
              ],
            ),
          ),
          Container(
              height: 20,
              padding: EdgeInsets.only(bottom: 5.0,left:40.0),
              child: Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      alignment: Alignment.centerRight,
                      child: Text("Sig:",style: TextStyle(fontSize: 10,color:Colors.grey),)
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      alignment: Alignment.centerLeft,
                      width: 60,
                      child: Text(medicine.yyjl==null?"":"每次${medicine.yyjl}",style: TextStyle(fontSize: 10,color:Colors.grey),)
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 10.0),
                      width: 80,
                      alignment: Alignment.centerLeft,
                      child: Text(medicine.times==null?"":"${medicine.times}",style: TextStyle(fontSize: 10,color:Colors.grey),)
                  ),
                  Container(
                      width: 80,
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(medicine.route==null?"":"${medicine.route}",style: TextStyle(fontSize: 10,color:Colors.grey),)
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
