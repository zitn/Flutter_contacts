import 'dart:io';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:my_contact/create.dart';
import 'package:my_contact/detial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lpinyin/lpinyin.dart';

_checkPermission() async {
  // 请求通讯录权限
  await PermissionHandler().requestPermissions([PermissionGroup.contacts]);

  // 检查通讯录权限
  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
  if (permission != PermissionStatus.granted) {
    await PermissionHandler().openAppSettings();
    exit(0);
  }
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatelessWidget {
  final routes = {
    "/": (context) => HomePage(),
    "/detial": (context, {arguments}) => DetailPage(arguments: arguments),
    "/create": (context) => CreateNewContact(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          elevation: 8,
          title: const Text('通讯录'),
          actions: <Widget>[
            new IconButton(
              // action button
              icon: new Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: ContactListWidget(),
        floatingActionButton: CreateButton(),
      ),
      onGenerateRoute: (RouteSettings settings) {
        final String name = settings.name;
        final Function pageContentBuilder = routes[name];
        if (pageContentBuilder != null) {
          if (settings.arguments != null) {
            final Route route = MaterialPageRoute(
                builder: (context) =>
                    pageContentBuilder(context, arguments: settings.arguments));
            return route;
          } else {
            final Route route = MaterialPageRoute(
                builder: (context) => pageContentBuilder(context));
            return route;
          }
        }
        return null;
      },
    );
  }
}

class CreateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, "/create");
      },
    );
  }
}

/*
*  联系人列表
*/
class ContactListWidget extends StatefulWidget {
  @override
  ContactListWidgetState createState() => new ContactListWidgetState();
}

class ContactListWidgetState extends State<ContactListWidget> {
  List<Contact> _contactsList = []; // 声明联系人列表

  // 排序函数
  _sortList() {
    this._contactsList.sort((Contact a, Contact b) =>
        _getUpperCaseName(a.displayName)
            .compareTo(_getUpperCaseName(b.displayName)));
  }

  String _getUpperCaseName(String str) {
    if (str.codeUnitAt(0) > 126) {
      str = PinyinHelper.getShortPinyin(str);
    }
    // 如果不是汉字, 转换为大写字母进行比较, 不然大小写会分开排序
    str = str.toUpperCase();

    return str;
  }

  // 获取联系人并将信息放入_contactsList
  Future _getList() async {
    // 检查权限

    await _checkPermission();
    await ContactsService.getContacts().then((contacts) {
      for (var item in contacts) {
        this._contactsList.add(item);
      }
      setState(() {
        this._sortList();
      });
    });
  }

  // 初始化
  @override
  void initState() {
    super.initState();
    _getList();
  }

  String _firstChar;

  String _showFirstChar(String str) {
    String tmpChar = _getUpperCaseName(str)[0];
    if (tmpChar != _firstChar) {
      _firstChar = tmpChar;
      return tmpChar;
    } else {
      return '';
    }
  }

  // 将联系人信息生成卡片
  Widget _itemBuilder(BuildContext context, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              _showFirstChar(this._contactsList[index].displayName),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          flex: 15,
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            title: Text(
              this._contactsList[index].displayName,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/detial",
                  arguments: {"contact": this._contactsList[index]});
            },
            leading: this._contactsList[index].avatar.isEmpty
                ? Hero(
                    tag: this._contactsList[index].displayName.hashCode,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Color.fromARGB(
                          255,
                          this._contactsList[index].displayName.codeUnitAt(
                                  this._contactsList[index].displayName.length -
                                      1) *
                              99 %
                              190,
                          this._contactsList[index].displayName.codeUnitAt(
                                  this._contactsList[index].displayName.length -
                                      1) *
                              99 %
                              150,
                          this._contactsList[index].displayName.codeUnitAt(
                                  this._contactsList[index].displayName.length -
                                      1) *
                              99 %
                              180),
                      child: Material(
                        color: Colors.transparent,
                        child: Text(this._contactsList[index].displayName[0],
                            style: TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    ))
                : Hero(
                    tag: this._contactsList[index].avatar.hashCode,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundImage:
                          MemoryImage(this._contactsList[index].avatar),
                      backgroundColor: Colors.white,
                    ),
                  ),
          ),
        )
      ],
    );
  }

  // 下拉刷新时执行的函数
  Future _refresh() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      this._contactsList.clear();
      _getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 5),
        itemBuilder: _itemBuilder,
        itemCount: this._contactsList.length,
      ),
    );
  }
}
