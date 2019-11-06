import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Contact contact;

  DetailPage(this.contact);

  @override
  DetailPageState createState() => new DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  List<Widget> _getPhonesCard() {
    List<Widget> _list = new List<Widget>();
    if (widget.contact.phones.isEmpty) {
      return [];
    }
    for (int i = 0; i < widget.contact.phones.length; i++) {
      _list.add(new ListTile(
        leading: Icon(Icons.call),
        title: Text(
          widget.contact.phones.elementAt(i).value,
          style: TextStyle(fontSize: 17),
        ),
        subtitle: Text(widget.contact.phones.elementAt(i).label),
        onTap: () {
          launch("tel:${widget.contact.phones.elementAt(i).value}");
        },
        dense: true,
        trailing: IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            launch("sms:${widget.contact.phones.elementAt(i).value}");
          },
        ),
      ));
      if (i < widget.contact.phones.length - 1) {
        _list.add(Divider());
      }
      setState(() {});
    }
    return _list;
  }

  List<Widget> _getEmailsCard() {
    List<Widget> _list = new List<Widget>();
    if (widget.contact.emails.isEmpty) {
      return [];
    }
    for (int i = 0; i < widget.contact.emails.length; i++) {
      _list.add(new ListTile(
        leading: Icon(Icons.mail),
        title: Text(
          widget.contact.emails.elementAt(i).value,
          style: TextStyle(fontSize: 17),
        ),
        subtitle: Text(widget.contact.emails.elementAt(i).label),
        dense: true,
        onTap: () {
          launch("mailto:${widget.contact.emails.elementAt(i).value}");
        },
      ));
      if (i < widget.contact.emails.length - 1) {
        _list.add(Divider());
      }
      setState(() {});
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text(widget.contact.displayName),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          children: <Widget>[
            Card(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              elevation: 8,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: _getPhonesCard(),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              elevation: 8,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: _getEmailsCard(),
              ),
            )
          ],
        ),
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
  void didUpdateWidget(DetailPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
