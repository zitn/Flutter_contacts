import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:my_contact/detial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math';

_checkPermission() async {
  // 请求通讯录权限
//   Map<PermissionGroup, PermissionStatus> permissionsMap =
  await PermissionHandler().requestPermissions([PermissionGroup.contacts]);

  // 检查通讯录权限
  PermissionStatus permission =
      await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
  if (permission != PermissionStatus.granted) {
    await PermissionHandler().openAppSettings();
  }
}

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('通讯录'),
        ),
        body: ContactListWidget(),
      ),
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
  List<Contact> _contactsList = []; // 联系人列表 todo 排序

  // 获取联系人并将信息放入_contactsList
  Future _getList() async {
    // 检查权限
    await _checkPermission();
    await ContactsService.getContacts().then((contacts) {
      for (var item in contacts) {
        setState(() {
          this._contactsList.add(item);
        });
      }
    });
  }

  // 初始化
  @override
  void initState() {
    super.initState();

    _getList();
  }

  // 将联系人信息生成卡片
  Widget _itemBuilder(BuildContext context, int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(
              255,
              this._contactsList[index].displayName.codeUnitAt(0) % 100,
              this._contactsList[index].displayName.codeUnitAt(1) % 50,
              this._contactsList[index].displayName.codeUnitAt(0) % 50),
          child: Text(
              this._contactsList[index].avatar.isEmpty
                  ? this._contactsList[index].familyName
                  : '',
              style: TextStyle(color: Colors.white)),
          // 设置头像默认背景色
          backgroundImage: this._contactsList[index].avatar.isEmpty
              ? null
              : MemoryImage(this._contactsList[index].avatar), // 判断是否有头像返回
        ),
        title: Text(this._contactsList[index].displayName),
        onTap: () {
//          _showModalBottomSheet(context, this._contactsList[index]);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(this._contactsList[index])));
        },
      ),
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
          itemBuilder: _itemBuilder,
          itemCount: this._contactsList.length,
        ));
  }
}
