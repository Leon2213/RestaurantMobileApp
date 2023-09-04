import 'dart:math';
//import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'package:flutter/material.dart';
import 'dart:async';

//import 'package:fluttertoast/fluttertoast.dart';
//Test

class SpinTheWheel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'spin the wheel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SpiningWheel(),
    );
  }
}

class SpiningWheel extends StatefulWidget {
  @override
  _SpiningWheelState createState() => _SpiningWheelState();
}

class _SpiningWheelState extends State<SpiningWheel> {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();
  String _text = " ";

  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,

          //leading: Builder(
          //builder: (BuildContext context) {
          //return IconButton(
          //icon: const Icon(Icons.keyboard_arrow_left),
          //onPressed: () {
          //Scaffold.of(context).openDrawer();
          //},
          //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //);
          //},
          //),

          title: Container(
            child: Text(
              'FylleKäk',
              style: TextStyle(fontSize: 20, fontFamily: 'AlfaSlabOne'),
            ),
          ),
          bottom: PreferredSize(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              color: Colors.white,
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(4.0),
          ),
          backgroundColor: Color.fromARGB(
            255,
            133,
            191,
            240,
          ),
          elevation: 0.0),
      backgroundColor: Color.fromARGB(
        255,
        133,
        191,
        240,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40.0,
              width: 95.0,
            ),
            /*  SpinningWheel(
              Image.asset('assets/hjul.png'),
              width: 250,
              height: 250,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.1,
              canInteractWhileSpinning: false,
              dividers: 2,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset('assets/pilen.png'),
              secondaryImageHeight: 60,
              secondaryImageWidth: 60,
              shouldStartOrStop: _wheelNotifier.stream,
            ), */
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) => snapshot.hasData
                  ? RouletteScore(snapshot.data as int)
                  : Container(),
            ),
            SizedBox(
              height: 10.0,
              width: 95.0,
            ),
            ButtonTheme(
              minWidth: 220.0,
              height: 60.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                color: Color.fromARGB(255, 109, 181, 240),
                textColor: Color.fromARGB(255, 255, 255, 255),
                child: Text(
                  "Spinn",
                  style: TextStyle(fontSize: 25, fontFamily: 'AlfaSlabOne'),
                ),
                onPressed: () =>
                    _wheelNotifier.sink.add(_generateRandomVelocity()),
              ),
            ),
            SizedBox(
              height: 70.0,
              width: 95.0,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              // alignment: Alignment.bottomCenter,
              // height: 50.0,
              child: Column(children: <Widget>[
                GridView(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    shrinkWrap: true,
                    children: []),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, dynamic> labels = {
    1: 'Hej',
    2: 'hå',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
