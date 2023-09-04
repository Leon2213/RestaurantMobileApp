import 'package:flutter/material.dart';
import 'package:pvt_v1/screens/SpinTheWheel.dart';

void main() {
  runApp(whos_paying2());
}

class whos_paying2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dynamic Text Field'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String value;

  List<String> newTextField = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          // leading: Builder(
          //   builder: (BuildContext context) {
          //   return IconButton(
          //   icon: const Icon(Icons.keyboard_arrow_left),
          //  onPressed: () {
          //   Scaffold.of(context).openDrawer();
          // },
          // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //);
          // },
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15,
              width: 100,
            ),

            Text(
              "Vem betalar?",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'AlfaSlabOne', fontSize: 20),
            ),

            Row(
              children: [
                SizedBox(
                  height: 1,
                  width: 70,
                ),

                Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: 210,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        filled: true,
                        hintText: '',
                      ),
                      //passing on to trhe next screen
                      onChanged: (text) {
                        value = text;
                      },
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Inter',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

                ///Adding a new textfield
                IconButton(
                  onPressed: () {
                    setState(() {
                      newTextField.add('');
                    });
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                )
              ],
            ),

            ///added text fields
            ...getNewTextFormFields(),

            ///Button to print the values
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SpinTheWheel(),
                ));
              },
              color: Color.fromARGB(255, 109, 181, 240),
              child: const Text(
                "Spela",
                style:
                    TextStyle(color: Colors.white, fontFamily: 'AlfaSlabOne'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Generating new textform if add button is clicked
  List<Widget> getNewTextFormFields() {
    var textField = <Widget>[];
    for (var i = 0; i < newTextField.length; i++) {
      textField.add(
        Row(
          children: [
            SizedBox(
              height: 1,
              width: 70,
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 210,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    newTextField[i] = value;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    filled: true,
                    hintText: '',
                  ),
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Inter',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  newTextField.removeAt(i);
                });
              },
              icon: Icon(
                Icons.remove_circle,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 30,
              ),
            )
          ],
        ),
      );
    }
    return textField;
  }
}
