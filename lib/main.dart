// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:pvt_v1/constants.dart';
import 'package:pvt_v1/screens/HomeScreen.dart';
import 'package:pvt_v1/screens/InformationScreen.dart';
import 'package:pvt_v1/screens/ListOrMap_screen.dart';
import 'package:pvt_v1/screens/Restaurang.dart';
import 'package:http/http.dart' as http;
import 'package:pvt_v1/screens/WhosPlaying.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pvt_v1/screens/SpinTheWheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        unselectedWidgetColor: Colors.blue,
        //  toggleableActiveColor: Colors.blue,
        fontFamily: 'AlfaSlabOne',
        //TextStyle(fontSize: 25, fontFamily: 'AlfaSlabOne'),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
        ),

        // primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'FylleKäk'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/blueBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            /* leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ), */
            title: Container(
              child: Text(
                'FylleKäk',
                style: TextStyle(fontSize: 28),
              ),
            ),
            bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.fromLTRB(65, 0, 65, 0),
                color: Colors.white,
                height: 2.0,
              ),
              preferredSize: Size.fromHeight(4.0),
            )),
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          // alignment: Alignment.bottomCenter,
          // height: 50.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
            onPressed: () {
              /*  checked.keys.forEach((element) {
                      if (checked[element] == true) {
                        lista += element + ', ';
                      }
                    }); */
              /* lista = '';
                    if (pizzaCheck == true) {
                      lista += 'Pizza' + '\n';
                    }
                    if (hotDogCheck == true) {
                      lista += 'Korv' + '\n';
                    }
                    if (iceCreamCheck == true) {
                      lista += 'Glass' + '\n';
                    }
                    if (burgerCheck == true) {
                      lista += 'Hamburgare' + '\n';
                    }
                    setState(() {}); */
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'FylleKäk2')),
              );
            },
            padding: EdgeInsets.fromLTRB(13, 27, 13, 27),
            color: Colors.white,
            textColor: Color.fromARGB(255, 37, 133, 211),
            child: Text("Tillbaka",
                style: TextStyle(fontSize: 25, fontFamily: 'AlfaSlabOne')),
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Restaurang> restaurantList = [];
  String latitudeString = "";
  String longitudeString = "";
  double latitudeDouble = 9.9;
  double longitudeDouble = 9.9;

  bool pizzaCheck = false;
  bool hotDogCheck = false;
  bool iceCreamCheck = false;
  bool burgerCheck = false;

  int currentIndex = 0;

  String lista = '';
  static ValueNotifier<String> lista2 = ValueNotifier('');
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    //  Marker destination = markers.elementAt(0);
    //getSomePoints(destination.position);
  }

  Map<String, bool> checked = {
    'Pizza': false,
    'Korv': false,
    'Snacks': false,
    'Hamburgare': false,
    'Kebab': false,
    'Random': false,
  };

  List<FoodItem> foodItems = [
    FoodItem('burger'),
    FoodItem('korv'),
    FoodItem('pizza'),
    FoodItem('kebab'),
    FoodItem('snacks'),
    FoodItem('random'),
  ];

  Widget createCardItem(int i) {
    return SizedBox(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              foodItems[i].togglePressed();
            });
          },
          padding: EdgeInsets.all(0.0),
          icon: (foodItems[i].getPressed()
              ? Image.asset(
                  'assets/PressedIcons/${foodItems[i].imageSource}Pressed.png')
              : Image.asset(
                  'assets/NotPressedIcons/${foodItems[i].imageSource}NotPressed.png')),
          iconSize: 110,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //_getCurrentLocation();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/blueBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              /* leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ), */
              title: Container(
                child: Text(
                  'FylleKäk',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              bottom: PreferredSize(
                child: Container(
                  margin: EdgeInsets.fromLTRB(65, 0, 65, 0),
                  color: Colors.white,
                  height: 2.0,
                ),
                preferredSize: Size.fromHeight(4.0),
              )),
          drawer: Container(
            width: 155,
            child: Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/blueBackground.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          const SizedBox(height: 24),
                          ListTile(
                            leading: Image.asset(
                              'assets/MenuIcons/restaurant.png',
                              color: Colors.white,
                            ),
                            title: Text("Filter",
                                style: TextStyle(color: Colors.white)),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(title: 'Home'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset(
                              'assets/MenuIcons/dice.png',
                              color: Colors.white,
                            ),
                            title: Text("Spel",
                                style: TextStyle(color: Colors.white)),

                            /*

                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => whos_paying2()
                              ),
                            ),

                            */

                            // LÄGG TILL PUSH TILL SPELSCREEN
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: Image.asset('assets/marker.png'),
                            title: Text("Karta",
                                style: TextStyle(color: Colors.white)),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListOrMap_screen(
                                  latitude: latitudeDouble,
                                  longitude: longitudeDouble,
                                  restaurants: restaurantList,
                                  fromMain: true,
                                  hamburger: foodItems[0].pressed,
                                  korv: foodItems[1].pressed,
                                  pizza: foodItems[2].pressed,
                                  kebab: foodItems[3].pressed,
                                  snacks: foodItems[4].pressed,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Center(
                  child: Text(
                    'Vad är du sugen på?',
                    style: TextStyle(
                        fontFamily: 'Inter', fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(82, 12, 82, 0),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  children: [
                    createCardItem(0),
                    createCardItem(1),
                    createCardItem(2),
                    createCardItem(3),
                    createCardItem(4),
                    createCardItem(5),
                  ],
                ),
              ),

              // ändra till padding 100 när vi tagit bort Textboxen som presenterar valen.
              // 100 var alternativet innan för höjd
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                // alignment: Alignment.bottomCenter,
                // height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () async {
                    print("INNE I MAIN ON PRESS");
                    String foodtype = getFoodType();

                    Response response = await requestJsonFromBackEnd(
                        latitudeString, longitudeString, foodtype);

                    if (response.statusCode == 200) {
                      print('Här printar vi response....body');
                      print(response.body);
                      print('här printar vi 5 istllet för hela body');
                      //  print(response.body[5]);
                      var responseBodyUTFtransformed =
                          json.decode(utf8.decode(response.bodyBytes));

                      // var responseBody = jsonDecode(response.body);
                      print('Här printar vi ResponseBodyObjektet:');
                      //  print(responseBody);
                      print(responseBodyUTFtransformed);
                      createRestaurantObjects(responseBodyUTFtransformed);
                    }

                    /*

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InformationScreen(),
                      ),
                    );

      */

                    // För att testa när DSV:s find är nere

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListOrMap_screen(
                          latitude: latitudeDouble,
                          longitude: longitudeDouble,
                          restaurants: restaurantList,
                          fromMain: true,
                          hamburger: foodItems[0].pressed,
                          korv: foodItems[1].pressed,
                          pizza: foodItems[2].pressed,
                          kebab: foodItems[3].pressed,
                          snacks: foodItems[4].pressed,
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.fromLTRB(23, 20, 23, 20),
                  color: Colors.white,
                  textColor: Color.fromARGB(255, 37, 133, 211),
                  child: Text("Hitta matställen",
                      style:
                          TextStyle(fontSize: 22, fontFamily: 'AlfaSlabOne')),
                ),
              ),
            ],
          ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.requestPermission();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print("error1");
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        print("error2");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("error3");
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    Position position = geoposition as Position;

    latitudeString = '${geoposition.latitude}';
    longitudeString = '${geoposition.longitude}';
    longitudeDouble = geoposition.longitude;
    latitudeDouble = geoposition.latitude;
/*     print("!_getCurrentLocation()!");
    print(latitudeData);
    print(longitudeData);  */
  }

  // Gör ett call till Spring boot backend som i sin tur hämtar restauranger utifrån LatLng koordinater vi skickar med
  Future<http.Response> requestJsonFromBackEnd(
      String latitude, String longitude, String foodtype) async {
    String hamburger = foodItems[0].getPressed().toString();
    String korv = foodItems[1].getPressed().toString();
    String pizza = foodItems[2].getPressed().toString();
    String kebab = foodItems[3].getPressed().toString();
    String snacks = foodItems[4].getPressed().toString();
    String random = foodItems[5].getPressed().toString();

    print("hamburger: " +
        hamburger +
        " \n korv: " +
        korv +
        " \n pizza: " +
        pizza +
        " \n kebab: " +
        kebab +
        " \n snacks: " +
        snacks +
        " \n random: " +
        random);
    String type = "pizza";
    print("Inuti tstKoppleMedSpring()-> printar latitude + LongitudeDAta");
    print(latitude + " " + longitude);

    final response = await http.get(Uri.parse(
        //'https://group-3-15.pvt.dsv.su.se/app/find?latitude=59.342069&longitude=18.095902&type=pizza'
        'http://142.93.237.98:8080/fyllekak/app/find?latitude=59.342069&longitude=18.095902&type=pizza'));

    if (foodItems[0].getPressed() == false &&
        foodItems[1].getPressed() == false &&
        foodItems[2].getPressed() == false &&
        foodItems[3].getPressed() == false &&
        foodItems[4].getPressed() == false &&
        foodItems[5].getPressed() == false) {
      kebab = "true";
    }

    //Testar ta bort merge conflict

    final response3 = await http.get(Uri.parse(
        // 'https://group-3-15.pvt.dsv.su.se/app/find?latitude=' +
        'http://142.93.237.98:8080/fyllekak/app/find?latitude=' +
            latitude +
            '&longitude=' +
            longitude +
            '&hamburger=' +
            hamburger +
            '&korv=' +
            korv +
            '&pizza=' +
            pizza +
            '&kebab=' +
            kebab +
            '&snacks=' +
            snacks));

    final response2 = await http.get(Uri.parse(
        // 'https://group-3-15.pvt.dsv.su.se/app/find?latitude=' +
        'http://142.93.237.98:8080/fyllekak/app/find?latitude=' +
            latitude +
            '&longitude=' +
            longitude +
            '&type=' +
            type +
            ''));

    print(latitude + " " + longitude);
    print("HÄR ÄR RESPONSE CODE");
    print(response3.statusCode);
    print(response3.body);
    return response3;
  }

  void createRestaurantObjects(responseBody) {
    List<String> idList = [];
    restaurantList.clear();
    for (var jsonRest in responseBody) {
      Map<String, dynamic> map = jsonRest;
      Restaurang restaurangObj = Restaurang.fromJson(jsonRest);

      if (!idList.contains(restaurangObj.placeid)) {
        idList.add(restaurangObj.placeid);
        restaurantList.add(restaurangObj);
      }

      //String foodTypes = map["foodTypes"];

      List<dynamic> foodTypeListan = map["foodTypes"];
      List<dynamic> reviewListan = map["reviews"];
      parseFoodTypesAndAddToRestaurant(foodTypeListan, restaurangObj);
      parseReviewsAndAddToRestaurant(reviewListan, restaurangObj);
      print('Så här ser ett restaurang objekt ut efter jsonparsing: ');
      print(restaurangObj);
    }
  }

  String getFoodType() {
    return "pizza";
  }

  void parseFoodTypesAndAddToRestaurant(
      List foodTypeListan, Restaurang restaurangObj) {
    String stringFoodType = "";
    int length = foodTypeListan.length;
    //int length = foodTypeListanTest.length;
    int count = 0;
    for (dynamic foodType in foodTypeListan) {
      //for (dynamic foodType in foodTypeListanTest) {
      if (length == 1) {
        stringFoodType += foodType.toString();
        break;
      }
      if ((count + 1) != length) {
        stringFoodType += foodType.toString() + ",";
      } else {
        stringFoodType += foodType.toString();
      } // "snacks,pizza,hamburgare"
      count++;
    }
    print('Detta är string foodtype');
    print(stringFoodType);
    restaurangObj.addFoodTypes(stringFoodType);
  }

  void parseReviewsAndAddToRestaurant(
      List reviewListan, Restaurang restaurangObj) {
    String allReviewsString = "";
    int length = reviewListan.length;
    int count = 0;
    for (dynamic review in reviewListan) {
      if (length == 1) {
        allReviewsString += review.toString();
        break;
      }
      if ((count + 1) != length) {
        allReviewsString += review.toString() + "\n";
      } else {
        allReviewsString += review.toString();
      } // "review 1
      //    review 2
      //    review 3"

    }
    LineSplitter ls = new LineSplitter();
    List<String> reviewListKlar = ls.convert(allReviewsString);
    restaurangObj.addReviews(reviewListKlar);
  }
}

//Klass för att kunna göra filterikonerna bra och interaktiva
class FoodItem {
  String imageSource;
  bool pressed = false;

  FoodItem(this.imageSource);

  void togglePressed() {
    pressed = !pressed;
  }

  String getImageSource() {
    return imageSource;
  }

  bool getPressed() {
    return pressed;
  }
}
