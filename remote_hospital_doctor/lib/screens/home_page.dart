import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("视频问诊",style: TextStyle(fontSize: 18,color: Colors.white)),
            //toolbarOpacity: 0.6,
            backgroundColor: Theme.of(context).accentColor,
            centerTitle: true,
            elevation: 0.0,
          ),
          preferredSize:Size.fromHeight(40)
      ),
      body: Center(
        child:Text("首页",style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
