import 'package:flutter/material.dart';
class JianjieRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final validate;
  final save;
  JianjieRow({this.label,this.controller,this.hintText,this.validate,this.save});
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal:40.0),
       // width: 200,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.center,
          maxLength:200,
          maxLines: null,
          validator: (val) {
            if (validate==null){
              return null;
            }
            return validate(val);
          },
          onSaved: (val){
            if(save==null){
              return null;
            }
            save(val);
          },
          style: TextStyle(fontSize: 14,),
          decoration: InputDecoration(
            prefixIcon:  Container(
              width: 80,
              alignment: Alignment.centerLeft,
              child:Text("$label"),//,style: TextStyle(color:Theme.of(context).accentColor)),
            ),
            hintText: "$hintText",
            hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
          ),
        ),
    );
  }
}


