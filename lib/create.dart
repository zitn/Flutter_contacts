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
  String _identifier;

  void _forSubmitted() {
    var _form = this._formKey.currentState;
    if (_form.validate()) {
      _form.save();
      if (_identifier == null) {
        ContactsService.addContact(Contact(
          middleName: this._name,
          phones: [_phoneNumber],
          company: this._company.isEmpty ? null : this._company,
          jobTitle: this._jobTitle.isEmpty ? null : this._jobTitle,
        ));
      } else {
        widget.arguments["contact"].displayName = this._name;
        widget.arguments["contact"].phones = [this._phoneNumber];
        widget.arguments["contact"].company = this._company.isEmpty?null:this._company;
        widget.arguments["contact"].jobTitle = this._jobTitle.isEmpty?null:this._jobTitle;
        ContactsService.updateContact(widget.arguments["contact"]);
      }
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => route == null);
    }
  }

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _companyFocus = FocusNode();
  final FocusNode _jonTitleFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    String _title = "新建联系人";
    if (widget.arguments == null) {
      _title = "新建联系人";
    } else {
      _title = "修改联系人";
      this._identifier = widget.arguments["contact"].identifier;
      this._name = widget.arguments["contact"].displayName;
      this._phoneNumber = widget.arguments["contact"].phones.elementAt(0); // todo emails
      this._company = widget.arguments["contact"].company;
      this._jobTitle = widget.arguments["contact"].jobTitle;
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
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, this._nameFocus,
                      this._phoneNumberFocus);
                },
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: '${this._name == null ? "" : this._name}',
                    selection: TextSelection.fromPosition(
                      TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: '${this._name}'.length),
                    ))),
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
              TextFormField(
                focusNode: this._phoneNumberFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(
                      context,
                      this._phoneNumberFocus,
                      this._companyFocus);
                },
                controller: TextEditingController.fromValue(TextEditingValue(
                    text:
                    '${this._phoneNumber == null ? "" : this._phoneNumber
                        .value}',
                    selection: TextSelection.fromPosition(
                      TextPosition(
                          affinity: TextAffinity.downstream,
                          offset:
                          '${this._phoneNumber == null?"":this._phoneNumber.value}'.length),
                    ))),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: '电话 ${ this._phoneNumber == null ? "" : this
                      ._phoneNumber.label}',
                ),
                validator: (val) {
                  return val.isEmpty ? "号码不能为空" : null;
                },
                onSaved: (val) {
                  this._phoneNumber = Item(value: val);
                },
              ),
              _getCompanyWidget(),
              _getJobTitleWidget(),
            ],
          ),
        ),
      ),
    );
  }

  // 焦点切换
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  Widget _getJobTitleWidget() {
    return TextFormField(
      focusNode: this._jonTitleFocus,
      controller: TextEditingController.fromValue(TextEditingValue(
          text: '${this._jobTitle == null ? "" : this._jobTitle}',
          selection: TextSelection.fromPosition(
            TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this._jobTitle}'.length),
          ))),
      onFieldSubmitted: (term) {
        _forSubmitted();
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: '职务',
      ),
      onSaved: (val) {
        this._jobTitle = val;
      },
    );
  }

  Widget _getCompanyWidget() {
    return TextFormField(
      focusNode: this._companyFocus,
      controller: TextEditingController.fromValue(TextEditingValue(
          text: '${this._company == null ? "" : this._company}',
          selection: TextSelection.fromPosition(
            TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this._company}'.length),
          ))),
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, this._companyFocus, this._jonTitleFocus);
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: '公司',
      ),
      onSaved: (val) {
        this._company = val;
      },
    );
  }

}
