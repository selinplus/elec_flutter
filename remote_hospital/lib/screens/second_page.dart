import 'package:flutter/material.dart';
class SecondPage extends StatelessWidget {
//  _enterYhxx(BuildContext context){
//    Navigator.pushNamed(context,"/home");
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("诊前登记",style: TextStyle(fontSize: 18)),
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: Center(
//        child:RaisedButton(onPressed: (){
//          Navigator.pushNamed(context,"/home");
//        })

      ),
    );
  }
}
