import 'package:flutter/material.dart';

class CreateNewContact extends StatefulWidget {
  @override
  CreateNewContactState createState() => new CreateNewContactState();
}

class CreateNewContactState extends State<CreateNewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加新联系人'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10),
        children: <Widget>[
          Card(
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            elevation: 8,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  icon: Container(
                    width: 40,
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.person),
                  ),
                  border: InputBorder.none,
                  hintText: "姓名",
              hintStyle: TextStyle(
                  fontSize: 20
              ),),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            elevation: 8,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                icon: Container(
                  width: 40,
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.call),
                ),
                border: InputBorder.none,
                hintText: "电话",
                hintStyle: TextStyle(
                    fontSize: 20
                ),),
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(CreateNewContact oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
