import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

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
* */
class ContactListWidget extends StatefulWidget {
  @override
  ContactListWidgetState createState() => new ContactListWidgetState();
}

class ContactListWidgetState extends State<ContactListWidget> {
  List<Contact> _contactsList = []; // 联系人列表

  // 获取联系人并将信息放入_contactsList
  Future _getList() async {
    await ContactsService.getContacts().then((contacts) {
      if (contacts.isNotEmpty) {
        for (var item in contacts) {
          setState(() {
            this._contactsList.add(item);
          });
        }
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
              backgroundColor: Colors.amber,  // 设置头像默认背景色 todo 叠加第一个字 随机颜色
              backgroundImage: this._contactsList[index].avatar.isEmpty
                  ? null
                  : MemoryImage(this._contactsList[index].avatar), // 判断是否有头像并返回
            ),
            title: Text(this._contactsList[index].displayName)));
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
