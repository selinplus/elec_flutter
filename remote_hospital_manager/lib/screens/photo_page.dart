import 'package:flutter/material.dart';
import 'package:remote_hospital_manager/config.dart';
class PhotoPage extends StatelessWidget {
  String title;
  String imageUrl;
  PhotoPage({this.title,this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text("$title",style: TextStyle(fontSize: 18)),
              //toolbarOpacity: 0.6,
              backgroundColor: Theme.of(context).accentColor,
              centerTitle: true,
              elevation: 0.0,
            ),
            preferredSize:Size.fromHeight(40)
        ),
        body: Center(
          child: Image(
            image: NetworkImage("$imageUrl"),
          ),
        )
    );
  }
}
