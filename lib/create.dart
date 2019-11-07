import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class CreateNewContact extends StatefulWidget {
  @override
  CreateNewContactState createState() => CreateNewContactState();
}

class CreateNewContactState extends State<CreateNewContact> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  Item _phoneNumber;
  String _company;
  String _jobTitle;

  void _forSubmitted() {
    var _form = this._formKey.currentState;
    if (_form.validate()) {
      _form.save();
      ContactsService.addContact(Contact(
        middleName: this._name,
        phones: [this._phoneNumber],
        company: this._company.isEmpty ? null : this._company,
        jobTitle: this._jobTitle.isEmpty ? null : this._jobTitle,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('新增联系人'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _forSubmitted,
        child: Icon(Icons.done),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: '姓名',
                ),
                onSaved: (val) {
                  _name = val;
                },
                validator: (str) {
                  return str.isEmpty ? "姓名不能为空" : null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '电话',
                ),
                validator: (val) {
                  return val.isEmpty ? "电话不能为空" : null;
                },
                onSaved: (val) {
                  this._phoneNumber = Item(value: val);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '公司',
                ),
                onSaved: (val) {
                  this._company = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '职务',
                ),
                onSaved: (val) {
                  this._jobTitle = val;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

//
//  String _name, _phone, _email;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('添加新联系人'),
//        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {},
//          child: Icon(Icons.done),
//        ),
//        body: Container(
//          padding: EdgeInsets.only(top: 10),
//          child: Form(
//            child: Column(
//              children: <Widget>[
//                Card(
//                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                  elevation: 8,
//                  shape: const RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(15))),
//                  child: TextFormField(
//                    autofocus: true,
//                    onChanged: (str) {
//                      this._name = str;
//                    },
//                    decoration: InputDecoration(
//                      icon: Container(
//                        width: 40,
//                        alignment: Alignment.centerRight,
//                        child: Icon(Icons.person),
//                      ),
//                      border: InputBorder.none,
//                      hintText: "姓名",
//                      hintStyle: TextStyle(fontSize: 20),
//                    ),
//                    style: TextStyle(fontSize: 20),
//                  ),
//                ),
//                Card(
//                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                  elevation: 8,
//                  shape: const RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(15))),
//                  child: TextFormField(
//                    autofocus: true,
//                    decoration: InputDecoration(
//                      icon: Container(
//                        width: 40,
//                        alignment: Alignment.centerRight,
//                        child: Icon(Icons.call),
//                      ),
//                      border: InputBorder.none,
//                      hintText: "电话",
//                      hintStyle: TextStyle(fontSize: 20),
//                    ),
//                    style: TextStyle(fontSize: 20),
//                  ),
//                ),
//                Card(
//                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
//                  elevation: 8,
//                  shape: const RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(15))),
//                  child: TextFormField(
//                    autofocus: true,
//                    decoration: InputDecoration(
//                      icon: Container(
//                        width: 40,
//                        alignment: Alignment.centerRight,
//                        child: Icon(Icons.email),
//                      ),
//                      border: InputBorder.none,
//                      hintText: "邮件",
//                      hintStyle: TextStyle(fontSize: 20),
//                    ),
//                    style: TextStyle(fontSize: 20),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ));
//  }

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
