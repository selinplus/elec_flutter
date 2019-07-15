import 'package:flutter/material.dart';
class SearchComponent extends StatelessWidget {
  final TextEditingController _controller = new TextEditingController();
  @required final callback;
  SearchComponent({this.callback});
  _callback(){
    callback(_controller.text.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color:Colors.grey[100],
                padding: EdgeInsets.all(7),
                alignment: Alignment.center,
                height: 40,
                child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 12),
                    cursorColor: Colors.black,
                    cursorWidth: 0.5,
//                    onSubmitted: (text){
//                      callback(text);
//                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.all(4.0),
                      hintText: "请输入手机号查询用户信息",
                      hintStyle: TextStyle(fontSize: 12,color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(30)
                        ),
                        borderSide: BorderSide(
                            color:Colors.transparent,
                            width: 0
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        /*边角*/
                        borderRadius: BorderRadius.all(
                          Radius.circular(30), //边角为30
                        ),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30), //边角为30
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0,
                          )),
                    )
                ),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color:Colors.grey[100],
              //margin: EdgeInsets.only(left:10.0),
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                textColor: Theme
                    .of(context)
                    .accentColor,
                child: Text("查找", style: TextStyle(fontSize: 12)),
                color: Colors.white,
                shape: Border.all(
                    color: Theme
                        .of(context)
                        .accentColor,
                    width: 1.0,
                    style: BorderStyle.solid
                ),
                onPressed: () {
                  _callback();
                },
              ),
            ),
          ],
        )
    );
  }
}
