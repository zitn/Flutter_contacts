import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class DetailPage extends StatefulWidget {
  final Contact contact;

  DetailPage(this.contact);

  @override
  DetailPageState createState() => new DetailPageState();
}



class DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.contact.displayName,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.0,
                      )),
                  background: Image.memory(
                    widget.contact.avatar,
                    fit: BoxFit.fitWidth,
                  )),
            ),
          ];
        },
        body: Text('text'),
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
