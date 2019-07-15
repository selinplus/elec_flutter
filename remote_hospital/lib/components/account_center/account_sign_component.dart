import 'package:flutter/material.dart';
import 'package:remote_hospital/screens/qz_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AccountSignComponent extends StatelessWidget {
  final String label;
  final String yaosqzuri;
  final callback;
  AccountSignComponent({this.label,this.yaosqzuri,this.callback});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            //指定跳转的页面
            return QzPage();
          },)).then((url){
            if(url!=null) {
              callback(url);
            }
          });
        },
        child: Container(
            color:Colors.white,
            child:Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    alignment: Alignment.centerLeft,
//           color: Colors.red,
                    width: 150.0,
                    height: 40.0,
                    child:Text("$label",style: TextStyle(fontSize: 14))
                ),
                Expanded(
                  child: Container(
                    height: 40,
                  ),
                ),
                Container(
                    width: 60,
                    height: 40,
                    padding: EdgeInsets.only(right:20.0),
                    child: Container(
                      height: 20,
                      width: 40,
                      child: yaosqzuri==null||yaosqzuri==""?null:Image.network(yaosqzuri),
                    )
                ),
                Container(
                  padding: EdgeInsets.only(right:10.0),
                  child: Icon(Icons.arrow_forward_ios,size: 14.0,color: Theme.of(context).accentColor),
                )
              ],
            )
        )
    );

  }
}





