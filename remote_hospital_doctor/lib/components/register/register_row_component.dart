import 'package:flutter/material.dart';
class RegisterRowComponent extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;
  final String label;
  final bool displayOnly;
  final bool keyNumberOnly;
  final save;
  final validate;
  RegisterRowComponent({this.controller,this.isPass,this.label,this.hintText,this.displayOnly,this.keyNumberOnly,this.save,this.validate});
  @override
  Widget build(BuildContext context) {
    return   Container(
        padding: EdgeInsets.symmetric(horizontal:40.0),
        child: TextFormField(
          controller: controller,
          obscureText: isPass,
          textAlign: TextAlign.center,
          keyboardType: keyNumberOnly?TextInputType.number:TextInputType.text,
          enabled: !displayOnly,
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
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            //border: InputBorder.none,
            // labelText:"$label",
            //contentPadding: EdgeInsets.only(left: 2.0),
            //prefixText: "$label",
           prefixIcon:  Container(
              width: 80,
              alignment: Alignment.centerLeft,
              child:Text("$label"),//,style: TextStyle(color:Theme.of(context).accentColor)),
            ),
            //labelStyle: TextStyle(fontSize: 14,color:Theme.of(context).accentColor) ,
            hintText: "$hintText",
            hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
          ),
        ),
      );



  }
}
