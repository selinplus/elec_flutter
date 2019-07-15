import 'package:flutter/material.dart';
import '../../models/medicine.dart';
class MedicineComponent extends StatelessWidget {
  @required Medicine medicine;
  MedicineComponent({this.medicine});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
       child:  Container(
         height: 40.0,
         child: Row(
           children: <Widget>[
             Expanded(
               flex:1,
               child: Container(
                 color:Colors.white,
                 padding: EdgeInsets.only(left:10.0),
                 alignment: Alignment.centerLeft,
                 child: Text("${medicine.mc}", style: TextStyle(fontSize: 12),),
               ),
             ),
             Expanded(
               flex:1,
               child: Container(
                 color:Colors.white,
                 padding: EdgeInsets.only(right:10.0),
                 alignment: Alignment.centerRight,
                 child: Text("${medicine.style}", style: TextStyle(fontSize: 12),),
               ),
             ),
           ],
         ),
       ),
       onTap: (){
           Navigator.pop(context,this.medicine,);
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           //指定跳转的页面
//           return MedicineYfPage(medicine:this.medicine);
//         },)).then((val){
//           this.medicine.num=val.toString();
//           Navigator.pop(context,this.medicine);
//         });
       },
     );
  }
}


