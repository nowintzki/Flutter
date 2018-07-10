import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context){
    final user = Hero(
      tag: 'Nino Firms.',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/nino.jpg'),
        ),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Hi Nino Firms.',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );
    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'disini gak tau harus diisi apa',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.purple,
          Colors.deepPurpleAccent,
        ])
      ),
      child: Column(
        children: <Widget>[user, welcome, lorem],
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}

