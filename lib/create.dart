import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class CreateNewContact extends StatefulWidget {
  final arguments;

  CreateNewContact({this.arguments});

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
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => route == null);
    }
  }

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _cpmpanyFocus = FocusNode();
  final FocusNode _jonTitleFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    String _title = "新建联系人";

    if (widget.arguments == null) {
      _title = "新建联系人";
    } else {
      _title = "修改联系人";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
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
                focusNode: this._nameFocus,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context, this._nameFocus, this._phoneNumberFocus);
                },
                textInputAction: TextInputAction.next,
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
              Column(
                children: [
                  TextFormField(
                    focusNode: this._phoneNumberFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, this._phoneNumberFocus, this._cpmpanyFocus);
                    },
                    textInputAction: TextInputAction.next,
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
                ],
              ),
              TextFormField(
                focusNode: this._cpmpanyFocus,
                onFieldSubmitted: (term){
                  _fieldFocusChange(context, this._cpmpanyFocus, this._jonTitleFocus);
                },
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: '公司',
                ),
                onSaved: (val) {
                  this._company = val;
                },
              ),
              TextFormField(
                focusNode: this._jonTitleFocus,
                onFieldSubmitted: (term){
                  _forSubmitted();
                },
                textInputAction: TextInputAction.done,
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


  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(CreateNewContact oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
