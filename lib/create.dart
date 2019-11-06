import 'package:flutter/material.dart';

class CreateNewContact extends StatefulWidget {
  final arguments;

  CreateNewContact(this.arguments);

  @override
  CreateNewContactState createState() => new CreateNewContactState();
}

class CreateNewContactState extends State<CreateNewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
