import 'dart:async';
import 'dart:convert';
import 'package:infokuy/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infokuy/sekinfo.dart';
import 'package:http/http.dart';

class Barcode extends StatefulWidget {
  static String tag = 'barcode-page';
  @override
  _BarcodeState createState() => new _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
  String result = "Show your Barcode for Scan";
  var _ipAddress = 'Unknown';
  final httpClient = new Client();
  final url = 'https://httpbin.org/ip';
  _getIPAddressUsingFuture(){
    Future<Response> response = httpClient.get(url);
    response.then((value){
      setState(() {
        _ipAddress = json.decode(value.body)['origin'];
      });
    }).catchError((error)=>print(error));
  }


  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context){
    // final topbar = AppBar(
    //   backgroundColor: Colors.deepPurple,
    //   title: Text("QR Scanner Barbar-Code"),
    //   actions: <Widget>[
    //        IconButton(icon: Icon(Icons.info_outline),
    //         color: Colors.white,
    //         onPressed: (){
    //           Navigator.of(context).pushNamed(SekInfo.tag);
    //        },
    //       ),
    //     ],
    // );

    final ipLabel = FlatButton(
      child: Text(
        'Waiting for scanning',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    final addressLabel = FlatButton(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text('Your IP Address is: '),
          new Text('$_ipAddress.'),
          new Padding(
            padding: EdgeInsets.symmetric(vertical:16.0),
            child:Material(
              borderRadius: BorderRadius.circular(30.0),
              shadowColor: Colors.deepPurpleAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: _getIPAddressUsingFuture,
                color: Colors.deepPurpleAccent,
                child: Text('Get IP Address now Bro!', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );

    final scanButton = Padding(
      padding: EdgeInsets.symmetric(vertical:16.0),
      child:Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.deepPurpleAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: _scanQR,
          color: Colors.deepPurpleAccent,
          child: Text('Scan', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      appBar: new AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text("QR Scanner Barbar-Code"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.info_outline),
        color: Colors.white,
        onPressed: (){
          Navigator.of(context).pushNamed(SekInfo.tag);
        },
        ),
      ],
    ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            // topbar,
            ipLabel,
            addressLabel,
            scanButton,
          ],
        ),  
      ),
    );
  }
}
