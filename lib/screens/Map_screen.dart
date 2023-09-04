// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
// ZZZ:
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:pvt_v1/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:pvt_v1/main.dart';
import 'package:pvt_v1/screens/ListOrMap_screen.dart';
import 'package:http/http.dart' as http;

import 'Restaurang.dart';

class Map_screen extends StatefulWidget {
  Map_screen({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.markers,
    required this.hamburgerPressed,
    required this.korvPressed,
    required this.pizzaPressed,
    required this.kebabPressed,
    required this.snacksPressed,
    // ZZZ:
    required this.controller,
  }) : super(key: key);

  double latitude = 10.101010;
  double longitude = 10.101010;
  Set<Marker> markers = {};

  bool hamburgerPressed = false;
  bool korvPressed = false;
  bool pizzaPressed = false;
  bool kebabPressed = false;
  bool snacksPressed = false;
  // ZZZ:
  CustomInfoWindowController controller;

  // ZZZ: , controller
  @override
  State<StatefulWidget> createState() => _MapScreenState(
      latitude,
      longitude,
      markers,
      hamburgerPressed,
      korvPressed,
      pizzaPressed,
      kebabPressed,
      snacksPressed,
      controller);
}

class _MapScreenState extends State<Map_screen> {
  double latitude = 44.444444;
  double longitude = 44.444444;
  Set<Marker> markers = {};
  static LatLng userLatLng = LatLng(44.44444, 44.444444);
  static LatLng targetLatLng = new LatLng(0, 0);
  bool hamburgerPressed;
  bool korvPressed;
  bool pizzaPressed;
  bool kebabPressed;
  bool snacksPressed;

  GoogleMapController? _googleMapController;
  Location _location = Location();
  static Set<Polyline> polyline = {};
  static List<LatLng> routePointsList = [];

  List<Restaurang> restaurantList = [];

  // ZZZ:
  CustomInfoWindowController controller = CustomInfoWindowController();

  static LatLng getUserPos() {
    return userLatLng;
  }

  void reloadState() {
    _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(_suCameraPosition),
    );
  }

//hej
  @override
  void initState() {
    super.initState();
    userLatLng = LatLng(latitude, longitude);
  }

  // ZZZ:
  _MapScreenState(
      this.latitude,
      this.longitude,
      this.markers,
      this.hamburgerPressed,
      this.korvPressed,
      this.pizzaPressed,
      this.kebabPressed,
      this.snacksPressed,
      this.controller);

  //Koordinat Kamera Postioner
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(59.406914, 17.945520),
    zoom: 14,
  );
  static const _suCameraPosition = CameraPosition(
    target: LatLng(59.366162, 18.055018),
    zoom: 14,
    // tilt: 70.0, kan användas
  );
  static const _gamlaStan = CameraPosition(
    target: LatLng(59.324775, 18.070511),
    zoom: 14,
    // tilt: 70.0, kan användas
  );
  static const _Stockholm = CameraPosition(
    target: LatLng(59.342261, 18.055812),
    zoom: 15,
    // tilt: 70.0, kan användas
  );

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    // setState(() { });

    controller.googleMapController = _cntlr;

    _location.onLocationChanged.listen((event) {
      userLatLng = LatLng(event.latitude as double, event.longitude as double);

      createPointsBetweenUserAndTarget(targetLatLng);
      //setState(() {});
    });
  }

  // Variabler för varje matkategori
  // Ska ändras senare för att hämta från "Hitta restauranger" och uppdatera i realtid

  bool onChanged = false;

  Widget createWidget() {
    if (onChanged) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              //color: Colors.amberAccent,
              ),
          child: FloatingActionButton(
            heroTag: "btn2",
            child: Icon(
              Icons.replay_outlined,
              size: 32,
            ),
            backgroundColor: Colors.blue,
            onPressed: () async {
              // TODO: Kod för att ladda om matkategorierna på kartan

              print("REFRESH BUTTON KÖRDES!!!!!!");
              clearOldPolylinesFromMap();
              Response response = await requestJsonFromBackEnd(
                  latitude.toString(), longitude.toString());
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
                onChanged = false;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListOrMap_screen(
                    latitude: latitude,
                    longitude: longitude,
                    restaurants: restaurantList,
                    fromMain: false,
                    hamburger: hamburgerPressed,
                    korv: korvPressed,
                    pizza: pizzaPressed,
                    kebab: kebabPressed,
                    snacks: snacksPressed,
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: SizedBox(
          height: 0,
          child: FloatingActionButton.small(
            heroTag: "btn1",
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                createWidget(),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                    child: SizedBox(
                      height: 30,
                      child: FloatingActionButton.extended(
                        heroTag: "btn7",
                        backgroundColor:
                            hamburgerPressed ? Colors.blue : Colors.white,
                        elevation: 5,
                        onPressed: () {
                          setState(() {
                            hamburgerPressed = !hamburgerPressed;
                            onChanged = true;
                            setFilterButtonValuesListOrMap_screen();
                          });
                        },
                        label: Text(
                          'Hamburgare',
                          style: TextStyle(
                            color:
                                hamburgerPressed ? Colors.white : Colors.grey,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                    child: SizedBox(
                      height: 30,
                      child: FloatingActionButton.extended(
                        heroTag: "btn6",
                        backgroundColor:
                            korvPressed ? Colors.blue : Colors.white,
                        elevation: 5,
                        onPressed: () {
                          setState(() {
                            korvPressed = !korvPressed;
                            onChanged = true;
                            setFilterButtonValuesListOrMap_screen();
                          });
                        },
                        label: Text(
                          'Korv',
                          style: TextStyle(
                            color: korvPressed ? Colors.white : Colors.grey,
                            fontSize: 16,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: SizedBox(
                    height: 30,
                    child: FloatingActionButton.extended(
                      heroTag: "btn5",
                      backgroundColor:
                          pizzaPressed ? Colors.blue : Colors.white,
                      elevation: 5,
                      onPressed: () {
                        setState(() {
                          pizzaPressed = !pizzaPressed;
                          onChanged = true;
                          setFilterButtonValuesListOrMap_screen();
                        });
                      },
                      label: Text(
                        'Pizza',
                        style: TextStyle(
                          color: pizzaPressed ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: SizedBox(
                    height: 30,
                    child: FloatingActionButton.extended(
                      heroTag: "btn4",
                      backgroundColor:
                          kebabPressed ? Colors.blue : Colors.white,
                      elevation: 5,
                      onPressed: () {
                        setState(() {
                          kebabPressed = !kebabPressed;
                          onChanged = true;
                          setFilterButtonValuesListOrMap_screen();
                        });
                      },
                      label: Text(
                        'Kebab',
                        style: TextStyle(
                          color: kebabPressed ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: SizedBox(
                    height: 30,
                    child: FloatingActionButton.extended(
                      heroTag: "btn3",
                      backgroundColor:
                          snacksPressed ? Colors.blue : Colors.white,
                      elevation: 5,
                      onPressed: () {
                        setState(() {
                          this.snacksPressed = !snacksPressed;
                          onChanged = true;
                          setFilterButtonValuesListOrMap_screen();
                        });
                      },
                      label: Text(
                        'Snacks',
                        style: TextStyle(
                          color: snacksPressed ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        /* appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () => _googleMapController?.animateCamera(
            CameraUpdate.newCameraPosition(_Stockholm),
          ),
          style: TextButton.styleFrom(
            primary: Colors.blueAccent,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text('Sthlm',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ),
        //title: const Text("Karta", style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => _googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(_gamlaStan),
            ),
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: const Text('Gamla_Stan',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          TextButton(
            onPressed: () => _googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(_suCameraPosition),
            ),
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: const Text('SU',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          ),
          TextButton(
            onPressed: () => _googleMapController?.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition),
            ),
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            child: const Text('Nod_Huset', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ],
      ), */
        body: Stack(children: <Widget>[
          GoogleMap(
            key: UniqueKey(),
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: userLatLng,
              zoom: 14,
            ),
            onTap: (position) {
              controller.hideInfoWindow!();
            },
            onCameraMove: (position) {
              controller.onCameraMove!();
            },
            onMapCreated: _onMapCreated,
            polylines: polyline,
            markers: markers,
          ),
          //ZZZ
          CustomInfoWindow(
            controller: controller,
            height: 86,
            width: 188,
            offset: 35,
          ),
        ]));
  }

  void setFilterButtons() {
    if (hamburgerPressed) {}
  }

  void setFilterButtonValuesListOrMap_screen() {
    ListOrMapScreenState.setFilterButtonValues(hamburgerPressed, korvPressed,
        pizzaPressed, kebabPressed, snacksPressed);
  }

  Future<http.Response> requestJsonFromBackEnd(
      String latitude, String longitude) async {
    String hamburger = hamburgerPressed.toString();
    String korv = korvPressed.toString();
    String pizza = pizzaPressed.toString();
    String kebab = kebabPressed.toString();
    String snacks = snacksPressed.toString();

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
        ";");

    print("Inuti tstKoppleMedSpring()-> printar latitude + LongitudeDAta");
    print(latitude + " " + longitude);

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

Future<PolylineResult> createPointsBetweenUserAndTarget(
    LatLng targetLatLng) async {
  LatLng userLatLng = _MapScreenState.getUserPos();
  PointLatLng targetLatLngPoint =
      PointLatLng(targetLatLng.latitude, targetLatLng.longitude);
  PointLatLng userLatLngPoint =
      PointLatLng(userLatLng.latitude, userLatLng.longitude);
  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult pointsBetweenUserAndTarget =
      await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyCTAeAanf7zvaO-XuF1--LeRGunC1w6Puw",
          userLatLngPoint,
          targetLatLngPoint,
          travelMode: TravelMode.walking);

  return pointsBetweenUserAndTarget;
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

void addPointsToRouteList(PolylineResult pointsBetweenUserAndTarget) {
  clearOldPolylinesFromMap();
  for (int i = 0; i < pointsBetweenUserAndTarget.points.length; i++) {
    _MapScreenState.routePointsList.add(LatLng(
        pointsBetweenUserAndTarget.points[i].latitude,
        pointsBetweenUserAndTarget.points[i].longitude));
  }
}

void clearOldPolylinesFromMap() {
  _MapScreenState.routePointsList.clear();
  _MapScreenState.polyline.clear();
}

void createPolyLine() {
  _MapScreenState.polyline.add(Polyline(
    polylineId: PolylineId('route1'),
    visible: true,
    points: _MapScreenState.routePointsList,
    width: 4,
    color: Colors.blue,
    startCap: Cap.roundCap,
    endCap: Cap.buttCap,
  ));
}

void setTargetLatLng(LatLng target) {
  _MapScreenState.targetLatLng = target;
}
