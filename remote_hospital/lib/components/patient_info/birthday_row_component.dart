import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
class BirthdayRowComponent extends StatelessWidget {
  @required TextEditingController controller;
  @required final callback;
  BirthdayRowComponent({this.controller,this.callback});
  Future<void> _selectDate(BuildContext context) async{
    final DateTime picked =await showDatePicker(
        context: context, initialDate: DateTime(1980,1), firstDate: DateTime(1910,1), lastDate: DateTime.now(),locale: Locale('zh'));
    if(picked!=null){
      callback(picked);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                width: 90.0,
                height: 40.0,
                child:Text("*出生年份",style: TextStyle(fontSize: 12))
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  height: 40.0,
                  child: TextField(
                    //enabled:false,
                    keyboardType:TextInputType.phone,
                    maxLength: 4,
                    onChanged: (T){
                       callback(T);
                    },
                    inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    controller: controller,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      counterText: "",
                      border: InputBorder.none,
                      hintText: "请输入4位数出生年份,如1999",
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                    ),
                  ),
                )//
            ),
//            Container(
//              padding: EdgeInsets.only(right: 10.0),
//              alignment: Alignment.centerRight,
//              child: IconButton(
//                  icon: Icon(Icons.arrow_forward_ios,size: 14.0,color: Theme.of(context).accentColor),
//                  onPressed: (){
//                    _selectDate(context);
//                  }
//              ),
//            )
          ],
        )
    );
  }
}
